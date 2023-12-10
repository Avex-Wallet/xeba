class ApiEndpoint {
  /// Base URL for Portfolio v1 API
  static const String _portfolioV1BaseUrl =
      'https://api.panic0.com/portfolio/v1';

  /// Base URL for Portfolio v2 API
  static const String _portfolioV2BaseUrl =
      'https://api.panic0.com/portfolio/v2';

  /// Base URL for authentication API
  static const String _authBaseUrl = 'https://api.panic0.com/auth';

  /// Base URL for search API
  static const String _url = 'https://api.panic0.com/search';

  static const String getERC20TokenBalanceEndpoint =
      '$_portfolioV1BaseUrl/token/balance';
  static const String getERC20TokenTransaction =
      '$_portfolioV1BaseUrl/token/transaction';
  static const simulateApiUrlEndpoint = "https://api.panic0.com/simulation/v1";
  static const String searchInIndex = '$_url/indexes/tokens/search';

  /// Endpoint for creating a username.
  ///
  /// HTTP Method: POST
  ///
  /// Path: /auth/user
  static const String createUsername = '$_authBaseUrl/user/name';

  /// Endpoint for getting the username associated with an address.
  ///
  /// HTTP Method: GET
  ///
  /// Path: /auth/user/name
  static const String getUserName = '$_authBaseUrl/user/name';

  /// Endpoint for getting the address associated with a username.
  ///
  /// HTTP Method: GET
  ///
  /// Path: /auth/user/name/{username}
  ///
  /// @param username: The username to retrieve the address for.
  static String getAddressByUsername(String username) =>
      '$_authBaseUrl/user/name/$username';

  /// Endpoint for getting NFTs owned by wallet.
  ///
  /// HTTP Method: GET
  static const String getListOfNFTOwned = "$_portfolioV2BaseUrl/nft/wallet";

  /// Endpoint for getting Tokens owned by wallet.
  ///
  /// HTTP Method: GET
  static const String getListOfTokenOwned =
      "$_portfolioV2BaseUrl/token/balance";

  /// Endpoint for getting Token Transactions History
  ///
  /// HTTP Method: GET
  static const String tokenTransactionHistory =
      "$_portfolioV2BaseUrl/token/transaction/contract";

  /// Endpoint for getting Native Token Transactions History
  ///
  /// HTTP Method: GET
  static const String nativeTokenTransactionHistory =
      "$_portfolioV2BaseUrl/token/transaction";
}
