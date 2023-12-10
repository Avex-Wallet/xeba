// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:avex_mobile/services/local_services/db/account_db.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/send_transaction/controllers/function.dart';
import 'package:avex_mobile/main.dart';

Future<dynamic> changeAccount(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(20),
      ),
    ),
    builder: (context) => Consumer(
      builder: (context, ref, child) {
        final accountList = ref.watch(accountListProvider);
        final current =
            ref.watch(accountProvider.select((value) => value.current));
        final account = accountList.elementAt(current);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              AppBar(
                elevation: 0,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () => context.pop(),
                  child: const Icon(Icons.arrow_back),
                ),
                title: const Text('Select your account'),
              ),
              ListView.builder(
                physics: const ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: accountList.length,
                padding: const EdgeInsets.only(bottom: 20),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: current == index
                              ? Colors.white
                              : Colors.transparent),
                    ),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: const Color.fromRGBO(34, 37, 41, 1),
                    child: GestureDetector(
                      onTap: () async {
                        HapticFeedback.mediumImpact();
                        if (!(await ref
                            .read(accountProvider.notifier)
                            .changeAddress(index))) return;
                        showSnackBar(
                            context, 'Active account set to ${index + 1}');
                        context.pop();
                      },
                      child: ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        visualDensity: const VisualDensity(vertical: -2),
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: Gravatar(
                                    '${account.ethAddress.substring(0, 6)}account$index@avex.com')
                                .imageUrl(),
                            height: 40,
                            width: 40,
                          ),
                        ),
                        title: Text(
                          shortAddress(account.ethAddress, i: 6),
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        subtitle: Text(
                          'Account ${index + 1}',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        trailing: Consumer(builder: (context, ref, c) {
                          final chain = ref.watch(currentNetworkChainProvider);

                          return FutureBuilder<String>(
                            future: getBalance(account.ethAddress, index, ref),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final data = snapshot.data ?? '0';
                                final value = BigInt.parse(data) /
                                    BigInt.from(pow(10, 18));
                                return Text(
                                  '${value == 0 ? value.toStringAsFixed(2) : value.toStringAsFixed(4)} ${chain.coinSymbol}',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                );
                              } else {
                                return Text(
                                  '',
                                  style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              }
                            },
                          );
                        }),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    ),
  );
}
