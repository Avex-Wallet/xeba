// ignore_for_file: unused_element

import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:avex_mobile/features/connected_app/dependencies/bottom_sheet/bottom_sheet_listener.dart';
import 'package:avex_mobile/features/connected_app/models/page_data.dart';
import 'package:avex_mobile/features/connected_app/pages/apps_page.dart';
import 'package:avex_mobile/features/connected_app/utils/constants.dart';
import 'package:avex_mobile/features/connected_app/utils/string_constants.dart';

import '../../core/themes/palette.dart';

class ConnectedAppScreen extends StatefulWidget with GetItStatefulWidgetMixin {
  static String routeName = 'ConnectAppScreen';
  static String routePath = '/connect-app';
  ConnectedAppScreen({super.key});

  @override
  State<ConnectedAppScreen> createState() => _ConnectedAppScreenState();
}

class _ConnectedAppScreenState extends State<ConnectedAppScreen>
    with GetItStateMixin {
  bool _initializing = true;

  List<PageData> _pageDatas = [];
  int _selectedIndex = 0;

  // SessionData? _selectedSession;
  // List<SessionData> _allSessions = [];
  // List<PairingInfo> _allPairings = [];

  @override
  void initState() {
    initialize();

    // _web3Wallet!.onSessionConnect.subscribe(_onSessionConnect);

    super.initState();
  }

  @override
  void dispose() {
    // _web3Wallet!.onSessionConnect.unsubscribe(_onSessionConnect);

    super.dispose();
  }

  Future<void> initialize() async {
    // GetIt.I.registerSingleton<IBottomSheetService>(BottomSheetService());
    // GetIt.I.registerSingleton<IKeyService>(KeyService());
    // final IWeb3WalletService web3WalletService = Web3WalletService();
    // web3WalletService.create();
    // GetIt.I.registerSingleton<IWeb3WalletService>(web3WalletService);

    // for (final cId in KadenaChainId.values) {
    //   GetIt.I.registerSingleton<IChain>(
    //     KadenaService(reference: cId),
    //     instanceName: cId.chain,
    //   );
    // }
    // for (final cId in EVMChainId.values) {
    //   GetIt.I.registerSingleton<IChain>(
    //     EVMService(reference: cId),
    //     instanceName: cId.chain(),
    //   );
    // }

    // await web3WalletService.init();

    setState(() {
      _pageDatas = [
        PageData(
          page: AppsPage(),
          title: StringConstants.connectPageTitle,
          icon: Icons.home,
        ),
        PageData(
          page: const Center(
            child: Text(
              'Notifications (Not Implemented)',
              style: StyleConstants.bodyText,
            ),
          ),
          title: StringConstants.pairingsPageTitle,
          icon: Icons.notifications,
        ),
        // PageData(
        //   page: SessionsPage(web3App: _web3App!),
        //   title: StringConstants.sessionsPageTitle,
        //   icon: Icons.confirmation_number_outlined,
        // ),
        // PageData(
        //   page: AuthPage(web3App: _web3App!),
        //   title: StringConstants.authPageTitle,
        //   icon: Icons.lock,
        // ),
      ];

      _initializing = false;
    });
    // } on WalletConnectError catch (e) {
    //   //print(e.message);
    // }
  }

  @override
  Widget build(BuildContext context) {
    // GetIt.I<IBottomSheetService>().setDefaultContext(context);

    if (_initializing) {
      return const Center(
        child: CircularProgressIndicator(
          color: StyleConstants.primaryColor,
        ),
      );
    }

    final List<Widget> navRail = [];
    if (MediaQuery.of(context).size.width >= Constants.smallScreen) {
      navRail.add(_buildNavigationRail());
    }
    navRail.add(
      Expanded(
        child: _pageDatas[_selectedIndex].page,
      ),
    );

    return Scaffold(
      backgroundColor: Palette.background,
      // appBar: AppBar(
      //   title: Text(_pageDatas[_selectedIndex].title),
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   actions: [
      //     IconButton(
      //       onPressed: () {},
      //       icon: const Icon(Icons.copy_all),
      //     ),
      //     IconButton(
      //       onPressed: () async {
      //         final String? s =
      //             await context.pushNamed(RouterConstant.qrScreen.name);
      //         logger.e(s ?? 'nothing');
      //       },
      //       icon: const Icon(Icons.qr_code_2),
      //     ),
      //     const SizedBox(width: 10),
      //   ],
      // ),
      // bottomNavigationBar:
      //     MediaQuery.of(context).size.width < Constants.smallScreen
      //         ? _buildBottomNavBar()
      //         : null,
      body: BottomSheetListener(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: navRail,
        ),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.indigoAccent,
      // called when one tab is selected
      onTap: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      // bottom tab items
      items: _pageDatas
          .map(
            (e) => BottomNavigationBarItem(
              icon: Icon(e.icon),
              label: e.title,
            ),
          )
          .toList(),
    );
  }

  Widget _buildNavigationRail() {
    return NavigationRail(
      // backgroundColor: StyleConstants.backgroundColor,
      selectedIndex: _selectedIndex,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
      labelType: NavigationRailLabelType.selected,
      destinations: _pageDatas
          .map(
            (e) => NavigationRailDestination(
              icon: Icon(e.icon),
              label: Text(e.title),
            ),
          )
          .toList(),
    );
  }
}
