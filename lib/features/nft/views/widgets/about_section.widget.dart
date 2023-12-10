import 'package:avex_mobile/model/nft/nft_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutSectionWidget extends StatelessWidget {
  const AboutSectionWidget({
    super.key,
    required this.nftData,
  });

  final NFTModel nftData;

  @override
  Widget build(BuildContext context) {
    if (nftData.description == null) return Container();
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        // color: Colors.white12,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Icon(Icons.description_rounded, size: 14),
              Text(
                ' DESCRIPTION',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            nftData.description ?? 'NOT AVAILABLE',
            textAlign: TextAlign.left,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.white60,
            ),
          ),
        ],
      ),
    );
  }
}
