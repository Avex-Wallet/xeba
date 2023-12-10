import 'package:avex_mobile/model/token/token_model.dart';
import 'package:avex_mobile/provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/model/token/token_transaction_model.dart';

final tokenTransactionHistoryProvider = FutureProvider.family<
    Either<List<TokenTransactionModel>, ServerError>, TokenModel>((ref, token) {
  final dio = ref.watch(dioClientProvider);
  final address = token.networkChainFromId.address(ref);
  logger.e({
    "chain": token.networkChainFromId.apiChainName,
    "wallet_address": address,
    "contract_address": token.contract_address
  });
  final request = dio.get(ApiEndpoint.tokenTransactionHistory, data: {
    "chain": token.networkChainFromId.apiChainName,
    "wallet_address": address,
    "contract_address": token.contract_address
  });

  return request.then((value) async {
    if (value.statusCode != 200) {
      return right(ServerError.fromMap(value.data));
    }
    final List list = value.data["data"]["items"] ?? [];
    return left(list.map((e) => TokenTransactionModel.fromMap(e)).toList());
  });
});
