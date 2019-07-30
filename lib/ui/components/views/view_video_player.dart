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
    destoryVideoPlayer();
    super.dispose();
  }

  destoryVideoPlayer() {
    if (SingleVideoController.videoController == videoController)
      SingleVideoController.videoController = null;
    if (videoController != null) {
      videoController?.dispose();
      videoController.removeListener(videoListener);
    }
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

  videoListener() {
    setState(() {});
  }

  lastPlayerRelease() async {
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
  }

  videoPlay() async {
    try {
      //释放上个播放器

      await lastPlayerRelease();
      destoryVideoPlayer();

      videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      status = VideoShowStatus.video;
      SingleVideoController.currentKey = widget.key;
      SingleVideoController.currentState = this;

      setState(() {});
      await videoController.initialize();
      videoController.addListener(videoListener);
      setState(() {});
      await videoController.play();
      setState(() {});
    } catch (e) {
      debugPrint('$e');
    }
  }

  Widget _buildPlayIcon() {
    return GestureDetector(
      onTap: () {
        if (videoController != null) {
          videoController.play();
        }
        setState(() {});
      },
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            Icons.play_arrow,
            size: MyTheme.sz(40),
            color: Colors.black54,
          ),
          color: Colors.white60,
        ),
      ),
    );
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

  Widget _buildCentorStatus() {
    if (videoController != null) {
      if (!videoController.value.initialized) {
        return CircularProgressIndicator();
      } else if (videoController.value.isBuffering) {
        return CircularProgressIndicator();
      } else if (!videoController.value.isPlaying) {
        return _buildPlayIcon();
      }
    }
    return Container();
  }

  Widget _buildProgressBar() {
    double value = 0;
    try {
      if (videoController != null) {
        value = videoController.value.position.inMilliseconds /
            videoController.value.duration.inMilliseconds;
      }
    } catch (e) {}
    return Container(
      height: 3,
      child: LinearProgressIndicator(
        backgroundColor: Colors.black54,
        value: value,
      ),
    );
  }

  Widget _buildVideoController() {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: 50,
            //color: Colors.black54,
          ),
          Expanded(
            child: Center(
              child: _buildCentorStatus(),
            ),
          ),
          Container(
            height: 50,
            //color: Colors.black54,
          ),
          _buildProgressBar()
        ],
      ),
    );
  }

  Widget _buildVideo() {
    return GestureDetector(
      onDoubleTap: () {
        if (videoController != null) {
          if (videoController.value.isPlaying)
            videoController.pause();
          else
            videoController.play();
        }
        setState(() {});
      },
      child: Stack(
        children: <Widget>[
          VideoPlayer(SingleVideoController.videoController),
          _buildVideoController(),
        ],
      ),
    );
  }
}
