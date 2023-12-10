import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/token/view/pages/token_info_screen.dart';
import 'package:avex_mobile/model/token/token_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  const AppBarWidget({super.key, required this.token});

  final TokenModel token;

  @override
  Widget build(BuildContext context) {
    final chain = token.networkChainFromId;
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: const Icon(Icons.keyboard_arrow_left_outlined),
      ),
      title: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: CircleAvatar(
          radius: 20,
          child: ClipOval(
            child: CachedNetworkImage(
              height: 40,
              width: 40,
              imageUrl: token.native_token ? chain.coinLogoURI : token.logo_url,
              errorWidget: (context, url, error) => NetworkAvatar(
                chain: chain,
              ),
            ),
          ),
        ),
        title: Text(token.native_token ? chain.name : token.contract_name),
        subtitle: Text(token.contract_ticker_symbol),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(CupertinoIcons.bell, size: 20),
        ),
        IconButton(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TokenWikiPage(token: token),
            ),
          ),
          icon: const Icon(CupertinoIcons.info, size: 20),
        ),
      ],
    );
  }
}
