// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';

part "avex_search_client.g.dart";

@RestApi(baseUrl: "https://api.panic0.com/search")
abstract class AvexSearchClient {
  factory AvexSearchClient(Dio dio) = _AvexSearchClient;

  @GET("/indexes/tokens/search")
  Future<HttpResponse> searchTokenViaMillisearch(
      @Query("q") String query, @Header("Authorization") String bearerToken,
      {@Header("Content-Type") contentType = "application/json"});
}
