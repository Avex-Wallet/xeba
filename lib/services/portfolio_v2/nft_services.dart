import 'package:avex_mobile/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';

typedef NFTResponse = Either<(List<NFTModel>, String), String>;

class NFTService {
  /// Function for getting NFTs owned by wallet.
  ///
  /// HTTP Method: GET
  ///
  /// Path: /nft/wallet/
  ///
  /// @param String **address**: The address of the Wallet.
  ///
  /// @param String **chain**: The chain of the wallet
  ///
  /// @param String? **cursor**: cursor to use for enabling pagination
  static Future<NFTResponse> getListOfNFTOwned({
    required List<String> address,
    required List<String> chain,
    required Ref ref,
    String? cursor,
  }) async {
    try {
      Map body = {
        "chains": chain,
        "wallet_addresses": address,
      };
      if (cursor != null && cursor.isNotEmpty) {
        body["query"] = {"cursor": cursor};
      }
      final dio = ref.read(dioClientProvider);
      // ..interceptors.add(DioCacheInterceptor(options: dioCacheOption()!));
      final response = await dio.get(
        ApiEndpoint.getListOfNFTOwned,
        data: body,
      );

      if (response.statusCode == 200 || response.statusCode == 304) {
        final data = response.data;
        final String cursor = data['next_cursor'] ?? '';
        final nftList = data['nfts'] as List;
        final List<NFTModel> result = nftList
            .map<NFTModel>((element) => NFTModel.fromMap(element))
            .toList();
        return left((result, cursor));
      } else {
        final data = response.data;
        logger.e('Code ${data['code']}: " + ${data['message']}');
        return right('Code ${data['code']}: " + ${data['message']}');
      }
    } catch (e) {
      return right(e.toString());
    }
  }
}
