import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/token/controller/tokenlist_provider.dart';
import 'package:avex_mobile/features/token/view/widgets/token_tile.dart';
import 'package:avex_mobile/main.dart';
import 'package:avex_mobile/provider/connectivity_provider.dart';
import 'package:avex_mobile/services/local_services/db/token_db.dart';

class TokenTabV2 extends ConsumerWidget {
  const TokenTabV2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allChain = ref.watch(allChainSelected);
    final currentChain = ref.watch(currentNetworkChainProvider);
    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: [
        for (var i in (allChain ? NetworkChain.values : [currentChain]))
          Visibility(
            visible: i.isTestnet == false,
            child: ref.watch(allTokenListFutureProvider(i)).when(
                  error: (e, s) {
                    return Consumer(builder: (context, ref, child) {
                      final connectionStatus = ref.watch(connectivityProvider);
                      return switch (connectionStatus) {
                        ConnectivityStatus.isDisonnected =>
                          DbTokenList(chain: i),
                        _ => Container(),
                      };
                    });
                  },
                  loading: () => DbTokenList(chain: i),
                  data: (data) {
                    data.sort(
                      (a, b) {
                        if (a.native_token && !b.native_token) {
                          return -1;
                        } else if (!a.native_token && b.native_token) {
                          return 1;
                        } else {
                          return 0;
                        }
                      },
                    );
                    if (data.isEmpty) {
                      return Container();
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: data.map((e) => TokenTile(index: e)).toList(),
                      );
                    }
                  },
                ),
          ),
      ],
    );
  }
}

class DbTokenList extends StatelessWidget {
  const DbTokenList({
    super.key,
    required this.chain,
  });

  final NetworkChain chain;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final tokenFromDb = ref.watch(tokenDbListProvider(chain.chainId));
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: tokenFromDb.map((e) => TokenTile(index: e)).toList(),
        );
      },
    );
  }
}
