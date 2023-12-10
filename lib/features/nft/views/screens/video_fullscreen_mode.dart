import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class MediaFullScreenMode extends StatefulWidget {
  const MediaFullScreenMode({super.key, required this.controller});
  final VideoPlayerController controller;

  @override
  State<MediaFullScreenMode> createState() => _MediaFullScreenModeState();
}

class _MediaFullScreenModeState extends State<MediaFullScreenMode> {
  bool isVisible = true;
  bool isLand = true;

  @override
  void initState() {
    super.initState();
    if (widget.controller.value.size.height >
        widget.controller.value.size.height) {
      setState(() {
        isLand = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: GestureDetector(
            onTap: () => setState(() => isVisible = !isVisible),
            child: Stack(
              children: [
                //* Video

                Align(
                  alignment: Alignment.center,
                  child: AspectRatio(
                    aspectRatio: !isLand
                        ? widget.controller.value.aspectRatio
                        : 1 / widget.controller.value.aspectRatio,
                    child: Stack(
                      children: [
                        RotatedBox(
                          quarterTurns: isLand ? 1 : 0,
                          child: AspectRatio(
                              aspectRatio: widget.controller.value.aspectRatio,
                              child: VideoPlayer(widget.controller)),
                        ),
                        RotatedBox(
                          quarterTurns: isLand ? 1 : 0,
                          child: Visibility(
                            visible: isVisible,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 16, horizontal: 10),
                              child: Text(
                                'Powered by Avex',
                                style: inter.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white38,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                        //* Rotate
                        Align(
                          alignment: isLand
                              ? Alignment.bottomRight
                              : Alignment.topRight,
                          child: Visibility(
                            visible: isVisible,
                            child: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () => context.pop(),
                            ),
                          ),
                        ),
                        //* Rotate
                        Align(
                          alignment: isLand
                              ? Alignment.bottomLeft
                              : Alignment.bottomRight,
                          child: Visibility(
                            visible: isVisible,
                            child: IconButton(
                              icon: Icon(isLand
                                  ? Icons.fullscreen_exit
                                  : Icons.fullscreen),
                              onPressed: () => setState(() => isLand = !isLand),
                            ),
                          ),
                        ),
                        //* Progress Indicator
                        Align(
                          alignment: isLand
                              ? Alignment.centerLeft
                              : Alignment.bottomCenter,
                          child: Visibility(
                            visible: isVisible,
                            child: Container(
                              // width: size.width,
                              margin: EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: isLand ? 0 : 20,
                              ),
                              child: RotatedBox(
                                quarterTurns: isLand ? 1 : 0,
                                child: VideoProgressIndicator(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  widget.controller,
                                  allowScrubbing: true,
                                  colors: const VideoProgressColors(
                                    backgroundColor: Colors.blueGrey,
                                    bufferedColor: Colors.blueGrey,
                                    playedColor: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        //* Player Controller
                        Align(
                          alignment: Alignment.center,
                          child: Visibility(
                            visible: isVisible,
                            child: RotatedBox(
                              quarterTurns: isLand ? 1 : 0,
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    iconSize: 30,
                                    onPressed: () {
                                      widget.controller.seekTo(Duration(
                                          seconds: -10 +
                                              widget.controller.value.position
                                                  .inSeconds));
                                    },
                                    icon: const Icon(Icons.replay_10_rounded),
                                  ),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.controller.value.isPlaying
                                            ? widget.controller.pause()
                                            : widget.controller.play();
                                      });
                                    },
                                    iconSize: 40,
                                    icon: Icon(
                                      widget.controller.value.isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  IconButton(
                                    iconSize: 30,
                                    onPressed: () {
                                      widget.controller.seekTo(Duration(
                                          seconds: 10 +
                                              widget.controller.value.position
                                                  .inSeconds));
                                    },
                                    icon: const Icon(Icons.forward_10_rounded),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
