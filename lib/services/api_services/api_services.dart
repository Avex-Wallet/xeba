// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/services/local_services/secure_storage/secure_storage.dart';

import '../../model/models.dart';
import '../../model/requests/delete_secret_request.dart';
import '../../model/requests/get_nft_request.dart';
import '../../model/responses/get_nft_collection_by_wallet_response.dart';
import '../../model/responses/millisearch_search_token.dart';
import '../dio_provider.dart';
import 'api_client/avex_api_client.dart';
import 'api_client/avex_portfolio_client.dart';
import 'api_client/avex_search_client.dart';
import 'api_response.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService(
      ref.read(dioProvider),
    ));

class ApiService {
  late final AvexApiClient avexApiClient;
  late final AvexSearchClient avexSearchClient;
  late final AvexPortfolioApiClient portfolioApiClient;
  final String unknownErrorMessage = "An Unknown Error Message Happen";

  ApiService(Dio dio) {
    avexApiClient = AvexApiClient(dio);
    avexSearchClient = AvexSearchClient(dio);
    portfolioApiClient = AvexPortfolioApiClient(dio);
  }

  Future<ApiResponse<void>> signupWithDynamicLink(String email) async {
    final request = SignupRequest(email: email);
    final response = await avexApiClient.generateEmailDynamicLink(request);
    final statusCode = response.response.statusCode;
    if (statusCode != null && statusCode > 199 && statusCode < 300) {
      return ApiResponse.success(null, statusCode);
    } else if (response.response.data["message"] != null &&
        response.response.data["message"].toString().isNotEmpty) {
      return ApiResponse.error(
          response.response.data["message"].toString(), 500);
    } else {
      return ApiResponse.error(unknownErrorMessage, 500);
    }
  }

  Future<ApiResponse<VerifyAuthResponse>> verifyAuthToken(
      String authToken) async {
    try {
      final response = await avexApiClient.verifyAuthToken(authToken);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          VerifyAuthResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GetExistenceResponse>> getUserExistence(
      String authToken) async {
    try {
      final response =
          await avexApiClient.getUserExistence("Bearer $authToken");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          GetExistenceResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> getNonce(String authToken) async {
    try {
      final response = await avexApiClient.getNonce("Bearer $authToken");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<VerifyAuthResponse>> refreshAccessToken(
      String refreshToken) async {
    try {
      final response = await avexApiClient
          .refreshAccessToken(RefreshAccessTokenRequest(refresh: refreshToken));
      final statusCode = response.response.statusCode;

      return ApiResponse.success(
          VerifyAuthResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  /// handles error, and returns an ApiResponse based on the error
  Future<ApiResponse<DataType>> _handleError<DataType>(e) async {
    if (e.runtimeType == DioError) {
      final res = e.response;
      return ApiResponse<DataType>.error(
          e.message, e.response?.statusCode ?? -1);
    }
    return ApiResponse<DataType>.error(await _checkNetworkAndReturnError(), -1);
  }

  Future<String> _checkNetworkAndReturnError() async {
    return (await hasInternetAccess()) == false
        ? 'Oh snap! It seems you\'re offline.'
        : 'Something went wrong!';
  }

  Future<bool?> hasInternetAccess() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return null;
  }

  Future<ApiResponse> createSecret(
    String accessToken,
    String secret,
    String pubKey,
    String signature,
  ) async {
    try {
      final request = CreateSecretRequest(
          secret: secret, pubKey: pubKey, signature: signature);
      final response =
          await avexApiClient.createSecret("Bearer $accessToken", request);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> deleteSecret(
    String accessToken,
    String signature,
  ) async {
    try {
      final request = DeleteSecretRequest(signature: signature);
      final response =
          await avexApiClient.deleteSecret("Bearer $accessToken", request);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GetSecretResponse>> getSecretShare(
    String accessToken,
  ) async {
    try {
      final response = await avexApiClient.getSecret("Bearer $accessToken");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          GetSecretResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> createCloudFileId(
    String accessToken,
    String provider,
    String fileId,
    String signature,
  ) async {
    try {
      final request = CreateCloudFileIdRequest(
          provider: provider, fileId: fileId, signature: signature);
      final response =
          await avexApiClient.createCloudFileId("Bearer $accessToken", request);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<String>> getCloudFileId(
    String accessToken,
  ) async {
    try {
      final response =
          await avexApiClient.getCloudFileId("Bearer $accessToken");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse> createAddress(
    String accessToken,
    String chain,
    String publicAddress,
    String signature,
  ) async {
    try {
      final request = CreateAddressRequest(
          chain: chain, publicAddress: publicAddress, signature: signature);
      final response =
          await avexApiClient.createAddress("Bearer $accessToken", request);
      final statusCode = response.response.statusCode;
      return ApiResponse.success(response.data.toString(), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<void> refreshAccessTokenToSharedPref() async {
    final prevRefreshToken = await SecureStorage.refreshToken.value;
    final response = await refreshAccessToken(prevRefreshToken);
    // ignore: unrelated_type_equality_checks
    if (response.code < 300 && response.code >= 200) {
      try {
        await SecureStorage.accessToken.set(response.data!.access.access);
        await SecureStorage.refreshToken.set(response.data!.refresh.refresh);
      } catch (e) {
        // ignore
      }
    } else {
      //debugprint(response.errorMessage);
    }
  }

  Future<ApiResponse<MilliSearch_SearchToken>> searchForCryptoToken(
      String? q, String bearerToken) async {
    try {
      final response = await avexSearchClient.searchTokenViaMillisearch(
          q ?? "", "Bearer $bearerToken");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          MilliSearch_SearchToken.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }

  Future<ApiResponse<GetNftResponse>> getNft() async {
    try {
      final response = await portfolioApiClient.getNfts(
          GetNftRequest(
              address: "0xbdfa4f4492dd7b7cf211209c4791af8d52bf5c50",
              chain: "eth",
              cursor: null),
          "Bearer d2b52a2ef1de239afb73de5d09cd61f3969c5bf9110233713580553a31ffe08e");
      final statusCode = response.response.statusCode;
      return ApiResponse.success(
          GetNftResponse.fromJson(response.data), statusCode ?? -1);
    } catch (e) {
      return _handleError(e);
    }
  }
}
