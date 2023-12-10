// ! Supported Networks
// * Ethereum [Mainnet, Sepolia, Goerli]
// * Polygon [Mainnet, Mumbai]
// * Avalanche [Mainnet, Fuji]
// * Fantom [Mainnet, Testnet]
// * Arbitrum [Mainnet, Goerli]
// * Optimism [Mainnet, Goerli]
// * Binance Smart Chain [Mainnet, Testnet]
// * Cronos [Mainnet, Testnet]
// * FireChain [EVM, Substrate]

// ignore_for_file: dead_code, unused_import

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:googleapis/appengine/v1.dart';

enum NetworkChain {
  ethereumMainnet,
  ethereumSepolia,
  ethereumGoerli,
  polygonMainnet,
  polygonMumbai,
  avalancheMainnet,
  avalancheFuji,
  fantomMainnet,
  fantomTestnet,
  arbitrumMainnet,
  arbitrumGoerli,
  optimismMainnet,
  optimismGoerli,
  binanceSmartChainMainnet,
  binanceSmartChainTestnet,
  cronosMainnet,
  cronosTestnet,
  fireChainEvm,
  solanaMainnet,
  xdc
  // fireChainSubstrate
}

extension AddressExtension on NetworkChain {
  String address(Ref ref) {
    return switch (this) {
      NetworkChain.solanaMainnet => ref.read(accountProvider).solAddress,
      _ => getEthAddress(ref),
    };
  }
}

extension NetworkExtension on NetworkChain {
  int get chainId {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return 1;
      case NetworkChain.ethereumSepolia:
        return 11155111;
      case NetworkChain.ethereumGoerli:
        return 5;
      case NetworkChain.polygonMainnet:
        return 137;
      case NetworkChain.polygonMumbai:
        return 80001;
      case NetworkChain.avalancheMainnet:
        return 43114;
      case NetworkChain.avalancheFuji:
        return 43113;
      case NetworkChain.fantomMainnet:
        return 250;
      case NetworkChain.fantomTestnet:
        return 4002;
      case NetworkChain.arbitrumMainnet:
        return 42161;
      case NetworkChain.arbitrumGoerli:
        return 421613;
      case NetworkChain.optimismMainnet:
        return 10;
      case NetworkChain.optimismGoerli:
        return 420;
      case NetworkChain.binanceSmartChainMainnet:
        return 56;
      case NetworkChain.binanceSmartChainTestnet:
        return 97;
      case NetworkChain.cronosMainnet:
        return 25;
      case NetworkChain.cronosTestnet:
        return 338;
      case NetworkChain.fireChainEvm:
        return 997;
      // case NetworkChain.fireChainSubstrate:
      //   return 998;
      case NetworkChain.solanaMainnet:
        return 1399811149;
      case NetworkChain.xdc:
        return 50;
      default:
        throw Exception("Unknown Network: $this");
    }
  }

  bool get isEVM {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
      case NetworkChain.fireChainEvm:
        return true;
      default:
        return false;
    }
  }

  bool get isTestnet {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.polygonMainnet:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.fantomMainnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.optimismMainnet:
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.cronosMainnet:
      case NetworkChain.fireChainEvm:
      case NetworkChain.solanaMainnet:
      case NetworkChain.xdc:
        return false;
      default:
        return true;
    }
  }

  bool get isEip1559 {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
        return true;
      default:
        return false;
    }
  }

  bool get canLend {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
        return true;
      default:
        return false;
    }
  }

  bool get canSimulate {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
        // case NetworkChain.optimismMainnet:
        // case NetworkChain.optimismGoerli:
        return true;
      default:
        return false;
    }
  }

  bool get isRateLimited {
    switch (this) {
      case NetworkChain.fireChainEvm:
        // case NetworkChain.fireChainSubstrate:
        return true;
      default:
        return false;
    }
  }

  String get name {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return "Ethereum";
      case NetworkChain.ethereumSepolia:
        return "Ethereum Sepolia";
      case NetworkChain.ethereumGoerli:
        return "Ethereum Goerli";
      case NetworkChain.polygonMainnet:
        return "Polygon";
      case NetworkChain.polygonMumbai:
        return "Polygon Mumbai";
      case NetworkChain.avalancheMainnet:
        return "Avalanche";
      case NetworkChain.avalancheFuji:
        return "Avalanche Fuji";
      case NetworkChain.fantomMainnet:
        return "Fantom";
      case NetworkChain.fantomTestnet:
        return "Fantom Testnet";
      case NetworkChain.arbitrumMainnet:
        return "Arbitrum";
      case NetworkChain.arbitrumGoerli:
        return "Arbitrum Goerli";
      case NetworkChain.optimismMainnet:
        return "Optimism";
      case NetworkChain.optimismGoerli:
        return "Optimism Goerli";
      case NetworkChain.binanceSmartChainMainnet:
        return "Binance";
      case NetworkChain.binanceSmartChainTestnet:
        return "Binance Testnet";
      case NetworkChain.cronosMainnet:
        return "Cronos";
      case NetworkChain.cronosTestnet:
        return "Cronos Testnet";
      case NetworkChain.fireChainEvm:
        return "FireChain EVM";
      // case NetworkChain.fireChainSubstrate:
      //   return "FireChain Substrate";
      case NetworkChain.solanaMainnet:
        return "Solana";
      case NetworkChain.xdc:
        return "XDC Network";
      default:
        throw Exception("Unknown Network: $this");
    }
  }

  String get image {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/ethereum.svg";
      case NetworkChain.ethereumSepolia:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/ethereum.svg";
      case NetworkChain.ethereumGoerli:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/ethereum.svg";
      case NetworkChain.polygonMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/polygon.svg";
      case NetworkChain.polygonMumbai:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/polygon.svg";
      case NetworkChain.avalancheMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/avalanche.svg";
      case NetworkChain.avalancheFuji:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/avalanche.svg";
      case NetworkChain.fantomMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/fantom.svg";
      case NetworkChain.fantomTestnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/fantom.svg";
      case NetworkChain.arbitrumMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/arbitrum.svg";
      case NetworkChain.arbitrumGoerli:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/arbitrum.svg";
      case NetworkChain.optimismMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/optimism.svg";
      case NetworkChain.optimismGoerli:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/optimism.svg";
      case NetworkChain.binanceSmartChainMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/bsc.svg";
      case NetworkChain.binanceSmartChainTestnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/bsc.svg";
      case NetworkChain.cronosMainnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/cronos.svg";
      case NetworkChain.cronosTestnet:
        return "https://raw.githubusercontent.com/lifinance/types/main/src/assets/icons/chains/cronos.svg";
      case NetworkChain.fireChainEvm:
        return "https://s3.coinmarketcap.com/static-gravity/image/fd7a43cc620c4ade96804bb1c36aac6f.png";
      case NetworkChain.solanaMainnet:
        return "https://cloudfront-us-east-1.images.arcpublishing.com/coindesk/VNKJKO74VFFNTBJF7BP4N4YHWI.png";
      case NetworkChain.xdc:
        return "https://assets.coingecko.com/coins/images/2912/standard/xdc-icon.png?1696503661";
    }
  }

  String get rpc {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return "https://mainnet.infura.io/v3/5d158c71773c4d869a97405bef38704f";
      case NetworkChain.ethereumSepolia:
        return "https://sepolia.infura.io/v3/5d158c71773c4d869a97405bef38704f";
      case NetworkChain.ethereumGoerli:
        return "https://goerli.infura.io/v3/5d158c71773c4d869a97405bef38704f";
      case NetworkChain.polygonMainnet:
        return "https://rpc-mainnet.maticvigil.com/";
      case NetworkChain.polygonMumbai:
        return "https://rpc-mumbai.maticvigil.com/";
      case NetworkChain.avalancheMainnet:
        return "https://api.avax.network/ext/bc/C/rpc";
      case NetworkChain.avalancheFuji:
        return "https://api.avax-test.network/ext/bc/C/rpc";
      case NetworkChain.fantomMainnet:
        return "https://rpcapi.fantom.network/";
      case NetworkChain.fantomTestnet:
        return "https://rpc.testnet.fantom.network/";
      case NetworkChain.arbitrumMainnet:
        return "https://arb1.arbitrum.io/rpc";
      case NetworkChain.arbitrumGoerli:
        return "https://goerli.arbitrum.io/rpc";
      case NetworkChain.optimismMainnet:
        return "https://mainnet.optimism.io/";
      case NetworkChain.optimismGoerli:
        return "https://goerli.optimism.io/";
      case NetworkChain.binanceSmartChainMainnet:
        return "https://bsc-dataseed.binance.org/";
      case NetworkChain.binanceSmartChainTestnet:
        return "https://data-seed-prebsc-1-s1.binance.org:8545/";
      case NetworkChain.cronosMainnet:
        return "https://evm.cronos.org";
      case NetworkChain.cronosTestnet:
        return "https://evm-t3.cronos.org";
      case NetworkChain.fireChainEvm:
        return "https://rpc-testnet.5ire.network";
      // case NetworkChain.fireChainSubstrate:
      //   return "wss://rpc-testnet.5ire.network";
      default:
        throw Exception("Unknown Network: $this");
    }
  }

  String get chainName {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return "ethereum";
      case NetworkChain.ethereumSepolia:
        return "ethereum-sepolia";
      case NetworkChain.ethereumGoerli:
        return "ethereum-goerli";
      case NetworkChain.polygonMainnet:
        return "polygon";
      case NetworkChain.polygonMumbai:
        return "polygon-mumbai";
      case NetworkChain.avalancheMainnet:
        return "avalanche";
      case NetworkChain.avalancheFuji:
        return "avalanche-fuji";
      case NetworkChain.fantomMainnet:
        return "fantom";
      case NetworkChain.fantomTestnet:
        return "fantom-testnet";
      case NetworkChain.arbitrumMainnet:
        return "arbitrum";
      case NetworkChain.arbitrumGoerli:
        return "arbitrum-goerli";
      case NetworkChain.optimismMainnet:
        return "optimism";
      case NetworkChain.optimismGoerli:
        return "optimism-goerli";
      case NetworkChain.binanceSmartChainMainnet:
        return "binance-smart-chain";
      case NetworkChain.binanceSmartChainTestnet:
        return "binance-smart-chain-testnet";
      case NetworkChain.cronosMainnet:
        return "cronos";
      case NetworkChain.cronosTestnet:
        return "cronos-testnet";
      case NetworkChain.fireChainEvm:
        return "firechain-evm";
      case NetworkChain.solanaMainnet:
        return "solana";
      case NetworkChain.xdc:
        return "xdc";
      // case NetworkChain.fireChainSubstrate:
      //   return "firechain-substrate";
      default:
        throw Exception("Unknown Network: $this");
    }
  }

  String get apiChainName {
    switch (this) {
      case NetworkChain.ethereumMainnet:
        return "ethereum";
      case NetworkChain.ethereumSepolia:
        return "ethereum-sepolia";
      case NetworkChain.ethereumGoerli:
        return "ethereum-goerli";
      case NetworkChain.polygonMainnet:
        return "polygon";
      case NetworkChain.polygonMumbai:
        return "polygon-mumbai";
      case NetworkChain.avalancheMainnet:
        return "avalanche";
      case NetworkChain.avalancheFuji:
        return "avalanche-fuji";
      case NetworkChain.fantomMainnet:
        return "fantom";
      case NetworkChain.fantomTestnet:
        return "fantom-testnet";
      case NetworkChain.arbitrumMainnet:
        return "arbitrum";
      case NetworkChain.arbitrumGoerli:
        return "arbitrum-goerli";
      case NetworkChain.optimismMainnet:
        return "optimism";
      case NetworkChain.optimismGoerli:
        return "optimism-goerli";
      case NetworkChain.binanceSmartChainMainnet:
        return "bsc";
      case NetworkChain.binanceSmartChainTestnet:
        return "bsc-testnet";
      case NetworkChain.cronosMainnet:
        return "cronos";
      case NetworkChain.cronosTestnet:
        return "cronos-testnet";
      case NetworkChain.fireChainEvm:
        return "firechain-evm";
      case NetworkChain.solanaMainnet:
        return "solana";
      // case NetworkChain.fireChainSubstrate:
      //   return "firechain-substrate";
      default:
        throw Exception("Unknown Network: $this");
    }
  }
}

extension NativeTokenExtension on NetworkChain {
  String? get coinGeckoId {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
        return "ethereum";
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
        return "optimistic-ethereum";
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
        return "arbitrum-one";
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
        return "polygon-pos";
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
        return "arbitrum-one";
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
        return "fantom";
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
        return "binance-smart-chain";
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
        return "cronos";
      default:
        return null;
    }
  }

  String get coinAddress {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
      case NetworkChain.fireChainEvm:
      case NetworkChain.xdc:
        return "0x0000000000000000000000000000000000000000";
      case NetworkChain.solanaMainnet:
        return "11111111111111111111111111111111";
    }
  }

  int get coinDecimals {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
      case NetworkChain.fireChainEvm:
      case NetworkChain.xdc:
        return 18;
      case NetworkChain.solanaMainnet:
        return 9;
    }
  }

  String get coinSymbol {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
        return "ETH";
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
        return "MATIC";
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
        return "AVAX";
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
        return "FTM";
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
        return "BNB";
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
        return "CRO";
      case NetworkChain.fireChainEvm:
        return "5IRE";
      case NetworkChain.solanaMainnet:
        return "SOL";
      case NetworkChain.xdc:
        return "XDC";
    }
  }

  String get coinLogoURI {
    switch (this) {
      case NetworkChain.ethereumMainnet:
      case NetworkChain.ethereumSepolia:
      case NetworkChain.ethereumGoerli:
        return "https://static.debank.com/image/token/logo_url/eth/935ae4e4d1d12d59a99717a24f2540b5.png";
      case NetworkChain.optimismMainnet:
      case NetworkChain.optimismGoerli:
        return "https://cryptologos.cc/logos/optimism-ethereum-op-logo.png?v=026";
      case NetworkChain.arbitrumMainnet:
      case NetworkChain.arbitrumGoerli:
        return "https://cryptologos.cc/logos/arbitrum-arb-logo.png?v=026";
      case NetworkChain.polygonMainnet:
      case NetworkChain.polygonMumbai:
        return "https://static.debank.com/image/matic_token/logo_url/matic/6f5a6b6f0732a7a235131bd7804d357c.png";
      case NetworkChain.avalancheMainnet:
      case NetworkChain.avalancheFuji:
        return "https://static.debank.com/image/avax_token/logo_url/avax/0b9c84359c84d6bdd5bfda9c2d4c4a82.png";
      case NetworkChain.fantomMainnet:
      case NetworkChain.fantomTestnet:
        return "https://static.debank.com/image/ftm_token/logo_url/ftm/33fdb9c5067e94f3a1b9e78f6fa86984.png";
      case NetworkChain.binanceSmartChainMainnet:
      case NetworkChain.binanceSmartChainTestnet:
        return "https://static.debank.com/image/bsc_token/logo_url/bsc/8bfdeaa46fe9be8f5cd43a53b8d1eea1.png";
      case NetworkChain.cronosMainnet:
      case NetworkChain.cronosTestnet:
        return 'https://pbs.twimg.com/profile_images/1417359604623679488/CGzQIEVX_400x400.png';
      // : "https://static.debank.com/image/token/logo_url/cro/935ae4e4d1d12d59a99717a24f2540b5.png";
      case NetworkChain.fireChainEvm:
        return "https://s3.coinmarketcap.com/static-gravity/image/fd7a43cc620c4ade96804bb1c36aac6f.png";
      case NetworkChain.solanaMainnet:
        return "https://cloudfront-us-east-1.images.arcpublishing.com/coindesk/VNKJKO74VFFNTBJF7BP4N4YHWI.png";
      case NetworkChain.xdc:
        return "https://assets.coingecko.com/coins/images/2912/standard/xdc-icon.png?1696503661";
    }
  }
}

extension StringExtension on String {
  NetworkChain? toNetwork() {
    switch (this) {
      case "ethereum-mainnet":
        return NetworkChain.ethereumMainnet;
      case "ethereum-sepolia":
        return NetworkChain.ethereumSepolia;
      case "ethereum-goerli":
        return NetworkChain.ethereumGoerli;
      case "polygon-matic":
        return NetworkChain.polygonMainnet;
      case "polygon-mumbai":
        return NetworkChain.polygonMumbai;
      case "avalanche-mainnet":
        return NetworkChain.avalancheMainnet;
      case "avalanche-fuji":
        return NetworkChain.avalancheFuji;
      case "fantom-mainnet":
        return NetworkChain.fantomMainnet;
      case "fantom-testnet":
        return NetworkChain.fantomTestnet;
      case "arbitrum-mainnet":
        return NetworkChain.arbitrumMainnet;
      case "arbitrum-goerli":
        return NetworkChain.arbitrumGoerli;
      case "optimism-mainnet":
        return NetworkChain.optimismMainnet;
      case "optimism-goerli":
        return NetworkChain.optimismGoerli;
      case "binance-smart-chain-mainnet":
        return NetworkChain.binanceSmartChainMainnet;
      case "binance-smart-chain-testnet":
        return NetworkChain.binanceSmartChainTestnet;
      case "cronos-mainnet":
        return NetworkChain.cronosMainnet;
      case "cronos-testnet":
        return NetworkChain.cronosTestnet;
      case "firechain-evm":
        return NetworkChain.fireChainEvm;
      // case "firechain-substrate":
      //   return NetworkChain.fireChainSubstrate;
      default:
        return null;
    }
  }
}

extension IntExtension on int {
  NetworkChain? toNetwork() {
    switch (this) {
      case 1:
        return NetworkChain.ethereumMainnet;
      case 11155111:
        return NetworkChain.ethereumSepolia;
      case 5:
        return NetworkChain.ethereumGoerli;
      case 137:
        return NetworkChain.polygonMainnet;
      case 80001:
        return NetworkChain.polygonMumbai;
      case 43114:
        return NetworkChain.avalancheMainnet;
      case 43113:
        return NetworkChain.avalancheFuji;
      case 250:
        return NetworkChain.fantomMainnet;
      case 4002:
        return NetworkChain.fantomTestnet;
      case 42161:
        return NetworkChain.arbitrumMainnet;
      case 421613:
        return NetworkChain.arbitrumGoerli;
      case 10:
        return NetworkChain.optimismMainnet;
      case 420:
        return NetworkChain.optimismGoerli;
      case 56:
        return NetworkChain.binanceSmartChainMainnet;
      case 97:
        return NetworkChain.binanceSmartChainTestnet;
      case 25:
        return NetworkChain.cronosMainnet;
      case 338:
        return NetworkChain.cronosTestnet;
      case 997:
        return NetworkChain.fireChainEvm;
      // case 998:
      //   return NetworkChain.fireChainSubstrate;
      default:
        return null;
    }
  }
}

enum GasOption {
  fast,
  standard,
  slow,
}

extension GasOptionExtension on GasOption {
  int get multiplier {
    switch (this) {
      case GasOption.fast:
        return 2;
      case GasOption.standard:
        return 1;
      case GasOption.slow:
        return 0;
      default:
        throw Exception("Unknown GasOption: $this");
    }
  }
}
