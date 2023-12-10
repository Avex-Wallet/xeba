import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/core/themes/palette.dart';
// ignore: unused_import
import 'package:avex_mobile/features/send_nft/view/send_nft_screen.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:flutter/material.dart';

class NftControllerSectionWidget extends StatelessWidget {
  const NftControllerSectionWidget(
      {super.key, required this.nftData, required this.share});

  final NFTModel nftData;
  final Future<void> Function() share;

  @override
  Widget build(BuildContext context) {
    ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
      fixedSize: const Size.fromHeight(40),
      backgroundColor: Palette.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GridView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          childAspectRatio: 4.5,
          mainAxisSpacing: 16,
        ),
        children: [
          ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () => SendNFTScreenRoute(nftData).push(context),
            child: const Text('Send'),
          ),
          ElevatedButton(
            style: elevatedButtonStyle,
            onPressed: () async => await share(),
            child: const Text('Share'),
          ),
          // Consumer(builder: (context, ref, child) {
          //   final chain = ref.watch(currentNetworkChainProvider);
          //   return ElevatedButton(
          //     style: elevatedButtonStyle,
          //     onPressed: () {
          //       context.pushNamed(
          //         RouterConstant.inAppWebview.name,
          //         extra:
          //             'https://opensea.io/assets/${chain.name.toLowerCase()}/${nftData.contract_address}/${nftData.token_id}',
          //         pathParameters: {'title': 'OpenSea'},
          //       );
          //     },
          //     child: const Text('View on Opensea'),
          //   );
          // }),
          // Consumer(builder: (context, ref, child) {
          //   return ElevatedButton(
          //     style: elevatedButtonStyle,
          //     onPressed: () {
          //       context.pushNamed(
          //         RouterConstant.inAppWebview.name,
          //         extra:
          //             'https://etherscan.io/address/${nftData.contract_address ?? ''}',
          //         pathParameters: {'title': 'Block Explorer'},
          //       );
          //     },
          //     child: const Text('View on explorer'),
          //   );
          // }),
        ],
      ),
    );
  }
}
