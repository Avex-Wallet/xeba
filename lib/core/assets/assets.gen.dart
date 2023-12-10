/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bitcoin.png
  AssetGenImage get bitcoin => const AssetGenImage('assets/icons/bitcoin.png');

  /// File path: assets/icons/dropbox.png
  AssetGenImage get dropbox => const AssetGenImage('assets/icons/dropbox.png');

  /// File path: assets/icons/ethereum.png
  AssetGenImage get ethereum =>
      const AssetGenImage('assets/icons/ethereum.png');

  /// File path: assets/icons/google-drive.png
  AssetGenImage get googleDrive =>
      const AssetGenImage('assets/icons/google-drive.png');

  /// File path: assets/icons/icloud.png
  AssetGenImage get icloud => const AssetGenImage('assets/icons/icloud.png');

  /// File path: assets/icons/solana.png
  AssetGenImage get solana => const AssetGenImage('assets/icons/solana.png');

  /// List of all assets
  List<AssetGenImage> get values =>
      [bitcoin, dropbox, ethereum, googleDrive, icloud, solana];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/Search.png
  AssetGenImage get search => const AssetGenImage('assets/images/Search.png');

  /// File path: assets/images/Wallet.png
  AssetGenImage get wallet => const AssetGenImage('assets/images/Wallet.png');

  /// File path: assets/images/error.svg
  SvgGenImage get error => const SvgGenImage('assets/images/error.svg');

  /// File path: assets/images/error404.png
  AssetGenImage get error404 =>
      const AssetGenImage('assets/images/error404.png');

  /// File path: assets/images/messagetext1.png
  AssetGenImage get messagetext1 =>
      const AssetGenImage('assets/images/messagetext1.png');

  /// File path: assets/images/no_nft.png
  AssetGenImage get noNftPng => const AssetGenImage('assets/images/no_nft.png');

  /// File path: assets/images/no_nft.svg
  SvgGenImage get noNftSvg => const SvgGenImage('assets/images/no_nft.svg');

  /// File path: assets/images/notification.png
  AssetGenImage get notification =>
      const AssetGenImage('assets/images/notification.png');

  /// File path: assets/images/setting2.png
  AssetGenImage get setting2Png =>
      const AssetGenImage('assets/images/setting2.png');

  /// File path: assets/images/setting2.svg
  SvgGenImage get setting2Svg =>
      const SvgGenImage('assets/images/setting2.svg');

  /// File path: assets/images/transfer.png
  AssetGenImage get transfer =>
      const AssetGenImage('assets/images/transfer.png');

  /// List of all assets
  List<dynamic> get values => [
        search,
        wallet,
        error,
        error404,
        messagetext1,
        noNftPng,
        noNftSvg,
        notification,
        setting2Png,
        setting2Svg,
        transfer
      ];
}

class $AssetsJsonGen {
  const $AssetsJsonGen();

  /// File path: assets/json/data.json
  String get data => 'assets/json/data.json';

  /// File path: assets/json/dd.json
  String get dd => 'assets/json/dd.json';

  /// List of all assets
  List<String> get values => [data, dd];
}

class $AssetsLottiesGen {
  const $AssetsLottiesGen();

  /// File path: assets/lotties/loading.json
  LottieGenImage get loading =>
      const LottieGenImage('assets/lotties/loading.json');

  /// File path: assets/lotties/music_playing.json
  LottieGenImage get musicPlaying =>
      const LottieGenImage('assets/lotties/music_playing.json');

  /// File path: assets/lotties/transaction_done.json
  LottieGenImage get transactionDone =>
      const LottieGenImage('assets/lotties/transaction_done.json');

  /// File path: assets/lotties/txn_done.json
  LottieGenImage get txnDone =>
      const LottieGenImage('assets/lotties/txn_done.json');

  /// File path: assets/lotties/txn_fly.json
  LottieGenImage get txnFly =>
      const LottieGenImage('assets/lotties/txn_fly.json');

  /// List of all assets
  List<LottieGenImage> get values =>
      [loading, musicPlaying, transactionDone, txnDone, txnFly];
}

class Assets {
  Assets._();

  static const SvgGenImage fbLogo = SvgGenImage('assets/fb_logo.svg');
  static const SvgGenImage googleLogo = SvgGenImage('assets/google_logo.svg');
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
  static const $AssetsJsonGen json = $AssetsJsonGen();
  static const AssetGenImage logoPng = AssetGenImage('assets/logo.png');
  static const SvgGenImage logoSvg = SvgGenImage('assets/logo.svg');
  static const $AssetsLottiesGen lotties = $AssetsLottiesGen();
  static const AssetGenImage qrCode = AssetGenImage('assets/qr_code.png');
  static const SvgGenImage twitterLogo = SvgGenImage('assets/twitter_logo.svg');

  /// List of all assets
  List<dynamic> get values =>
      [fbLogo, googleLogo, logoPng, logoSvg, qrCode, twitterLogo];
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}

class LottieGenImage {
  const LottieGenImage(this._assetName);

  final String _assetName;

  LottieBuilder lottie({
    Animation<double>? controller,
    bool? animate,
    FrameRate? frameRate,
    bool? repeat,
    bool? reverse,
    LottieDelegates? delegates,
    LottieOptions? options,
    void Function(LottieComposition)? onLoaded,
    LottieImageProviderFactory? imageProviderFactory,
    Key? key,
    AssetBundle? bundle,
    Widget Function(BuildContext, Widget, LottieComposition?)? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    double? width,
    double? height,
    BoxFit? fit,
    AlignmentGeometry? alignment,
    String? package,
    bool? addRepaintBoundary,
    FilterQuality? filterQuality,
    void Function(String)? onWarning,
  }) {
    return Lottie.asset(
      _assetName,
      controller: controller,
      animate: animate,
      frameRate: frameRate,
      repeat: repeat,
      reverse: reverse,
      delegates: delegates,
      options: options,
      onLoaded: onLoaded,
      imageProviderFactory: imageProviderFactory,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      package: package,
      addRepaintBoundary: addRepaintBoundary,
      filterQuality: filterQuality,
      onWarning: onWarning,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
