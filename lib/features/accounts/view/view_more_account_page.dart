// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/accounts/controller/function.dart';
import 'package:avex_mobile/features/accounts/view/section_widget/receive_bottom_sheet.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart';

final totalBalance = StateProvider<Map<String, String>>((ref) => {});
final totalBal = StateProvider<Map<String, double>>((ref) {
  ref.watch(accountListProvider);
  return {};
});

class ViewMoreAccountScreen extends ConsumerStatefulWidget {
  const ViewMoreAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ViewMoreAccountScreenState();
}

class _ViewMoreAccountScreenState extends ConsumerState<ViewMoreAccountScreen> {
  bool showHide = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return RefreshIndicator(
      onRefresh: () async =>
          ref.read(accountListProvider.notifier).fetchAllAccount(),
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(40, 128, 158, 1),
        body: SizedBox(
          width: size.width,
          height: size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 20)
                      .copyWith(top: 50),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        color: Colors.black,
                        height: 25,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Avex',
                        style: inter.copyWith(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Spacer(),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: Colors.white,
                        child: const Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Icon(
                            Icons.headset_mic_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.4 - 100,
                  width: size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Total Value',
                        style: inter.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                        ),
                      ),
                      Consumer(builder: (context, ref, child) {
                        final totalBalVal = ref.watch(totalBal);
                        double val = 0;
                        var values = totalBalVal.values.toList();
                        for (var value in values) {
                          val += value;
                        }
                        return Text(
                          '\$${val.toStringAsFixed(2)}',
                          style: inter.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 35,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(minHeight: size.height * 0.6),
                  width: size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(15, 14, 14, 1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 30),
                        SizedBox(
                          height: 50,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  fixedSize: const Size(80, 20),
                                ),
                                onPressed: () {
                                  SendTransactionScreenRoute().push(context);
                                },
                                child: const Text(' Send '),
                              ),
                              const Spacer(),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () =>
                                    setState(() => showHide = !showHide),
                                icon: Icon(
                                  Icons.visibility_rounded,
                                  size: 18,
                                  color: showHide ? Colors.white : Colors.grey,
                                ),
                              ),
                              Consumer(
                                builder: (ctx, ref, _) => IconButton(
                                  padding: const EdgeInsets.all(0),
                                  onPressed: () async {
                                    await ref
                                        .read(accountListProvider.notifier)
                                        .createAccount();
                                    showSnackBar(
                                        context, 'New account created');
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                              IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  ref
                                      .read(accountProvider.notifier)
                                      .deleteAccount(context: context);
                                },
                                icon: const Icon(Icons.delete, size: 18),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          child: Consumer(
                            builder: (context, ref, child) {
                              ref.watch(accountProvider
                                  .select((value) => value.current));
                              final accountList =
                                  ref.watch(accountListProvider);
                              final current = ref
                                  .read(accountProvider.notifier)
                                  .currentAccount;

                              return ListView.builder(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20)
                                        .copyWith(bottom: 0),
                                physics: const ClampingScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: accountList.length,
                                itemBuilder: (context, index) {
                                  final acc = accountList[index];
                                  return Visibility(
                                    visible: showHide || !acc.ishide,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                        side: BorderSide(
                                          color: current == index
                                              ? Colors.white
                                              : Colors.transparent,
                                        ),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      color:
                                          const Color.fromRGBO(34, 37, 41, 1),
                                      child: SizedBox(
                                        height: 70,
                                        child: InkWell(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            receiverBottomSheet(
                                                context, acc, index);
                                          },
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                leading: ClipOval(
                                                  child: Stack(
                                                    children: [
                                                      CachedNetworkImage(
                                                        imageUrl: Gravatar(
                                                          '${acc.ethAddress.substring(0, 6)}account$index@avex.com',
                                                        ).imageUrl(),
                                                        height: 35,
                                                        width: 35,
                                                      ),
                                                      Visibility(
                                                        visible: acc.ishide,
                                                        child:
                                                            const CircleAvatar(
                                                          radius: 35 * .5,
                                                          backgroundColor:
                                                              Colors.black45,
                                                          child: Icon(
                                                            Icons
                                                                .visibility_off_rounded,
                                                            size: 30,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                title: Text(
                                                  acc.name ??
                                                      'Account ${acc.id + 1}',
                                                  style: inter.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                    color: acc.ishide
                                                        ? Colors.grey.shade400
                                                        : Colors.grey.shade200,
                                                  ),
                                                ),
                                                trailing: AccountBalanceText(
                                                    acc: acc),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AccountBalanceText extends StatelessWidget {
  const AccountBalanceText({
    super.key,
    required this.acc,
  });

  final Account acc;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return ref.watch(allChainBalanceProvider(acc)).when(
              data: (data) {
                return Text(
                  '\$${data.toStringAsFixed(2)}',
                  style: urbunist.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                    color: Colors.white70,
                    letterSpacing: 1.2,
                  ),
                ).animate().scale();
              },
              error: (error, stackTrace) => const Text('Error'),
              loading: () => const Text('Loading')
                  .animate(
                onPlay: (c) => c.repeat(),
              )
                  .shimmer(duration: 1.seconds, colors: [
                Colors.grey.shade200,
                Colors.grey.shade300,
                Colors.grey.shade200
              ]),
            );
      },
    );
  }
}
