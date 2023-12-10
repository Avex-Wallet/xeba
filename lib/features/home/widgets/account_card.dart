// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/core/assets/assets.gen.dart';
import 'package:avex_mobile/core/constants/api_endpoints.dart';
import 'package:avex_mobile/core/utils/functions.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/provider/total_balance_provider.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';

final _usernameProvider = FutureProvider((ref) async {
  final accessToken = await SecureStorage.accessToken.value;
  var headers = {'Authorization': 'Bearer $accessToken'};
  return await http
      .get(Uri.parse(ApiEndpoint.getUserName), headers: headers)
      .then((value) => jsonDecode(value.body))
      .then((data) => data["username"].first);
});

class AccountCard extends ConsumerWidget {
  const AccountCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final publicKey = ref
    //     .watch(homeStateNortifierProvider.select((value) => value.myPublicKey));
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: Column(
        children: [
          Container(
            color: const Color(0xFF37CBFA),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        children: [
                          Text(
                            "\$",
                            style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w500, fontSize: 40),
                          ),
                          Consumer(builder: (context, ref, child) {
                            // double value = 0;
                            final value = ref.watch(totalBalanceProvider);
                            return Text(
                              value.toStringAsFixed(2),
                              style: GoogleFonts.urbanist(
                                fontWeight: FontWeight.w500,
                                fontSize: 40,
                              ),
                            );
                            //   return ref.watch(tokenListFutureProvider).when(
                            //         data: (data) {
                            //           for (var i in data) {
                            //             value += i.quote;
                            //           }
                            //           return Text(
                            //             value.toStringAsFixed(2),
                            //             style: GoogleFonts.urbanist(
                            //               fontWeight: FontWeight.w500,
                            //               fontSize: 40,
                            //             ),
                            //           );
                            //         },
                            //         error: (e, s) => Text(
                            //           value.toStringAsFixed(2),
                            //           style: GoogleFonts.urbanist(
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 40,
                            //           ),
                            //         ),
                            //         loading: () => Text(
                            //           value.toStringAsFixed(2),
                            //           style: GoogleFonts.urbanist(
                            //             fontWeight: FontWeight.w500,
                            //             fontSize: 40,
                            //           ),
                            //         ),
                            //       );
                          }),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Assets.logoPng.image(
                            fit: BoxFit.cover,
                            height: 40,
                            width: 40,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Consumer(builder: (context, ref, child) {
                    final current = ref.watch(
                        accountProvider.select((value) => value.current));
                    return Text(
                      "Account ${current + 1}",
                      style: GoogleFonts.urbanist(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    );
                  }),
                  Consumer(builder: (context, ref, child) {
                    final address = ref.watch(
                        accountProvider.select((value) => value.address));
                    final username = ref.watch(_usernameProvider);
                    return GestureDetector(
                      onTap: () async {
                        await Clipboard.setData(ClipboardData(text: address));
                        showSnackBar(
                            context, 'Copied ${shortAddress(address)}');
                      },
                      child: Row(
                        children: [
                          username.when(
                            data: (data) => Text(
                              shortAddress(data),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            error: (error, stackTrace) => Text(
                              shortAddress(address),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            loading: () => Text(
                              shortAddress(address),
                              style: GoogleFonts.inter(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Icon(
                            Icons.copy,
                            size: 15,
                          )
                        ],
                      ),
                    );
                  })
                ],
              ),
            ),
          ),
          Container(
            color: const Color(0xFF222529),
            child: InkWell(
              onTap: () => ViewMoreAccountsRoute().push(context),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Text(
                    "View more accounts",
                    style: GoogleFonts.urbanist(
                        fontWeight: FontWeight.w500, fontSize: 15),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
