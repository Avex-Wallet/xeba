// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

import 'package:avex_mobile/model/models.dart';
import 'package:avex_mobile/model/requests/delete_secret_request.dart';

part "avex_api_client.g.dart";

@RestApi(baseUrl: "https://api.panic0.com/auth")
abstract class AvexApiClient {
  factory AvexApiClient(Dio dio) = _AvexApiClient;

  @POST("/auth/login")
  Future<HttpResponse> generateEmailDynamicLink(@Body() SignupRequest request);

  @POST("/auth/verify/{authToken}")
  Future<HttpResponse> verifyAuthToken(
    @Path() String authToken,
  );

  @GET("/user/exists")
  Future<HttpResponse> getUserExistence(
    @Header("Authorization") String accessToken,
  );

  @GET("/user/nonce")
  Future<HttpResponse> getNonce(
    @Header("Authorization") String accessToken,
  );

  @POST("/auth/refresh")
  Future<HttpResponse> refreshAccessToken(
    @Body() RefreshAccessTokenRequest request,
  );

  @POST("/secret")
  Future<HttpResponse> createSecret(@Header("Authorization") String accessToken,
      @Body() CreateSecretRequest request);

  @GET("/secret")
  Future<HttpResponse> getSecret(
    @Header("Authorization") String accessToken,
  );

  @POST("/address")
  Future<HttpResponse> createAddress(
      @Header("Authorization") String accessToken,
      @Body() CreateAddressRequest request);

  @POST("/user/cloudFile")
  Future<HttpResponse> createCloudFileId(
    @Header("Authorization") String accessToken,
    @Body() CreateCloudFileIdRequest request,
  );

  @GET("/user/cloudFile")
  Future<HttpResponse> getCloudFileId(
    @Header("Authorization") String accessToken,
  );

  @DELETE("/secret")
  Future<HttpResponse> deleteSecret(
    @Header("Authorization") String accessToken,
    @Body() DeleteSecretRequest request,
  );
}
