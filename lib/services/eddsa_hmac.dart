// ignore_for_file: depend_on_referenced_packages

import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:bip32_ed25519/bip32_ed25519.dart';
import 'package:convert/convert.dart';
import 'package:eddsa_hmac/services/wallet/key.service.dart';
import 'package:eddsa_hmac/services/wallet/message.service.dart';
import 'package:eddsa_hmac/services/wallet/mnemonic.service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'api_services/api_response.dart';
import 'api_services/api_services.dart';

final eddsaHmacProvider = Provider(
    (ref) => EddsaHmac(service: ref.read(apiServiceProvider), ref: ref));

class EddsaHmac {
  final ApiService service;
  final ProviderRef ref;

  EddsaHmac({required this.service, required this.ref});

  Future<ApiResponse<ExtendedSigningKey>> importSeedPhrase(String arguments,
      Function onDriveSubmit, Function onGenerateQRcode) async {
    // Import Seed Phrase from User

    var safeMnemonic = importMnemonic(arguments);
    var backupShares = createShamirShares(safeMnemonic);

    //print(backupShares); // Save these backup share to Drive, Email, Qrcode
    onDriveSubmit(backupShares[0]);
    onGenerateQRcode(backupShares[2]);
    var seed = createWallet(safeMnemonic);
    var edwardsKey = createEdwardsKey(seed);
    await service.refreshAccessTokenToSharedPref();

    final accessToken = await SecureStorage.accessToken.value;
    try {
      final firstNonce = await service.getNonce(accessToken);
      if (firstNonce.status == ApiStatus.error) {
        throw CustomHttpException(
            firstNonce.errorMessage ?? "Unknown Exception", firstNonce.code);
      }
      var data1 = genreateShamirCreationMessage(
          backupShares[1], firstNonce.data!, edwardsKey);
      final response = await service.createSecret(accessToken, backupShares[1],
          hex.encode(edwardsKey.publicKey), data1);
      //debugprint(response.toString());
      if (response.status == ApiStatus.error) {
        throw CustomHttpException(
            response.errorMessage ?? "Unknown Exception", response.code);
      }
      var ecKey = createEcdsaKey(seed, 0);
      await SecureStorage.privateKey.set(ecKey.privateKeyHex());
      var keys = createEthereumAccount(
          ecKey); // 0 is the index of the account, this will keep on incementing
      await SecureStorage.publicKey.set(keys.address.toString());
      final secondNonce = await service.getNonce(accessToken);
      if (secondNonce.status == ApiStatus.success) {
        var data2 = genreateEthereumCreationMessage(secondNonce.data!, keys);

        final responseOfCreateAddress = await service.createAddress(
            accessToken, "eth", keys.address.hexNo0x.toString(), data2);
        // //debugprint(responseOfCreateAddress.toString());
        if (responseOfCreateAddress.status == ApiStatus.error) {
          throw CustomHttpException(
              responseOfCreateAddress.errorMessage ?? "Unknown Exception",
              responseOfCreateAddress.code);
        }
        await SecureStorage.seedPhase.set(safeMnemonic);

        return ApiResponse.success(edwardsKey, 200);
      } else {
        throw CustomHttpException(
            response.errorMessage ?? "Unknown Exception", response.code);
      }
    } on CustomHttpException catch (e) {
      return ApiResponse.error(e.message, e.code);
    }
  }

  Future<ApiResponse<ExtendedSigningKey>> createNewMemonicAndWallet(
      Function onDriveSubmit, Function onGenerateQRcode) async {
    // Create new Memonic and Wallet
    var safeMnemonic = createNewMnemonic();
    var backupShares = createShamirShares(safeMnemonic);
    // //print(backupShares); // Save these backup share to Drive, Email, Qrcode
    onDriveSubmit(backupShares[0]);
    //print("SHASHANK--backend:" + backupShares[1]);
    onGenerateQRcode(backupShares[2]);
    var seed = createWallet(safeMnemonic);
    var edwardsKey = createEdwardsKey(seed);
    await service.refreshAccessTokenToSharedPref();
    final accessToken = await SecureStorage.accessToken.value;

    try {
      final firstNonce = await service.getNonce(accessToken);
      if (firstNonce.status == ApiStatus.error) {
        throw CustomHttpException(
            firstNonce.errorMessage ?? "Unknown Exception", firstNonce.code);
      }
      var data1 = genreateShamirCreationMessage(
          backupShares[1], firstNonce.data!, edwardsKey);
      final response = await service.createSecret(accessToken, backupShares[1],
          hex.encode(edwardsKey.publicKey), data1);
      //debugprint(response.toString());
      if (response.status == ApiStatus.error) {
        throw CustomHttpException(
            response.errorMessage ?? "Unknown Exception", response.code);
      }

      var ecKey = createEcdsaKey(seed, 0);
      await SecureStorage.privateKey
          .set(ecKey.privateKeyHex()); // * Store this key in Shared Preferences
      var keys = createEthereumAccount(
          ecKey); // 0 is the index of the account, this will keep on incementing
      // 0 is the index of the account, this will keep on incementing
      await SecureStorage.publicKey.set(keys.address.toString());
      final secondNonce = await service.getNonce(accessToken);
      if (secondNonce.status == ApiStatus.success) {
        var data2 = genreateEthereumCreationMessage(secondNonce.data!, keys);

        final responseOfCreateAddress = await service.createAddress(
            accessToken, "eth", keys.address.hexNo0x.toString(), data2);
        // //debugprint(responseOfCreateAddress.toString());
        if (responseOfCreateAddress.status == ApiStatus.error) {
          throw CustomHttpException(
              responseOfCreateAddress.errorMessage ?? "Unknown Exception",
              responseOfCreateAddress.code);
        }
        // var edwardsKey = createEdwardsKey(seed);
        await SecureStorage.seedPhase.set(safeMnemonic);
        return ApiResponse.success(edwardsKey, 200);
      } else {
        throw CustomHttpException(
            response.errorMessage ?? "Unknown Exception", response.code);
      }
    } on CustomHttpException catch (e) {
      return ApiResponse.error(e.message, e.code);
    }
  }

  Future<ApiResponse<void>> recoverSeedPhraseFromUserZ(
      List<String> arguments) async {
    if (arguments.length < 2) {
      //print('Please provide at least 2 shares');
      return ApiResponse.error("Please provide at least 2 shares", -1);
    }
    var safeMnemonic = recoverMnemonic(arguments);
    var seed = createWallet(safeMnemonic);
    // var edwardsKey = createEdwardsKey(seed);
    await service.refreshAccessTokenToSharedPref();
    final accessToken = await SecureStorage.accessToken.value;
    try {
      var ecKey = createEcdsaKey(seed, 0);
      await SecureStorage.privateKey.set(ecKey.privateKeyHex()); //
      // * Store this key in Shared Preferences
      var keys = createEthereumAccount(
          ecKey); // 0 is the index of the account, this will keep on incementing
      await SecureStorage.publicKey.set(keys.address.toString());
      final thirdNonce = await service.getNonce(accessToken);
      if (thirdNonce.status == ApiStatus.success) {
        var data2 = genreateEthereumCreationMessage(thirdNonce.data!, keys);

        final responseOfCreateAddress = await service.createAddress(
            accessToken, "eth", keys.address.hexNo0x.toString(), data2);
        // //debugprint(responseOfCreateAddress.toString());
        if (responseOfCreateAddress.status == ApiStatus.error) {
          throw CustomHttpException(
              responseOfCreateAddress.errorMessage ?? "Unknown Exception",
              responseOfCreateAddress.code);
        }
        await SecureStorage.seedPhase.set(safeMnemonic);

        return ApiResponse.success(null, 200);
      } else {
        throw CustomHttpException(
            thirdNonce.errorMessage ?? "Unknown Exception", thirdNonce.code);
      }
    } on CustomHttpException catch (e) {
      return ApiResponse.error(e.message, e.code);
    }
  }
}
