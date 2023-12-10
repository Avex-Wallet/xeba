import 'package:avex_mobile/features/swap/controller/possible_connection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/swap/controller/search.controller.dart';
import 'package:avex_mobile/features/swap/view/pages/swap_screen.dart';
import 'package:avex_mobile/model/token/token_model.dart';

Future token2SelectionBox(
    BuildContext context, TextEditingController controller) async {
  return showModalBottomSheet(
    backgroundColor: Palette.secondary,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      Size size = MediaQuery.of(context).size;

      return Container(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(
          builder: (context, setState) {
            return Consumer(
              builder: (context, ref, child) {
                final searchTokenListP = ref.watch(searchTokenProvider);
                final searchTokenList = searchTokenListP.$1;
                return Container(
                  height: size.height * 0.5,
                  width: size.width,
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(width: 20),
                          Text(
                            'Select an asset',
                            style: inter.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pop(),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      StatefulBuilder(
                        builder: (context, newState) {
                          return TextField(
                            controller: controller,
                            onSubmitted: (value) {
                              ref
                                  .read(searchTokenProvider.notifier)
                                  .search(q: value);
                            },
                            onTapOutside: (_) =>
                                FocusScope.of(context).unfocus(),
                            magnifierConfiguration:
                                const TextMagnifierConfiguration(
                              shouldDisplayHandlesInMagnifier: false,
                            ),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              constraints: const BoxConstraints(maxHeight: 40),
                              prefixIcon: const Icon(
                                Icons.search,
                                size: 20,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              hintText: 'Search',
                              hintStyle: inter.copyWith(fontSize: 14),
                            ),
                          );
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        width: size.width,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Consumer(builder: (context, ref, child) {
                            final chainTabIndex =
                                ref.watch(chainTabIndexProvider);
                            const chains = NetworkChain.values;
                            return Row(
                              children: [
                                for (int i = 0; i < chains.length; i++)
                                  chains[i].isTestnet
                                      ? Container()
                                      : GestureDetector(
                                          onTap: () {
                                            print(i);
                                            ref
                                                .read(chainTabIndexProvider
                                                    .notifier)
                                                .update((state) => i);
                                            controller.clear();
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 5),
                                            decoration: BoxDecoration(
                                              color: i == chainTabIndex
                                                  ? Colors.white24
                                                  : null,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Text(chains[i].name),
                                          ),
                                        )
                              ],
                            );
                          }),
                        ),
                      ),
                      if (searchTokenList.isEmpty && searchTokenListP.$2)
                        const Expanded(child: LoadingAsset())
                      else
                        Expanded(
                          child: Consumer(
                            builder: (context, ref, child) {
                              final token1 = ref.watch(token1Provider);
                              final chain = ref.watch(chainTabIndexProvider);
                              if (token1 == null) {
                                return Container();
                              }
                              return ref
                                  .watch(possibleConnectionProviderT(token1))
                                  .when(
                                      error: (error, stackTrace) {
                                        if (chain == 19) {
                                          return Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                onTap: () {
                                                  ref
                                                      .read(token2Provider
                                                          .notifier)
                                                      .state = (
                                                    TokenModel(
                                                      contract_decimals: 18,
                                                      contract_name:
                                                          'Globiance Exchange',
                                                      contract_ticker_symbol:
                                                          'GBEX',
                                                      contract_address:
                                                          '0x00000000000000000000000000000000000000',
                                                      logo_url:
                                                          'https://assets.coingecko.com/coins/images/24859/standard/gbex.png?1696524019',
                                                      last_transferred_at: "",
                                                      native_token: false,
                                                      type: '',
                                                      is_spam: false,
                                                      balance: '',
                                                      quote_rate: '4.697511',
                                                      quote: 0,
                                                      pretty_quote: '\$0',
                                                    ),
                                                    NetworkChain.values
                                                        .firstWhere((element) =>
                                                            element.chainId ==
                                                            50),
                                                  );
                                                  context.pop();
                                                },
                                                leading: ClipOval(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://assets.coingecko.com/coins/images/24859/standard/gbex.png?1696524019',
                                                      height: 40,
                                                      width: 40,
                                                      errorWidget:
                                                          (context, e, s) =>
                                                              CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Assets.logoPng
                                                            .image(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                title: const Text(
                                                    'Globiance Exchange'),
                                                subtitle: const Text('GREX'),
                                                trailing: Text(
                                                    '\$${double.parse('0.000000058680').toStringAsFixed(4)}'),
                                              ),
                                              //!ERROR
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                onTap: () {
                                                  ref
                                                      .read(token2Provider
                                                          .notifier)
                                                      .state = (
                                                    TokenModel(
                                                      contract_decimals: 18,
                                                      contract_name:
                                                          'Stasis Euro',
                                                      contract_ticker_symbol:
                                                          'EURS',
                                                      contract_address:
                                                          '0x00000000000000000000000000000000000000',
                                                      logo_url:
                                                          'https://assets.coingecko.com/coins/images/5164/standard/EURS_300x300.png?1696505680',
                                                      last_transferred_at: "",
                                                      native_token: false,
                                                      type: '',
                                                      is_spam: false,
                                                      balance: '',
                                                      quote_rate: '1.06',
                                                      quote: 0,
                                                      pretty_quote: '\$0',
                                                    ),
                                                    NetworkChain.values
                                                        .firstWhere((element) =>
                                                            element.chainId ==
                                                            50),
                                                  );
                                                  context.pop();
                                                },
                                                leading: ClipOval(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://assets.coingecko.com/coins/images/5164/standard/EURS_300x300.png?1696505680',
                                                      height: 40,
                                                      width: 40,
                                                      errorWidget:
                                                          (context, e, s) =>
                                                              CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Assets.logoPng
                                                            .image(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                title:
                                                    const Text('Stasis Euro'),
                                                subtitle: const Text('EURS'),
                                                trailing: Text(
                                                    '\$${double.parse('1.06').toStringAsFixed(4)}'),
                                              ),
                                              //!ERROR
                                              ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                onTap: () {
                                                  ref
                                                      .read(token2Provider
                                                          .notifier)
                                                      .state = (
                                                    TokenModel(
                                                      contract_decimals: 18,
                                                      contract_name: 'StorX',
                                                      contract_ticker_symbol:
                                                          'SRX',
                                                      contract_address:
                                                          '0x00000000000000000000000000000000000000',
                                                      logo_url:
                                                          'https://assets.coingecko.com/coins/images/16922/standard/StorX_Logo_white_300x300-01.png?1696516493',
                                                      last_transferred_at: "",
                                                      native_token: false,
                                                      type: '',
                                                      is_spam: false,
                                                      balance: '',
                                                      quote_rate: '0.03754905',
                                                      quote: 0,
                                                      pretty_quote: '\$0',
                                                    ),
                                                    NetworkChain.values
                                                        .firstWhere((element) =>
                                                            element.chainId ==
                                                            50),
                                                  );
                                                  context.pop();
                                                },
                                                leading: ClipOval(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          'https://assets.coingecko.com/coins/images/16922/standard/StorX_Logo_white_300x300-01.png?1696516493',
                                                      height: 40,
                                                      width: 40,
                                                      errorWidget:
                                                          (context, e, s) =>
                                                              CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Assets.logoPng
                                                            .image(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                title: const Text('StorX'),
                                                subtitle: const Text('SRX'),
                                                trailing: Text(
                                                    '\$${double.parse('0.03754905').toStringAsFixed(4)}'),
                                              )
                                            ],
                                          );
                                        } else {
                                          return const Center(
                                              child: Text('404'));
                                        }
                                      },
                                      loading: () => const LoadingAsset(),
                                      data: (possibleConnect) {
                                        return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: searchTokenList.length,
                                          itemBuilder: (context, index) {
                                            final d = searchTokenList[index];
                                            if (!possibleConnect
                                                .contains(d.address)) {
                                              return Container();
                                            } else {
                                              return ListTile(
                                                contentPadding:
                                                    const EdgeInsets.all(0),
                                                onTap: () {
                                                  ref
                                                      .read(token2Provider
                                                          .notifier)
                                                      .state = (
                                                    TokenModel(
                                                      contract_decimals:
                                                          d.decimals,
                                                      contract_name: d.name,
                                                      contract_ticker_symbol:
                                                          d.symbol,
                                                      contract_address:
                                                          d.address,
                                                      logo_url: d.logoURI,
                                                      last_transferred_at: "",
                                                      native_token: d.address
                                                          .startsWith(
                                                              '0x000000000000000000000000000000'),
                                                      type: '',
                                                      is_spam: false,
                                                      balance: '',
                                                      quote_rate: d.priceUSD,
                                                      quote: 0,
                                                      pretty_quote: '\$0',
                                                    ),
                                                    NetworkChain.values
                                                        .firstWhere((element) =>
                                                            element.chainId ==
                                                            d.chainId),
                                                  );
                                                  context.pop();
                                                },
                                                leading: ClipOval(
                                                  child: CircleAvatar(
                                                    backgroundColor:
                                                        Colors.white,
                                                    child: CachedNetworkImage(
                                                      imageUrl:
                                                          searchTokenList[index]
                                                              .logoURI,
                                                      height: 40,
                                                      width: 40,
                                                      errorWidget:
                                                          (context, e, s) =>
                                                              CircleAvatar(
                                                        radius: 20,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Assets.logoPng
                                                            .image(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                title: Text(
                                                    searchTokenList[index]
                                                        .name),
                                                subtitle: Text(
                                                    searchTokenList[index]
                                                        .symbol),
                                                trailing: Text(
                                                    '\$${double.parse(searchTokenList[index].priceUSD).toStringAsFixed(4)}'),
                                              );
                                            }
                                          },
                                        );
                                      });
                            },
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
}

class LoadingAsset extends StatelessWidget {
  const LoadingAsset({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          leading: ClipOval(
            child: Shimmer.fromColors(
              baseColor: Colors.grey,
              highlightColor: Colors.blueGrey,
              child: CircleAvatar(
                radius: 20,
                child: Image.asset('assets/logo.png'),
              ),
            ),
          ),
          title: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.blueGrey,
            child: const Text('TOKEN'),
          ),
          subtitle: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.blueGrey,
            child: const Text('SYMBOL'),
          ),
          trailing: Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.blueGrey,
            child: const Text('\$ USD PRICE'),
          ),
        );
      },
    );
  }
}
