import 'package:avex_mobile/core/core.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlaySpeedWidget extends StatelessWidget {
  const PlaySpeedWidget(
      {super.key,
      required this.controller,
      required this.value,
      required this.onTap});
  final VideoPlayerController controller;
  final VoidCallback onTap;
  final double value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.setPlaybackSpeed(value);
        onTap();
      },
      child: Chip(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        backgroundColor: controller.value.playbackSpeed != value
            ? const Color(0xff1e1e1e)
            : Palette.secondary,
        elevation: 0,
        label: Text('$value x'),
      ),
    );
  }
}
