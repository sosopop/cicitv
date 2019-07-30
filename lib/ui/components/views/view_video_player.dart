import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
import 'dart:async';
import 'dart:collection';
import 'package:video_player/video_player.dart';
import 'package:rxdart/rxdart.dart';

enum VideoShowStatus {
  cover,
  adver,
  video,
}

class SingleVideoController {
  static VideoPlayerController videoController;
  static VideoPlayerController adverController;
  static _ViewVideoPlayerState currentState;
  static Key currentKey;
}

class ViewVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Function coverBuilder;
  final String advUrl;

  ViewVideoPlayer(
    Key id, {
    this.videoUrl,
    this.coverBuilder,
    this.advUrl,
  }) : super(key: id);

  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState();
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer> {
  _ViewVideoPlayerState();

  VideoShowStatus status = VideoShowStatus.cover;
  VideoPlayerController videoController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    if (SingleVideoController.videoController == videoController)
      SingleVideoController.videoController = null;
    videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case VideoShowStatus.cover:
        return _buildCover();
      case VideoShowStatus.adver:
        return _buildAdv();
      case VideoShowStatus.video:
        return _buildVideo();
    }
    return Container();
  }

  void reset() {
    setState(() {
      status = VideoShowStatus.cover;
    });
  }

  videoPlay() async {
    try {
      //释放上个播放器
      try {
        if (SingleVideoController.videoController != null) {
          if (SingleVideoController.currentState != this) {
            await SingleVideoController.videoController.pause();
            if (widget.key != SingleVideoController.currentKey) {
              SingleVideoController.currentState.status = VideoShowStatus.cover;
              SingleVideoController.currentState.setState(
                () {},
              );
            }
          }
        }
      } catch (e) {
        debugPrint('$e');
      }

      if (videoController != null) {
        await videoController.dispose();
        videoController = null;
      }
      videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      await videoController.initialize();
      await videoController.play();

      SingleVideoController.currentKey = widget.key;
      SingleVideoController.currentState = this;
      setState(
        () {
          status = VideoShowStatus.video;
        },
      );
    } catch (e) {
      debugPrint('$e');
    }
  }

  Widget _buildCover() {
    return GestureDetector(
      onTap: () {
        videoPlay();
      },
      child: widget.coverBuilder != null ? widget.coverBuilder() : Container(),
    );
  }

  Widget _buildAdv() {
    return Container();
  }

  Widget _buildVideo() {
    return VideoPlayer(SingleVideoController.videoController);
  }
}
