// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/connected_app/init_function.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage(this.child, {super.key});
  final Widget child;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    try {
      initWalletConnect(ref);
    } catch (_) {}
  }

  Future<bool> showExitPopup() async {
    return await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Exit Avex'),
            content: const Text('Do you want to exit an App?'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: const Text('Yes'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        body: widget.child,
      ),
    );
  }
}

class HomeBottomNavBar extends StatefulWidget {
  const HomeBottomNavBar({super.key});

  @override
  State<HomeBottomNavBar> createState() => _HomeBottomNavBarState();
}

class _HomeBottomNavBarState extends State<HomeBottomNavBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int getCurrentIndex(BuildContext context) {
      final String location = GoRouterState.of(context).uri.toString();
      if (location == '/browser')
        return 0;
      else if (location == '/message')
        return 1;
      else if (location == '/history')
        return 3;
      else if (location == '/setting')
        return 4;
      else
        return 2;
    }

    return BottomNavigationBar(
      onTap: (index) {
        context.go(switch (index) {
          0 => '/browser',
          1 => '/message',
          2 => '/main',
          3 => '/history',
          4 => '/setting',
          _ => '/main',
        });
        setState(() {});
      },
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white30,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Palette.background,
      type: BottomNavigationBarType.fixed,
      currentIndex: getCurrentIndex(context),
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/Search.png',
            color: getCurrentIndex(context) == 0 ? Colors.blue : Colors.white,
          ),
          label: "Search",
        ),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/messagetext1.png',
              color: getCurrentIndex(context) == 1 ? Colors.blue : Colors.white,
            ),
            label: "Message"),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/Wallet.png',
              color: getCurrentIndex(context) == 2 ? Colors.blue : Colors.white,
            ),
            label: "Home"),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/notification.png',
              color: getCurrentIndex(context) == 3 ? Colors.blue : Colors.white,
            ),
            label: "Notification"),
        BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/setting2.png',
              color: getCurrentIndex(context) == 4 ? Colors.blue : Colors.white,
            ),
            label: "Settings"),
      ],
    );
  }
}
