import 'package:avex_mobile/model/token/token_hits.dart';

class Token extends TokenHits {
  Token({
    required super.key,
    required super.address,
    required super.decimals,
    required super.symbol,
    required super.chainId,
    required super.coinKey,
    required super.name,
    required super.logoURI,
    required super.priceUSD,
  });
}
