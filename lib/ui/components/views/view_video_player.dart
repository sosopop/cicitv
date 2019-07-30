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

enum __Command {
  nothing,
  dispose,
  play,
}

typedef __ResetCallback = void Function();

class SingleVideoController {
  static __Command _command = __Command.nothing;

  static bool running = false;
  static String videoUrl;
  static HashMap<Key, _ViewVideoPlayerState> _resetMap =
      HashMap<Key, _ViewVideoPlayerState>();

  //释放动作
  static Future<void> _actionDispose() async {
    if (_videoPlayerController != null) {
      await _videoPlayerController.dispose();
      _videoPlayerController = null;
    }
  }

  //播放
  static Future<void> _actionPlay() async {
    if (videoUrl != null) {
      _videoPlayerController = VideoPlayerController.network(videoUrl);
      await _videoPlayerController.initialize();
      await _videoPlayerController.play();
    }
  }

  //通过状态机同步数据,数据为命令
  static void run() async {
    if (running) {
      return;
    }
    running = true;
    try {
      while (_command != __Command.nothing) {
        //使用command作为状态机传入数据，_command后面可能会被冲掉。
        __Command command = _command;
        _command = __Command.nothing;

        debugPrint('cmd:$command');
        switch (command) {
          case __Command.dispose:
            {
              await _actionDispose();
            }
            break;
          case __Command.play:
            {
              await _actionDispose();
              await _actionPlay();
            }
            break;
          default:
        }
      }
    } catch (e) {
      debugPrint('RUN ERROR: $e');
    }
    running = false;
  }

  static Future<void> startPlay(
      Key id, String videoUrl, _ViewVideoPlayerState state) async {
    debugPrint('method startPlay:$videoUrl');
    SingleVideoController.videoUrl = videoUrl;
    _command = __Command.play;
    _resetMap.forEach((k, v) {
      if (k != id) {}
    });
    _resetMap.clear();
    _resetMap[id] = state;
    run();
  }

  static VideoPlayerController _videoPlayerController;
  static VideoPlayerController _advPlayerController;
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
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

  Widget _buildCover() {
    return GestureDetector(
      onTap: () async {
        await SingleVideoController.startPlay(
          widget.key,
          widget.videoUrl,
          this,
        );
        setState(
          () {
            status = VideoShowStatus.video;
          },
        );
      },
      child: widget.coverBuilder != null ? widget.coverBuilder() : Container(),
    );
  }

  Widget _buildAdv() {
    return Container();
  }

  Widget _buildVideo() {
    return VideoPlayer(SingleVideoController._videoPlayerController);
  }
}
