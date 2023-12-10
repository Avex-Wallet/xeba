import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/history/controllers/native_transaction.controller.dart';
import 'package:avex_mobile/features/nft/controllers/current_chain_nft.controller.dart';
import 'package:avex_mobile/main.dart';

class DashboardNetworkTab extends ConsumerWidget {
  const DashboardNetworkTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<NetworkChain> network = NetworkChain.values;

    return GestureDetector(
      onTap: () => showGeneralDialog(
        barrierDismissible: true,
        barrierLabel: '',
        // barrierColor: Colors.black38
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (ctx, anim1, anim2) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.zero,
          content: Consumer(builder: (context, ref, child) {
            final currentNetwork = ref.watch(currentNetworkChainProvider);
            final isAllChainSelected = ref.watch(allChainSelected);
            return Container(
              height: 500,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Network.values
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: const Icon(Icons.arrow_back_ios_new_rounded,
                              size: 16),
                        ),
                        Text(
                          'NETWORKS',
                          style: inter.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Divider(color: Colors.grey),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ListTile(
                            onTap: () {
                              ref
                                  .read(allChainSelected.notifier)
                                  .update((state) => true);
                              context.pop();
                            },
                            leading: SizedBox.square(
                              dimension: 40,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    foregroundImage: Assets.logoPng.provider(),
                                    backgroundColor: Colors.white,
                                  ),
                                  if (true)
                                    const Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(
                                        Icons.radio_button_checked_rounded,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            // title: Text(network.chainName),
                            title: Text(
                              'Show All',
                              style: isAllChainSelected
                                  ? inter.copyWith(
                                      color: Colors.yellow.shade100,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    )
                                  : null,
                            ),
                          ),
                          for (var networkItem in network)
                            if (!networkItem.isTestnet)
                              InkWell(
                                onTap: () async {
                                  ref
                                      .read(allChainSelected.notifier)
                                      .update((state) => false);
                                  ref
                                      .read(
                                          currentNetworkChainProvider.notifier)
                                      .update((state) => networkItem);
                                  ref
                                      .read(nftProvider.notifier)
                                      .fetchNFTs(context: context);
                                  ref
                                      .read(nativeTransactionProvider.notifier)
                                      .fetchData();
                                  context.pop();
                                },
                                child: ListTile(
                                  leading: SizedBox.square(
                                    dimension: 40,
                                    child: Stack(
                                      children: [
                                        ClipOval(
                                          child: networkItem.coinLogoURI
                                                  .endsWith('.svg')
                                              ? SvgPicture.network(
                                                  networkItem.coinLogoURI)
                                              : CachedNetworkImage(
                                                  imageUrl:
                                                      networkItem.coinLogoURI,
                                                ),
                                        ),
                                        if (currentNetwork == networkItem &&
                                            !isAllChainSelected)
                                          const Align(
                                            alignment: Alignment.bottomRight,
                                            child: Icon(
                                              Icons
                                                  .radio_button_checked_rounded,
                                              size: 20,
                                              color: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  // title: Text(network.chainName),
                                  title: Text(
                                    networkItem.name,
                                    style: networkItem == currentNetwork &&
                                            !isAllChainSelected
                                        ? inter.copyWith(
                                            color: Colors.yellow.shade100,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          )
                                        : null,
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
          elevation: 2,
        ),
        transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 4 * anim1.value, sigmaY: 4 * anim1.value),
          child: FadeTransition(
            opacity: anim1,
            child: child,
          ),
        ),
        context: context,
      ),
      child: Consumer(builder: (context, ref, child) {
        final currentNetwork = ref.watch(currentNetworkChainProvider);
        final isAllChainSelected = ref.watch(allChainSelected);
        return Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: const BorderRadius.all(
              Radius.circular(40.0),
            ),
            border: Border.all(
              color: Colors.white24,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                isAllChainSelected
                    ? Builder(
                        builder: (context) {
                          final chainList = NetworkChain.values
                              .where((element) => !element.isTestnet)
                              .toList()
                              .getRange(0, 6)
                              .toList()
                            ..add(NetworkChain.solanaMainnet);
                          return SizedBox(
                              width: 15.0 * 7.5,
                              child: Stack(
                                children: [
                                  for (int i = 0; i < 7; i++)
                                    Transform.translate(
                                      offset: Offset(15.0 * i, 0),
                                      child: CircleAvatar(
                                        radius: 11,
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: chainList[i].coinLogoURI,
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                      ),
                                    )
                                ].reversed.toList(),
                              ));
                        },
                      )
                        .animate(onPlay: (c) => c.repeat())
                        .shimmer(duration: 6.seconds, colors: [
                        Colors.transparent,
                        Colors.white38,
                        Colors.transparent,
                      ])
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: CachedNetworkImage(
                          imageUrl: currentNetwork.coinLogoURI,
                          width: 20,
                          height: 20,
                        ),
                      ),
                if (!isAllChainSelected) const SizedBox(width: 5),
                if (!isAllChainSelected)
                  Text(
                    currentNetwork.name.toUpperCase(),
                    style: inter.copyWith(fontSize: 12),
                  ),
              ],
            ),
          ),
        ).animate().flip();
      }),
    );
  }
}
