import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/home/current_network_chain/views/dashboard_network_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../dashboard.dart';

class HomeTabs extends ConsumerWidget {
  const HomeTabs({required this.tabController, super.key});
  final TabController tabController;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      // color: Colors.black,
      color: Palette.background,
      child: Align(
        alignment: Alignment.topLeft,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TabBar(
                enableFeedback: false,
                isScrollable: true,
                splashFactory: NoSplash.splashFactory,
                automaticIndicatorColorAdjustment: true,
                indicatorSize: TabBarIndicatorSize.label,
                unselectedLabelStyle: const TextStyle(color: Colors.black54),
                controller: tabController,
                indicatorColor: const Color(0xFF338BAA),
                tabs: tabsTexts
                    .map((e) => Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              e,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: const Color(0xFFFEFEFF),
                                  ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
              const Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [DashboardNetworkTab()],
                ),
              ),
              const SizedBox(
                width: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
