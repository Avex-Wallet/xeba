import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const flutterSecureStorage = FlutterSecureStorage();

enum SecureStorage {
  accessToken,
  refreshToken,
  seedPhase,
  privateKey,
  publicKey
}

extension SecureStorageExtenstion on SecureStorage {
  Future<String> get value async =>
      await flutterSecureStorage.read(key: name) ?? "";

  Future<void> set(String? value) async {
    flutterSecureStorage.write(key: name, value: value);
  }

  Future<String> setValue(String? value) async {
    flutterSecureStorage.write(key: name, value: value);
    return (await this.value);
  }
}
