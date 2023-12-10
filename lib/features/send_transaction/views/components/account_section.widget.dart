import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/send_transaction/views/components/change_network.dart';
import 'package:avex_mobile/services/local_services/db/account_db.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class AccountSectionWidget extends StatelessWidget {
  const AccountSectionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle inter = GoogleFonts.inter();
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => changeAccount(context),
      child: Container(
        height: 50,
        width: size.width,
        margin: const EdgeInsets.symmetric(horizontal: 16).copyWith(top: 12),
        padding: const EdgeInsets.all(5),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff2C2B32)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Consumer(builder: (context, ref, child) {
          final current =
              ref.watch(accountProvider.select((value) => value.current));
          final account = ref.watch(accountListProvider).elementAt(current);
          logger.e(account);
          return Row(
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl:
                      Gravatar('${account.ethAddress.substring(30)}@avex.com')
                          .imageUrl(),
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    'Account ${current + 1}',
                    style: inter.copyWith(fontSize: 14),
                  ),
                  Text(
                    shortAddress(account.ethAddress, i: 8),
                    style: inter.copyWith(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_drop_down_outlined),
              const SizedBox(width: 8),
            ],
          );
        }),
      ),
    );
  }
}
