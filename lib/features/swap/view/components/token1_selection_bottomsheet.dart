import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/swap/controller/token1_controller.dart';
import 'package:avex_mobile/features/swap/view/components/network_change.widget.dart';
import 'package:avex_mobile/features/swap/view/components/token_tile.dart';
import 'package:avex_mobile/features/swap/view/widgets/loading_token_listview.dart';

Future token1SelectionBottomSheet(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  await showModalBottomSheet(
    backgroundColor: Palette.secondary,
    isScrollControlled: true,
    useRootNavigator: true,
    enableDrag: true,
    elevation: 3,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
    context: context,
    builder: (context) {
      return Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Consumer(
          builder: (context, ref, child) {
            return StatefulBuilder(
              builder: (context, newState) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // * Title Bar Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Opacity(
                            opacity: 0,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.close),
                            ),
                          ),
                          Text(
                            'Select an asset',
                            style: GoogleFonts.inter().copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              context.pop();
                            },
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      Consumer(builder: (context, ref, child) {
                        final chain = ref.watch(swapNetworkProvider);
                        return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              ...NetworkChain.values
                                  .map(
                                    (e) => e.isTestnet
                                        ? const Card()
                                        : GestureDetector(
                                            onTap: () => ref
                                                .read(swapNetworkProvider
                                                    .notifier)
                                                .state = e,
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                color: e == chain
                                                    ? Colors.white24
                                                    : null,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                              child: Text(e.name),
                                            ),
                                          ),
                                  )
                                  .toList(),
                              const SizedBox(width: 10),
                            ],
                          ),
                        );
                      }),
                      ClipRRect(
                        child: SizedBox(
                          height: 300,
                          width: MediaQuery.of(context).size.width,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final chain = ref.watch(swapNetworkProvider);
                              // final apiRes = ref.watch(swapTokenListProvider);
                              final apiRes =
                                  ref.watch(allTokenListFutureProvider(chain));
                              return RefreshIndicator(
                                onRefresh: () async =>
                                    ref.refresh(swapTokenListProvider),
                                child: Container(
                                  child: apiRes.when(
                                    error: (error, stackTrace) {
                                      logger.e(error);
                                      return const Center(
                                          child: Chip(label: Text('404')));
                                    },
                                    loading: () {
                                      return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: LoadingTokenListView(),
                                      );
                                    },
                                    data: (data) {
                                      data.sort((a, b) {
                                        if (a.native_token && !b.native_token) {
                                          return -1;
                                        } else if (!a.native_token &&
                                            b.native_token) {
                                          return 1;
                                        } else {
                                          return 0;
                                        }
                                      });
                                      if (data.isEmpty) {
                                        return const Card();
                                      } else {
                                        return SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return TokenTile(
                                                index: data.elementAt(index),
                                              );
                                            },
                                            itemCount: data.length,
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      );
    },
  );
  controller.dispose();
}
