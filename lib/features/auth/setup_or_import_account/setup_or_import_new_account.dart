import 'dart:async';

import 'package:avex_mobile/config/router/router.dart';
import 'package:avex_mobile/services/eddsa_hmac.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../services/api_services/api_response.dart';
import '../../widget/button.dart';

class SetupOrImportNewAccountScreen extends ConsumerStatefulWidget {
  const SetupOrImportNewAccountScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SetupOrImportNewAccountScreenState();
}

class _SetupOrImportNewAccountScreenState
    extends ConsumerState<SetupOrImportNewAccountScreen> {
  bool isNewAccountCreating = false;
  String? driveKey;
  String? qrKey;
  late EddsaHmac eddsaHmac;

  void createNewAccount() async {
    eddsaHmac = ref.read(eddsaHmacProvider);
    setState(() {
      isNewAccountCreating = true;
    });
    final response = await eddsaHmac.createNewMemonicAndWallet((key) {
      if (key == null || key.toString().isEmpty) {
        const snackBar = SnackBar(
          content: Text('Drive key is null'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      driveKey = key;
    }, (key) {
      if (key == null || key.toString().isEmpty) {
        const snackBar = SnackBar(
          content: Text('QR key is null'),
        );

        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        return;
      }
      qrKey = key;
    });
    if (response.status == ApiStatus.success) {
      setState(() {
        isNewAccountCreating = false;
      });
      await Future.delayed(const Duration(seconds: 2));
      if (mounted) {
        SeedSavingScreenRoute(SeedExtra(
          driveKey: driveKey!,
          qrKey: qrKey!,
          edwardsKey: response.data!,
        )).go(context);
      }
    } else {
      final snackBar = SnackBar(
        content: Text(response.errorMessage!),
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    eddsaHmac = ref.read(eddsaHmacProvider);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: const BoxDecoration(
                  color: Color(0xFF2C83A0),
                  shape: BoxShape.circle,
                ),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: Icon(
                    size: 62,
                    Icons.wallet,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                "Hey Anonymous, let's get you started",
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w500, fontSize: 40),
              ),
              Row(
                children: [
                  Text(
                    "Quickly, connect or restore a wallet",
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400, fontSize: 16),
                  ),
                ],
              ),
              Expanded(child: Container()),
              CustomButton(
                  onClick: () {
                    createNewAccount();
                  },
                  title: "Create new Wallet",
                  isLoading: isNewAccountCreating),
              const SizedBox(
                height: 12,
              ),
              CustomButton(
                onClick: () => RestoreExistingAccountScreenRoute()
                    .pushReplacement(context),
                title: "Restore existing wallet",
                isLoading: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
