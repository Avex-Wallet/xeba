import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/enums/network_chain.dart';
import 'package:avex_mobile/main.dart';

class NetworkAvatar extends ConsumerWidget {
  const NetworkAvatar({super.key, this.dimension, this.chain});
  final double? dimension;
  final NetworkChain? chain;
  @override
  Widget build(BuildContext context, ref) => ClipOval(
        child: CachedNetworkImage(
          imageUrl: chain?.coinLogoURI ??
              ref.watch(currentNetworkChainProvider).coinLogoURI,
          width: dimension,
          height: dimension,
        ),
      );
}
