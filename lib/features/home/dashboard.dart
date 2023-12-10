import 'dart:math';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/home/bottom_navbar/home.dart';
import 'package:avex_mobile/features/home/drawer/drawer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/core/themes/themes.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/advance_send/adv_send.dart';
import 'package:avex_mobile/features/home/receive_bottom_sheet.dart';
import 'package:avex_mobile/features/home/widgets/account_card.dart';
import 'package:avex_mobile/features/home/widgets/home_tabs.dart';
import 'package:avex_mobile/features/home/widgets/sliver_app_bar_delegate.dart';
import 'package:avex_mobile/features/home/widgets/symbol_button.dart';
import 'package:avex_mobile/features/nft/views/screens/nft_tab.dart';
import 'package:avex_mobile/features/profile/view/your_profile.dart';
import 'package:avex_mobile/features/token/view/components/token_tab.dart';

List<String> tabsTexts = ["Tokens", "NFTs"];

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _sendReceivePagePosition = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);
    ref.read(accountProvider.notifier).init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const HomeBottomNavBar(),
      drawerEnableOpenDragGesture: false,
      drawer: const Drawer(
        elevation: 0,
        child: MainDrawer(),
      ),
      backgroundColor: Palette.background,
      extendBodyBehindAppBar: true,
      body: DefaultTabController(
        length: 2,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                  maxHeight: 80,
                  minHeight: 80,
                  child: Container(
                    color: Palette.background,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: AppBar(
                      leading: Container(
                        margin: const EdgeInsets.only(left: 15, right: 10),
                        child: GestureDetector(
                          onTap: () => _key.currentState!.openDrawer(),
                          child: ClipOval(
                            child: CachedNetworkImage(
                              height: 34,
                              width: 34,
                              imageUrl:
                                  "https://i.pinimg.com/564x/ef/d2/83/efd283abeeea8e0d29f8d1f58d7d77f6.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      actions: [
                        GestureDetector(
                          onTap: () {},
                          child: const Icon(
                            Icons.settings,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => ConnectedAppScreenRoute().push(context),
                          child: Assets.qrCode.image(),
                        ),
                        const SizedBox(width: 8),
                      ],
                      elevation: 0,
                      // centerTitle: true,
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 185,
                  maxHeight: 90,
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: AccountCard(),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 100,
                  maxHeight: 70,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: SizedBox(
                      height: 100,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (value) => setState(() {
                          _sendReceivePagePosition = value;
                        }),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  InAppWebviewRoute(
                                    title: 'Add Funds',
                                    $extra: 'https://global.transak.com/',
                                  ).push(context);
                                },
                                child: const SymbolButton(
                                    title: "Add Funds",
                                    icon: Icon(Icons.credit_card)),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    SendTransactionScreenRoute().push(context),
                                child: const SymbolButton(
                                    title: "Send",
                                    icon: Icon(Icons.arrow_outward)),
                              ),
                              GestureDetector(
                                onTap: () {
                                  receiverBottomSheet(
                                      ref: ref, context: context);
                                },
                                child: SymbolButton(
                                    title: "Receive",
                                    icon: Transform.rotate(
                                        angle: pi,
                                        child:
                                            const Icon(Icons.arrow_outward))),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SymbolButton(
                                  title: "Lend & Borrow",
                                  icon: Icon(Icons.credit_card)),
                              GestureDetector(
                                onTap: () => SwapScreenRoute().push(context),
                                child: const SymbolButton(
                                    title: "Swap",
                                    icon: Icon(Icons.credit_card)),
                              ),
                              GestureDetector(
                                onTap: () =>
                                    ConnectedAppScreenRoute().push(context),
                                child: const SymbolButton(
                                  title: "Connection",
                                  icon: Icon(
                                      Icons.connect_without_contact_rounded),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AdvancedSend(),
                                    )),
                                child: const SymbolButton(
                                    title: "Advanced Send",
                                    icon: Icon(Icons.send)),
                              ),
                              Opacity(
                                opacity: 1,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const YourProfile(),
                                      )),
                                  child: const SymbolButton(
                                      title: "Your Profile",
                                      icon: Icon(Icons.credit_card)),
                                ),
                              ),
                              Opacity(
                                opacity: 0,
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AdvancedSend(),
                                      )),
                                  child: const SymbolButton(
                                    title: "Advanced Send",
                                    icon: Icon(
                                        Icons.connect_without_contact_rounded),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: SliverAppBarDelegate(
                  minHeight: 37,
                  maxHeight: 37,
                  child: Column(
                    children: [
                      DotsIndicator(
                        dotsCount: 3,
                        position: _sendReceivePagePosition,
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 5.0),
                          activeColor: const Color(0xFF37CBFA),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0)),
                        ),
                      ),
                      const Divider(),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: SliverAppBarDelegate(
                    minHeight: 60,
                    maxHeight: 60,
                    child: Container(
                      height: 10,
                      color: Palette.background,
                      child: HomeTabs(
                        tabController: _tabController,
                      ),
                    )),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: const [
              TokenTabV2(),
              DashboardNFTTabV2(),
              //  : NftTab(),
            ],
          ),
        ),
      ),
    );
  }
}
