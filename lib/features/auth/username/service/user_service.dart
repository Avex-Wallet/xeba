import 'dart:convert';
import 'package:avex_mobile/core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;

final userServiceProvider = Provider<IUserService>((ref) => UserService());

abstract class IUserService {
  Future<String?> createUsername({
    required String accessToken,
    required String username,
  });

  Future<Either<String, String>> getUserName({required String accessToken});

  Future<Either<String, String>> getAddressByUsername({
    required String username,
    required String accessToken,
  });
}

class UserService implements IUserService {
  /// Create new user from the user
  @override
  Future<String?> createUsername({
    required String accessToken,
    required String username,
  }) async {
    try {
      logger.i(accessToken);
      var headers = {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json'
      };
      http.Response response = await http.post(
        Uri.parse(ApiEndpoint.createUsername),
        headers: headers,
        body: jsonEncode({"username": username}),
      );
      if (response.statusCode == 201) {
        return null;
      } else {
        return 'Operation failed';
      }
    } catch (e) {
      return e.toString();
    }
  }

  ///Get Username associated with the given user
  @override
  Future<Either<String, String>> getUserName(
      {required String accessToken}) async {
    try {
      var headers = {'Authorization': 'Bearer $accessToken'};
      http.Response response =
          await http.get(Uri.parse(ApiEndpoint.getUserName), headers: headers);
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return left(data["username"].first);
      } else {
        return right('Status ${data['code']} : ${data['message']}');
      }
    } catch (e) {
      return right(e.toString());
    }
  }

  /// Returns the **address** associated eith the given *username*
  @override
  Future<Either<String, String>> getAddressByUsername({
    required String username,
    required String accessToken,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse(ApiEndpoint.getAddressByUsername(username)),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      final data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        return left('0x${data['addresses'].first}');
      } else {
        logger.e(data);
        return right('Status ${data['code']} : ${data['message']}');
      }
    } catch (e) {
      logger.e(e);
      return right(e.toString());
    }
  }
}
