// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserServiceHelper {
  Future<bool> refreshTokenRequest(WidgetRef ref, BuildContext context) async {
    try {
      bool flag = true;
      final accessToken = await SecureStorage.accessToken.value;
      final refreshToken = await SecureStorage.refreshToken.value;

      logger.i('AccessToken => $accessToken');
      logger.i('RefreshToken => $refreshToken');
      final response = await http.post(
        Uri.parse('https://api.panic0.com/auth/auth/refresh'),
        body: json.encode({"refresh": refreshToken}),
        headers: {'Content-Type': 'application/json'},
      );
      logger.e('Login Status code ${response.statusCode}');
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        final newAccessToken = body['access']['access'];
        final newRefreshToken = body['refresh']['refresh'];
        flag = (await SecureStorage.accessToken.setValue(newAccessToken) ==
                newAccessToken) &&
            flag;
        flag = (await SecureStorage.refreshToken.setValue(newRefreshToken) ==
                newRefreshToken) &&
            flag;
        return flag;
      } else {
        final body = jsonDecode(response.body);
        showSnackBar(context, 'Status ${body['code']}: ${body['message']}');
        return false;
      }
    } catch (e, s) {
      logger.e('Error: ${e.toString()}');
      logger.f(s);
      showSnackBar(context, 'Error: ${e.toString()}');
      return false;
    }
  }
}
