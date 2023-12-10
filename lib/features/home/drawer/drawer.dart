// ignore_for_file: unused_element

import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/auth/username/service/user_service.dart';
import 'package:avex_mobile/features/profile/view/your_profile.dart';

final _username = FutureProvider<Either<String, String>>((ref) async {
  final usernameService = ref.watch(userServiceProvider);
  final accessToken = await SecureStorage.accessToken.value;
  return usernameService.getUserName(accessToken: accessToken);
});

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.background,
      padding: const EdgeInsets.only(left: 20, top: 20),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 15),
                Assets.logoPng.image(
                  height: 30,
                ),
                const SizedBox(width: 10),
                Text(
                  'Avex',
                  style: inter.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Account
            Container(
              height: 80,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 30).copyWith(
                right: 15,
              ),
              decoration: BoxDecoration(
                color: Palette.secondary,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      height: 60,
                      width: 60,
                      imageUrl:
                          "https://i.pinimg.com/564x/ef/d2/83/efd283abeeea8e0d29f8d1f58d7d77f6.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () => ViewMoreAccountsRoute().push(context),
                        child: Row(
                          children: [
                            Consumer(builder: (context, ref, child) {
                              final account = ref.watch(accountProvider);
                              return Text(
                                'Account ${account.current + 1}',
                                style: inter.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              );
                            }),
                            const Icon(Icons.arrow_drop_down)
                          ],
                        ),
                      ),
                      Consumer(
                        builder: (ctx, ref, child) {
                          final account = ref.watch(accountProvider);
                          return GestureDetector(
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: account.address));
                              showSnackBar(ctx,
                                  "Copied '${shortAddress(account.address)}'");
                            },
                            child: Row(
                              children: [
                                Text(shortAddress(account.address)),
                                const SizedBox(width: 5),
                                const Icon(Icons.copy, size: 12)
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Wallet
            ListTile(
              leading: const Icon(Icons.wallet),
              title: Text(
                'Wallet',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Contact
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(
                'Contact',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Profile
            ListTile(
              leading: const Icon(Icons.person_pin),
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const YourProfile(),
                  )),
              title: Text(
                'Profile',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Portfolio
            ListTile(
              leading: const Icon(Icons.dashboard_customize),
              title: Text(
                'Portfolio',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Usernmae
            ListTile(
              leading: const Icon(Icons.alternate_email),
              onTap: () => CreateUsernameScreenRoute().push(context),
              title: Text(
                'Usernmae',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Etherscan
            ListTile(
              leading: const Icon(Icons.table_chart_sharp),
              title: Text(
                'View on Etherscan',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Invite
            ListTile(
              leading: const Icon(Icons.add_business),
              title: Text(
                'Invite a Friend',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Support
            ListTile(
              leading: const Icon(Icons.support_agent),
              title: Text(
                'Support',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
            // Request
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(
                'Request a feature',
                style: urbunist.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
