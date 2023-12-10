import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/nft/controllers/all_chain_nft.controller.dart';
import 'package:avex_mobile/features/nft/controllers/current_chain_nft.controller.dart';
import 'package:avex_mobile/features/nft/views/widgets/all_nft_grid.dart';
import 'package:avex_mobile/main.dart';

// final _loading = StateProvider.autoDispose<bool>((ref) => false);

class DashboardNFTTabV2 extends ConsumerStatefulWidget {
  const DashboardNFTTabV2({super.key});

  @override
  ConsumerState<DashboardNFTTabV2> createState() => _DashboardNFTTabState();
}

class _DashboardNFTTabState extends ConsumerState<DashboardNFTTabV2> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent ==
          scrollController.position.pixels) {
        paginate();
      }
    });
  }

  Future<void> paginate() async {
    // ref.read(_loading.notifier).state = true;
    if (ref.read(allChainSelected)) {
      await ref.read(allChainNftProvider.notifier).fetchMoreNFTs(context);
    } else {
      await ref.read(nftProvider.notifier).fetchMoreNFTs(context);
    }
    // ref.read(_loading.notifier).state = true;
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isAllChainSelected = ref.watch(allChainSelected);
    if (isAllChainSelected) {
      final nftList = ref.watch(allChainNftProvider);
      return RefreshIndicator(
        onRefresh: () async =>
            ref.read(allChainNftProvider.notifier).fetchNFTs(),
        child:
            AllNFTWidget(scrollController: scrollController, nftList: nftList),
      );
    }
    final chain = ref.watch(currentNetworkChainProvider);
    final nftList = ref.watch(nftProvider)[chain];
    if (nftList == null || nftList.isEmpty) {
      return const NoNftFound();
    }
    return RefreshIndicator(
      onRefresh: () async => ref.read(nftProvider.notifier).fetchNFTs(),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 6 / 7,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        controller: scrollController,
        shrinkWrap: true,
        key: const PageStorageKey('myListView2'),
        itemCount: nftList.length,
        itemBuilder: (context, index) {
          final img = nftList.elementAt(index).previews?.image_medium_url ?? '';
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
                      contract: nftList.elementAt(index).contract_address ?? '',
                      tokenId: nftList.elementAt(index).token_id ?? 'token_id',
                      $extra: nftList.elementAt(index),
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
                              border:
                                  Border.all(color: Colors.white12, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
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
                                              padding:
                                                  const EdgeInsets.all(16.0),
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
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              (nftList[index].name ?? '').trim(),
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
      ),
    );
  }
}

class NoNftFound extends StatelessWidget {
  const NoNftFound({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(
              color: Colors.white30,
            ),
          ),
          color: const Color(0xff111013),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/images/no_nft.png',
              height: 100,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          'No nfts detected!',
          style: inter.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.6,
          child: Text(
            'Secure you’re nfts by saving them on Avex. Start by receiving new ones or connect to existing collection',
            textAlign: TextAlign.center,
            style: urbunist.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}
