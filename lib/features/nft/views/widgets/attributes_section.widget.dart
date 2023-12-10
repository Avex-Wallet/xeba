import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:avex_mobile/core/core.dart';

class AttributeSectionWidget extends StatelessWidget {
  const AttributeSectionWidget({required this.attributes, super.key});
  final List<String>? attributes;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if (attributes == null || (attributes?.isEmpty ?? true)) return Container();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.width,
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
                  const Icon(Icons.account_balance_wallet_rounded, size: 15),
                  Text(
                    ' ATTRIBUTES',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: [
                  for (int index = 0;
                      index < (attributes?.length ?? 0);
                      index++)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            jsonDecode(attributes![index])['trait_type'] ?? '',
                            style: inter.copyWith(
                                fontSize: 12, color: Colors.white70),
                          ),
                          Text(
                            jsonDecode(attributes![index])['value'] ?? '',
                            style: inter.copyWith(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4)
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
