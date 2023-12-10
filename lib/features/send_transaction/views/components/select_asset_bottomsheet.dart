import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/send_transaction/controllers/send_token.dart';
import 'package:avex_mobile/features/send_transaction/views/components/send_token_tile.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/features/token/view/widgets/only_native_token_widget.dart';

final sendNetworkProvider =
    StateProvider<NetworkChain>((ref) => NetworkChain.ethereumMainnet);

Future<TokenModel?> showBottomScrollAssetsSheet(BuildContext context) async {
  TextEditingController controller = TextEditingController();
  TokenModel? token;
  token = await showModalBottomSheet(
    backgroundColor: Colors.grey.shade900,
    isScrollControlled: true,
    useRootNavigator: true,
    enableDrag: true,
    elevation: 3,
    shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.0))),
    context: context,
    builder: (context) {
      final size = MediaQuery.of(context).size;
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
                              // controller.dispose();
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.close),
                          )
                        ],
                      ),
                      // TextField(
                      //   controller: controller,
                      //   decoration: InputDecoration(
                      //     filled: true,
                      //     fillColor: Colors.white12,
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //   ),
                      // ),
                      Consumer(builder: (context, ref, child) {
                        final chain = ref.watch(sendNetworkProvider);
                        return SizedBox(
                          height: 50,
                          width: size.width,
                          child: Row(
                            children: [
                              Expanded(
                                child: ListView.separated(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: NetworkChain.values.length,
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(width: 10),
                                  itemBuilder: (context, index) {
                                    final network =
                                        NetworkChain.values.elementAt(index);
                                    return TextButton(
                                      onPressed: () => ref
                                          .read(sendNetworkProvider.notifier)
                                          .update((state) => network),
                                      child: Text(
                                        network.name,
                                        style: inter.copyWith(
                                          fontSize: 16,
                                          color: network != chain
                                              ? Colors.white38
                                              : Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.white24,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                      ClipRRect(
                        child: SizedBox(
                          height: 350,
                          width: MediaQuery.of(context).size.width,
                          child: Consumer(
                            builder: (context, ref, child) {
                              final Size size = MediaQuery.of(context).size;
                              final chain = ref.watch(sendNetworkProvider);
                              // final apiRes = ref.watch(sendTokenListProvider);
                              final apiRes =
                                  ref.watch(allTokenListFutureProvider(chain));

                              return RefreshIndicator(
                                onRefresh: () async =>
                                    ref.refresh(sendTokenListProvider),
                                child: Container(
                                  child: apiRes.when(
                                    error: (error, stackTrace) {
                                      logger.e('$error \n$stackTrace');
                                      return ListView(
                                        shrinkWrap: true,
                                        children: const [],
                                      );
                                    },
                                    loading: () {
                                      return const Center(
                                        child: CircularProgressIndicator(),
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
                                        return EmptyTokenList(chain: chain);
                                      } else {
                                        return SizedBox(
                                          width: size.width,
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () => context
                                                    .pop(data.elementAt(index)),
                                                child: SendTokenTile(
                                                  index: data.elementAt(index),
                                                ),
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
  return token;
}
