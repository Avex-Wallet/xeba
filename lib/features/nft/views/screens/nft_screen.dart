// ignore_for_file: curly_braces_in_flow_control_structures, constant_identifier_names, use_build_context_synchronously

import 'dart:convert';
import 'dart:math';

import 'package:blur/blur.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

import 'package:avex_mobile/core/core.dart';
import 'package:avex_mobile/features/nft/views/screens/video_fullscreen_mode.dart';
import 'package:avex_mobile/features/nft/views/widgets/about_section.widget.dart';
import 'package:avex_mobile/features/nft/views/widgets/attributes_section.widget.dart';
import 'package:avex_mobile/features/nft/views/widgets/detail_section_widget.dart';
import 'package:avex_mobile/features/nft/views/widgets/nft_controller_section.widget.dart';
import 'package:avex_mobile/features/nft/views/widgets/playspeed_chip.dart';
import 'package:avex_mobile/model/nft/nft_model.dart';

enum NftType { Image, Video, Audio, Model }

class NFTScreen extends StatefulWidget {
  const NFTScreen({super.key, required this.data});
  final NFTModel data;

  @override
  State<NFTScreen> createState() => _NFTScreenState();
}

class _NFTScreenState extends State<NFTScreen> {
  NftType nftType = NftType.Image;
  String mediaUrl = "";
  late VideoPlayerController _controller;
  PageController pageController = PageController(initialPage: 0);
  ScreenshotController imageScreenshot = ScreenshotController();
  ScreenshotController infoScreenshot = ScreenshotController();

  double progress = 0.0;
  @override
  void initState() {
    mediaUrl = widget.data.image_url ?? mediaUrl;
    if (widget.data.video_url != null &&
        (widget.data.video_url ?? '').isNotEmpty) {
      mediaUrl = widget.data.video_url ?? '';
      nftType = NftType.Video;
    } else if (widget.data.audio_url != null &&
        (widget.data.audio_url ?? '').isNotEmpty) {
      mediaUrl = widget.data.audio_url ?? '';
      nftType = NftType.Audio;
    } else if (widget.data.model_url != null &&
        (widget.data.model_url ?? '').isNotEmpty) {
      nftType = NftType.Model;
      mediaUrl = widget.data.model_url ?? '';
    }
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(mediaUrl))
      ..initialize().then((_) {
        setState(() {});
      });
  }

  Future<void> shareSS() async {
    bool loading = true;
    try {
      showDialog(
        context: context,
        builder: (context) => Card(
          color: Colors.black12,
          child: Center(
            child: Lottie.asset('assets/loading.json', width: 250),
          ),
        ),
      );
      final directory = await getApplicationDocumentsDirectory();
      final path = await imageScreenshot.captureAndSave(directory.path,
          fileName: 'NFT.png');
      String shareText =
          '\n${widget.data.name}\nAddress: ${widget.data.contract_address}\nToken ID: ${widget.data.token_id}\nChain: ${widget.data.chain?.toUpperCase()}';
      Share.shareXFiles([XFile(path!)], text: shareText);
      if (loading) context.pop();
    } catch (e) {
      if (loading) context.pop();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final img = widget.data.previews?.image_medium_url ?? '';
    logger.d(widget.data);
    return Scaffold(
      backgroundColor: const Color(0xff1E1E1E),
      body: SingleChildScrollView(
        child: Screenshot(
          controller: imageScreenshot,
          child: Stack(
            children: [
              Blur(
                blur: 0.01,
                blurColor: Colors.black.withOpacity(0.01),
                child: CachedNetworkImage(
                  imageUrl: img,
                  errorWidget: (context, url, error) => const Card(),
                  imageBuilder: (context, imageProvider) => Container(
                    width: size.width,
                    height: size.height * .4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Blur(
                      blur: 1,
                      colorOpacity: 0.2,
                      child: Container(),
                    ),
                  ),
                ),
              ),
              //* App bar
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_ios_rounded),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        color: Colors.black54,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            // color: Colors.black26,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: const Icon(Icons.auto_awesome_mosaic_rounded),
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            onTap: () {},
                            enabled: true,
                            child: const Text('Save to Gallery'),
                          ),
                          PopupMenuItem(
                            onTap: shareSS,
                            enabled: true,
                            child: const Text('Share'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: size.height * .2),
                  SizedBox(
                    // height: width * .7,
                    height: (!_controller.value.isPlaying ||
                            nftType != NftType.Video)
                        ? width * .7
                        : (width - 20) / _controller.value.aspectRatio,
                    width: size.width,
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      allowImplicitScrolling: false,
                      children: [
                        //* Image Profile
                        Center(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.square(
                              dimension: size.width * 0.7,
                              child: Stack(
                                children: [
                                  if (nftType != NftType.Image &&
                                      _controller.value.isInitialized)
                                    SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: VideoPlayer(_controller),
                                    ),
                                  // Prfile
                                  CachedNetworkImage(
                                    imageUrl: img,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, url, error) => Card(
                                      child: Stack(
                                        children: [
                                          Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 40),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Assets.logoPng.image(
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Container(
                                              height: 40,
                                              width: size.width * 0.6,
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              color: Colors.white24,
                                              child: Center(
                                                child: Text(
                                                  widget.data.contract
                                                              ?.symbol ==
                                                          'ENS'
                                                      ? 'ENS'
                                                      : 'Image Not Found',
                                                  style: inter.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: widget
                                                                .data
                                                                .contract
                                                                ?.symbol ==
                                                            'ENS'
                                                        ? 20
                                                        : 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: Visibility(
                                      visible: nftType == NftType.Audio,
                                      child: Card(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 12),
                                        shadowColor: Colors.black,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                        ),
                                        color: Colors.white,
                                        child: LottieBuilder.asset(
                                          animate: _controller.value.isPlaying,
                                          'assets/images/music_playing.json',
                                          height: 30,
                                          width: 50,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        //* Image Profile
                        _controller.value.isInitialized &&
                                nftType == NftType.Video
                            ? Center(
                                child: Builder(
                                  builder: (context) {
                                    final int? mediaWidth =
                                        widget.data.video_properties == null
                                            ? null
                                            : jsonDecode(widget.data
                                                .video_properties!)['width'];
                                    final int? mediaHeight =
                                        widget.data.video_properties == null
                                            ? null
                                            : jsonDecode(widget.data
                                                .video_properties!)?['Height'];
                                    final aspect = mediaHeight == null ||
                                            mediaWidth == null
                                        ? _controller.value.aspectRatio
                                        : (mediaWidth / mediaHeight * 1.0);
                                    final w = width - 80;
                                    final h = w / aspect;
                                    return Container(
                                      clipBehavior: Clip.hardEdge,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      margin: const EdgeInsets.all(20),
                                      width: w,
                                      height: h,
                                      child: InkWell(
                                          onTap: () => Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MediaFullScreenMode(
                                                        controller:
                                                            _controller),
                                              )),
                                          child: VideoPlayer(_controller)),
                                    );
                                  },
                                ),
                              )
                            : Container(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  NftTitleSection(size: size, data: widget.data),
                  const SizedBox(height: 8),
                  //* Media Controller
                  Visibility(
                    visible: _controller.value.isInitialized &&
                        nftType != NftType.Image,
                    replacement: Visibility(
                      visible: nftType != NftType.Image,
                      child: const Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CircularProgressIndicator(
                          color: Colors.white24,
                        ),
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: Column(
                        children: [
                          VideoProgressIndicator(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            _controller,
                            allowScrubbing: true,
                            colors: const VideoProgressColors(
                              backgroundColor: Colors.blueGrey,
                              bufferedColor: Colors.blueGrey,
                              playedColor: Colors.white54,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                onPressed: () {
                                  _controller
                                      .seekTo(const Duration(seconds: 0));
                                },
                                icon: Transform.rotate(
                                    angle: pi,
                                    child:
                                        const Icon(CupertinoIcons.forward_end)),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(
                                      seconds: -10 +
                                          _controller
                                              .value.position.inSeconds));
                                },
                                icon: const Icon(Icons.replay_10_rounded),
                              ),
                              FloatingActionButton(
                                backgroundColor: !_controller.value.isPlaying
                                    ? Palette.primary
                                    : Colors.grey,
                                onPressed: () {
                                  setState(() {
                                    _controller.value.isPlaying
                                        ? _controller.pause()
                                        : _controller.play();
                                  });
                                  if (nftType == NftType.Video) {
                                    pageController.animateToPage(
                                        _controller.value.isPlaying ? 1 : 0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                  }
                                },
                                child: Icon(
                                  _controller.value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  _controller.seekTo(Duration(
                                      seconds: 10 +
                                          _controller
                                              .value.position.inSeconds));
                                },
                                icon: const Icon(Icons.forward_10_rounded),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    _controller
                                        .seekTo(const Duration(seconds: 0));
                                  });
                                },
                                icon: const Icon(CupertinoIcons.forward_end),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Container(
                            height: 40,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border:
                                  Border.all(color: Colors.white12, width: 1),
                            ),
                            child:
                                StatefulBuilder(builder: (context, newState) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  PlaySpeedWidget(
                                    onTap: () => newState(() {}),
                                    controller: _controller,
                                    value: 0.5,
                                  ),
                                  PlaySpeedWidget(
                                    onTap: () => newState(() {}),
                                    controller: _controller,
                                    value: 1,
                                  ),
                                  PlaySpeedWidget(
                                    onTap: () => newState(() {}),
                                    controller: _controller,
                                    value: 1.5,
                                  ),
                                  PlaySpeedWidget(
                                    onTap: () => newState(() {}),
                                    controller: _controller,
                                    value: 2.0,
                                  ),
                                ],
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _controller.value.isInitialized,
                    child: const Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(Icons.keyboard_double_arrow_down_rounded),
                      ),
                    ),
                  ),
                  const Divider(),
                  AboutSectionWidget(nftData: widget.data),
                  const Divider(),
                  AttributeSectionWidget(
                    attributes: widget.data.extra_metadata?.attributes,
                  ),
                  Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(width: 20),
                            const Icon(Icons.link, size: 14),
                            Text(
                              ' LINKS',
                              style: inter.copyWith(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            const SizedBox(width: 20),
                            const Chip(
                              elevation: 0,
                              backgroundColor: Colors.white10,
                              avatar: Icon(Icons.link, size: 16),
                              label: Text('Website'),
                            ),
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                final String chain = switch (
                                    widget.data.chain?.toLowerCase() ?? '') {
                                  'polygon' => 'matic',
                                  _ => widget.data.chain ?? "",
                                };
                                logger.i(
                                    'https://opensea.io/assets/$chain/${widget.data.contract_address}/${widget.data.token_id}');
                                InAppWebviewRoute(
                                  title: 'OpenSea',
                                  $extra:
                                      'https://opensea.io/assets/$chain/${widget.data.contract_address}/${widget.data.token_id}',
                                ).push(context);
                              },
                              child: const Chip(
                                elevation: 0,
                                backgroundColor: Colors.white10,
                                avatar: Icon(Icons.call_made_rounded, size: 16),
                                label: Text('View on OpeaSea'),
                              ),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Divider(
                          height: 2,
                        ),
                      ],
                    ),
                  ),
                  DetailSectionWidget(nftData: widget.data),
                  const Divider(),
                  NftControllerSectionWidget(
                      nftData: widget.data, share: shareSS),
                  const SizedBox(height: 20),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NftTitleSection extends StatelessWidget {
  const NftTitleSection({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final NFTModel data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        '${data.name} ${(data.name ?? '').length > 20 ? '\n' : ''}',
        maxLines: 2,
        textAlign: TextAlign.center,
        style: inter.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 22,
        ),
      ),
    );
  }
}
