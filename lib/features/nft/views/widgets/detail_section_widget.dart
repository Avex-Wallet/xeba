// ignore_for_file: dead_code

import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailSectionWidget extends StatelessWidget {
  const DetailSectionWidget({
    super.key,
    required this.nftData,
  });

  final NFTModel nftData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Builder(builder: (context) {
        String short(String? address) {
          if (address == null) {
            return '0x000...0000';
          } else {
            return '${address.substring(0, 10)}....${address.substring(address.length - 10)}';
          }
        }

        final tokenId = nftData.token_id ?? '';
        final list = [
          [
            'Network',
            nftData.chain?.toUpperCase() ?? '--',
          ],
          ['Contract Address', short(nftData.contract_address)],
          if (tokenId == 'token_id')
            [
              'Token ID',
              '${tokenId.length > 20 ? '${tokenId.substring(0, 20)}...' : nftData.token_id}'
            ],
          if (false) ['Send', 'xxxx'],
          ['Status', (nftData.status ?? '').toUpperCase()]
        ];

        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(Icons.account_balance_wallet_rounded, size: 14),
                Text(
                  ' ADDITIONAL INFO',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: list
                  .map(
                    (element) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            element.first,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            element.last,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        );
      }),
    );
  }
}
