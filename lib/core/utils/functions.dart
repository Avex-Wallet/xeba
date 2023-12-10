// ignore_for_file: prefer_const_declarations, dead_code

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/accounts/controller/account.controller.dart';

String ipfsImage(String imageUrl) {
  if (imageUrl.startsWith('ipfs://')) {
    return 'https://ipfs.moralis.io:2053${imageUrl.replaceAll('://', '/')}';
  } else {
    return imageUrl;
  }
}

String shortAddress(String? address, {int i = 6}) => address == null ||
        address.isEmpty
    ? '0x'
    : '${address.substring(0, i)}...${address.substring(address.length - i + 1)}';

String getImageUrl(dynamic tokenURI) {
  final gate = false ? 'ipfs.moralis.io:2053' : 'dweb.link';
  if (tokenURI == null) {
    return "";
  }
  // var tokenURI = imgUrl["image"].toString();
  if (tokenURI.contains('gateway.pinata.cloud') ||
      tokenURI.contains('cloudflare') ||
      tokenURI.contains('ipfs.io') ||
      tokenURI.contains('ipfs.infura.io')) {
    return 'https://$gate/ipfs/${tokenURI.split('ipfs/')[1]}';
  } else if (tokenURI.contains('ipfs://')) {
    return 'https://$gate/ipfs/${tokenURI.split('ipfs://')[1]}';
  } else {
    return tokenURI;
  }
}

double convertToEthers(String value, {int decimal = 18}) {
  return BigInt.parse(value) / BigInt.from(pow(10, 18));
}

void showSnackBar(BuildContext? context, String text) {
  if (context == null) return;
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Chip(
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Palette.primary,
        avatar: ClipOval(
          child: Container(
            height: 20,
            width: 20,
            color: Colors.white,
            child: Assets.logoPng.image(),
          ),
        ),
        label: Text(
          text,
          style: GoogleFonts.inter(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      ),
      behavior: SnackBarBehavior.floating,
      duration: const Duration(milliseconds: 1500),
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
}

NetworkChain getFromNetworkString(String chain) {
  return switch (chain) {
    "ethereum" => NetworkChain.ethereumMainnet,
    "polygon" => NetworkChain.polygonMainnet,
    "polygon-mumbai" => NetworkChain.polygonMumbai,
    "avalanche" => NetworkChain.avalancheMainnet,
    "avalanche-fuji" => NetworkChain.avalancheFuji,
    // "fantom" => ''
    // "fantom-testnet" => ''
    "arbitrum" => NetworkChain.arbitrumMainnet,
    "arbitrum-goerli" => NetworkChain.arbitrumGoerli,
    "optimism" => NetworkChain.optimismMainnet,
    "optimism-goerli" => NetworkChain.optimismGoerli,
    "bsc" => NetworkChain.binanceSmartChainMainnet,
    "bsc-testnet" => NetworkChain.binanceSmartChainTestnet,
    // "cronos"
    // "cronos-testnet"
    // "firechain-evm"
    //   return "firechain-substrate"
    "solana" => NetworkChain.solanaMainnet,
    _ => NetworkChain.ethereumMainnet,
  };
}

String getEthAddress(Ref ref) =>
    ref.read(accountProvider.select((value) => value.address));

String getSolAddress(Ref ref) =>
    ref.read(accountProvider.select((value) => value.solAddress));

int fastHash(String string) {
  var hash = 0xcbf29ce484222325;

  var i = 0;
  while (i < string.length) {
    final codeUnit = string.codeUnitAt(i++);
    hash ^= codeUnit >> 8;
    hash *= 0x100000001b3;
    hash ^= codeUnit & 0xFF;
    hash *= 0x100000001b3;
  }

  return hash;
}
