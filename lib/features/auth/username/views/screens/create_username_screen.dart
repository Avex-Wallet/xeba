// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/config/config.dart';
import 'package:avex_mobile/core/themes/themes.dart';
import 'package:avex_mobile/core/utils/utils.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:avex_mobile/features/auth/username/service/user_service.dart';
import 'package:avex_mobile/features/auth/username/views/widgets/validation_indicator.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';

class CreateUsernameScreen extends ConsumerStatefulWidget {
  const CreateUsernameScreen({super.key});

  @override
  ConsumerState<CreateUsernameScreen> createState() =>
      _CreateUsernameScreenState();
}

class _CreateUsernameScreenState extends ConsumerState<CreateUsernameScreen> {
  bool alphaValid = false;
  bool numberValid = false;
  bool lengthValid = false;
  bool usernameAvailable = false;
  final controller = TextEditingController();
  String? accessToken;

  bool get syntaxValid => alphaValid && numberValid && lengthValid;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    accessToken = await SecureStorage.accessToken.value;
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.transparent,
    );
    final mq = MediaQuery.of(context);

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Container(
          height: mq.size.height - appBar.preferredSize.height - mq.padding.top,
          width: mq.size.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\'s your\nusername for this\nwallet?',
                style: inter.copyWith(
                  fontSize: 34,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller,
                onTapOutside: (event) => FocusScope.of(context).unfocus(),
                onChanged: (value) async {
                  if (accessToken == null) await init();
                  alphaValid = RegExp(r'[a-z]').hasMatch(value) &&
                      RegExp(r'^[a-z0-9]+$').hasMatch(value);
                  numberValid = RegExp(r'[0-9]').hasMatch(value);
                  lengthValid = value.length >= 8;
                  setState(() {});
                  if (syntaxValid) {
                    final userService = ref.watch(userServiceProvider);
                    final addressResponse =
                        await userService.getAddressByUsername(
                      username: controller.text,
                      accessToken: accessToken!,
                    );
                    logger.e(addressResponse);
                    addressResponse.fold((l) {
                      usernameAvailable = false;
                    }, (r) {
                      if (r.contains('404')) {
                        usernameAvailable = true;
                      } else {
                        showSnackBar(context, r);
                        usernameAvailable = false;
                      }
                    });
                    setState(() {});
                  }
                },
                style: inter.copyWith(
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  filled: true,
                  fillColor: Palette.secondary,
                  prefixIcon: const Icon(Icons.alternate_email_rounded),
                  hintText: 'Vatalikbuterin',
                ),
              ),
              const SizedBox(height: 20),
              ValidationIndicator(
                label: 'Must include alphabet from a to z',
                valid: alphaValid,
              ),
              ValidationIndicator(
                label: 'Must include atleast one number from 0 to 9',
                valid: numberValid,
              ),
              ValidationIndicator(
                label: 'Minimum length of 8 characters',
                valid: lengthValid,
              ),
              ValidationIndicator(
                label: 'Username available',
                valid: usernameAvailable,
              ),
              const Spacer(),
              ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                tileColor: Colors.blue.withOpacity(0.2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                leading: const Icon(
                  Icons.error,
                  color: Colors.blueAccent,
                ),
                title: Text(
                  'Information',
                  style: urbunist.copyWith(
                    color: Colors.blue.shade200,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Your can share this username with others to providde access to your wallet details',
                  style: urbunist.copyWith(color: Colors.blue.shade100),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  backgroundColor: syntaxValid && usernameAvailable
                      ? Palette.primary
                      : Palette.secondary,
                  minimumSize: const Size.fromHeight(55),
                  textStyle: inter.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onPressed: () async {
                  if (!syntaxValid) {
                    showSnackBar(context, 'This username not allowed');
                    return;
                  } else if (!usernameAvailable) {
                    showSnackBar(context, 'Username not available');
                    return;
                  }
                  final res =
                      await ref.read(userServiceProvider).createUsername(
                            accessToken: accessToken!,
                            username: controller.text,
                          );
                  if (res == null) {
                    showSnackBar(context, 'Loading! Please Wait...');
                    ref.read(accountProvider);
                    await ref.read(accountProvider.notifier).init();
                    MainRoute().go(context);
                  } else {
                    showSnackBar(context, res);
                  }
                },
                child: const Text('Continue'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
