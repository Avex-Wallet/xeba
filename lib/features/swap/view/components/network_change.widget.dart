import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/main.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final swapNetworkProvider = StateProvider.autoDispose<NetworkChain>((ref) {
  final chain = ref.read(currentNetworkChainProvider);
  if (chain.isTestnet) return NetworkChain.ethereumMainnet;
  return chain;
});

class SwapNetworkTab extends ConsumerWidget {
  const SwapNetworkTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chain = ref.watch(swapNetworkProvider);
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Palette.secondary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              content: SizedBox(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Select Your Network'),
                    const Divider(),
                    SizedBox(
                      height: 350,
                      child: SingleChildScrollView(
                        child: Consumer(
                          builder: (context, ref, child) {
                            final chain = ref.watch(swapNetworkProvider);
                            return Column(
                              children: NetworkChain.values
                                  .map(
                                    (e) => e.isTestnet
                                        ? Container()
                                        : ListTile(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            onTap: () => ref
                                                .read(swapNetworkProvider
                                                    .notifier)
                                                .state = e,
                                            leading: ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl: e.coinLogoURI,
                                                height: 30,
                                                width: 30,
                                              ),
                                            ),
                                            title: Text(e.name),
                                            trailing: e == chain
                                                ? const Icon(Icons.done)
                                                : null,
                                          ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white10),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white.withOpacity(0.05),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipOval(
              child: CachedNetworkImage(
                imageUrl: chain.coinLogoURI,
                height: 25,
                width: 25,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              chain.name,
              style: inter.copyWith(),
            ),
          ],
        ),
      ),
    );
  }
}
