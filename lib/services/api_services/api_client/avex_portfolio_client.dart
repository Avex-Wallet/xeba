// ignore_for_file: depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:retrofit/http.dart';
import 'package:xeba_mobile/model/requests/get_nft_request.dart';

part 'avex_portfolio_client.g.dart';

@RestApi(baseUrl: "https://api.panic0.com/portfolio/v1")
abstract class XebaPortfolioApiClient {
  factory XebaPortfolioApiClient(Dio dio) = _XebaPortfolioApiClient;

  @POST("/nft/balance")
  Future<HttpResponse> getNfts(@Body() GetNftRequest request,
      @Header("Authorization") String bearerToken,
      {@Header("Content-Type") contentType = "application/json"});
}
