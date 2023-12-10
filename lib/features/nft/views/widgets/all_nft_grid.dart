import 'package:avex_mobile/config/router/router.dart';
import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:avex_mobile/core/assets/assets.gen.dart';
import 'package:avex_mobile/core/utils/functions.dart';
import 'package:avex_mobile/core/utils/widget.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';

class AllNFTWidget extends StatefulWidget {
  const AllNFTWidget(
      {super.key, required this.scrollController, required this.nftList});
  final ScrollController scrollController;
  final List<NFTModel> nftList;

  @override
  State<AllNFTWidget> createState() => _AllNFTWidgetState();
}

class _AllNFTWidgetState extends State<AllNFTWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 6 / 7,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      controller: widget.scrollController,
      shrinkWrap: true,
      key: const PageStorageKey('myListView2'),
      itemCount: widget.nftList.length,
      itemBuilder: (context, index) {
        final img =
            widget.nftList.elementAt(index).previews?.image_medium_url ?? '';
        return Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: const Color(0xff262D34),
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Blur(
                    blur: 0.1,
                    blurColor: Colors.black,
                    child: CachedNetworkImage(
                      imageUrl: img,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white24,
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white24,
                        ),
                      ),
                      imageBuilder: (context, imageProvider) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                              opacity: 0.6,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white24,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  NFTScreenRoute(
                    contract:
                        widget.nftList.elementAt(index).contract_address ?? '',
                    tokenId:
                        widget.nftList.elementAt(index).token_id ?? 'token_id',
                    $extra: widget.nftList.elementAt(index),
                  ).push(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 160,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                            border: Border.all(color: Colors.white12, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    imageUrl: getImageUrl(img),
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.black87,
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.all(16),
                                            padding: const EdgeInsets.all(16.0),
                                            child: Opacity(
                                              opacity: 0.4,
                                              child: Assets.logoPng.image(
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          const Align(
                                            alignment: Alignment.bottomCenter,
                                            child: LinearProgressIndicator(
                                              color: Colors.white30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    errorWidget: (context, error, stack) {
                                      return Container(
                                        color: Colors.black87,
                                        child: Stack(
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.all(10),
                                              child: Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Assets.logoPng.image(
                                                    fit: BoxFit.cover,
                                                    color: Colors.white12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: NetworkAvatar(
                                      dimension: 20,
                                      chain: getFromNetworkString(widget.nftList
                                              .elementAt(index)
                                              .chain ??
                                          ''),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            (widget.nftList[index].name ?? '').trim(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
