import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
import 'dart:async';
import 'dart:collection';
import 'package:video_player/video_player.dart';
import 'package:rxdart/rxdart.dart';
import 'package:cicitv/common/time_helper.dart';

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
  bool fullscreen;

  ViewVideoPlayer(
    Key id, {
    this.videoUrl,
    this.coverBuilder,
    this.advUrl,
    this.fullscreen,
  }) : super(key: id);

  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState();
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer> {
  _ViewVideoPlayerState();

  VideoShowStatus status = VideoShowStatus.cover;
  VideoPlayerController videoController;
  bool pause = false;
  bool showBar = false;
  bool playerValid = false;
  bool disposing = false;
  Duration position = Duration(seconds: 0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    destoryVideoPlayer();
    showCtrlTimer?.cancel();
    super.dispose();
  }

  destoryVideoPlayer() {
    if (SingleVideoController.videoController == videoController)
      SingleVideoController.videoController = null;
    if (videoController != null) {
      try {
        disposing = true;
        var disposeVideoController = videoController;
        videoController = null;
        disposeVideoController.removeListener(videoListener);
        status = VideoShowStatus.cover;
        setState(() {
          disposeVideoController.pause();
          Timer(Duration(milliseconds: 500), () {
            disposeVideoController.dispose().then((_) {
              disposing = false;
            }).catchError((e) {
              disposing = false;
            });
          });
        });
      } catch (e) {
        disposing = false;
      }
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

  bool isPlaying() {
    return playerValid &&
        videoController != null &&
        videoController.value != null &&
        videoController.value.duration != null &&
        videoController.value.isPlaying;
  }

  //包括暂停状态
  bool isPlay() {
    return playerValid &&
        videoController != null &&
        videoController.value != null &&
        videoController.value.duration != null &&
        (videoController.value.isPlaying || pause);
  }

  videoListener() {
    if (videoController == null) return;
    if (videoController.value.hasError) {
      print('${videoController.value.errorDescription}');
      destoryVideoPlayer();
      return;
    }
    // //print('${videoController.value}');
    if (isPlay()) {
      //不加timer视频播放会越来越卡，还不知道原因
      Timer(Duration(milliseconds: 100), () {
        videoController.position.then((duration) {
          position = duration;
        });
      });
    }
    setState(() {});
  }

  lastPlayerRelease() {
    try {
      if (SingleVideoController.videoController != null) {
        if (SingleVideoController.currentState != this) {
          if (widget.key != SingleVideoController.currentKey) {
            var disposeVideoController = SingleVideoController.videoController;
            SingleVideoController.videoController = null;
            var currentState = SingleVideoController.currentState;
            currentState.videoController = null;
            currentState.disposing = true;
            currentState = SingleVideoController.currentState;
            currentState.status = VideoShowStatus.cover;
            currentState.playerValid = false;
            disposeVideoController.removeListener(currentState.videoListener);
            currentState.setState(() {
              disposeVideoController.pause();
              Timer(Duration(milliseconds: 500), () {
                disposeVideoController.dispose().then((_) {
                  try {
                    currentState.disposing = false;
                  } catch (e) {
                    debugPrint('$e');
                  }
                }).catchError((e) {
                  try {
                    currentState.disposing = false;
                  } catch (e) {
                    debugPrint('$e');
                  }
                });
              });
            });
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
      if (disposing) return;
      playerValid = false;
      lastPlayerRelease();
      destoryVideoPlayer();
      videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      status = VideoShowStatus.video;
      SingleVideoController.currentKey = widget.key;
      SingleVideoController.currentState = this;

      pause = false;
      setState(() {});
      videoController.addListener(videoListener);
      videoController.initialize().then((_) {
        playerValid = true;
        videoController.play();
        setState(() {});
      }).catchError((_) {
        status = VideoShowStatus.cover;
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Widget _buildPlayIcon() {
    return GestureDetector(
      onTap: () {
        if (videoController != null) {
          if (pause) {
            pause = false;
            videoController.play();
          } else
            videoPlay();
        }
        setState(() {});
      },
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            isPlay() ? Icons.play_arrow : Icons.reply,
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

  Widget _buildBottomProgressBar() {
    double value = 0;
    try {
      if (isPlay()) {
        value = position.inMilliseconds /
            videoController.value.duration.inMilliseconds;
      }
    } catch (e) {}
    return shouldShowCtrlBar()
        ? Container(height: 0)
        : Container(
            height: 3,
            child: LinearProgressIndicator(
              backgroundColor: Colors.black54,
              value: value,
            ),
          );
  }

  Widget _buildTitleBar() {
    return Container(
      height: 50,
      //color: Colors.black54,
    );
  }

  Widget _buildVideoController() {
    return Container(
      child: Column(
        children: <Widget>[
          _buildTitleBar(),
          Expanded(
            child: Center(),
          ),
          _buildCtrlBar(),
          _buildBottomProgressBar()
        ],
      ),
    );
  }

  Timer showCtrlTimer;
  int showCount = 5;
  _showCtrlBar() {
    showBar = true;
    showCount = 5;
    if (showCtrlTimer == null) {
      showCtrlTimer = Timer.periodic(Duration(seconds: 1), (t) {
        if (--showCount == 0) {
          t.cancel();
          showCtrlTimer = null;
          showBar = false;
          setState(() {});
        }
      });
      setState(() {});
    }
  }

  bool shouldShowCtrlBar() {
    return (showBar && isPlay());
  }

  Widget _buildCtrlBarPlayIcon() {
    Icon playIcon = Icon(Icons.play_arrow, color: Colors.white);
    if (videoController != null) {
      if (isPlaying()) {
        playIcon = Icon(Icons.pause, color: Colors.white);
      }
    }
    return IconButton(
      onPressed: () {
        _showCtrlBar();
        if (pause) {
          if (videoController == null) return;
          pause = false;
          videoController.play();
        } else {
          pause = true;
          videoController.pause();
        }
        setState(() {});
      },
      icon: playIcon,
    );
  }

  Widget _buildCtrlBarTimer() {
    String showTime = '00:00 / 00:00';
    if (videoController != null && videoController.value != null && isPlay()) {
      String totalTime = "";
      totalTime = TimeHelper.getTimeText(
          videoController.value.duration.inSeconds.toDouble());
      String curTime = TimeHelper.getTimeText(position.inSeconds.toDouble());
      showTime = curTime + ' / ' + totalTime;
    }

    return Text(showTime, style: TextStyle(color: Colors.white));
  }

  double dragPos = 0;
  bool draging = false;
  double lastProgressPos = 0;
  double lastTotalPos = 0;

  Widget _buildCtrlBarProgess() {
    double pos = 0;
    double total = 0;
    if (isPlay()) {
      if (videoController.value.duration.inSeconds.toDouble() > 1) {
        pos = position.inSeconds.toDouble();
        total = videoController.value.duration.inSeconds.toDouble();
      }
    }
    //debugPrint('pos:$pos,total:$total,dragPos:$dragPos');
    if (draging) {
      pos = dragPos;
    }
    if ((total != 0 && pos <= total) || (total == 0 && pos == 0)) {
      lastTotalPos = total;
      lastProgressPos = pos;
    }

    return Expanded(
      child: Slider(
        divisions: lastTotalPos.toInt(),
        label: TimeHelper.getTimeText(lastProgressPos),
        onChanged: (value) {
          _showCtrlBar();
          dragPos = value;
          print("onChanged");
        },
        onChangeStart: (value) {
          print("onChangeStart");
          draging = true;
        },
        onChangeEnd: (value) {
          draging = false;
          if (isPlay()) {
            videoController.seekTo(Duration(seconds: value.toInt()));
          }
          print("onChangeEnd");
        },
        min: 0,
        max: lastTotalPos,
        value: lastProgressPos,
      ),
    );
  }

  Widget _buildCtrlBarFullScreen() {
    Icon playIcon = Icon(Icons.fullscreen, color: Colors.white);
    return IconButton(
      onPressed: () {},
      icon: playIcon,
    );
  }

  Widget _buildCtrlBar() {
    return shouldShowCtrlBar()
        ? Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0, 1],
                colors: [
                  Colors.transparent,
                  Colors.black54,
                ],
              ),
            ),
            height: 50,
            alignment: Alignment.bottomLeft,
            child: Container(
              height: 40,
              child: Row(
                children: <Widget>[
                  _buildCtrlBarPlayIcon(),
                  _buildCtrlBarTimer(),
                  _buildCtrlBarProgess(),
                  _buildCtrlBarFullScreen()
                ],
              ),
            ),
          )
        : Container();
  }

  Widget _buildStatusView() {
    return Center(
      child: _buildCentorStatus(),
    );
  }

  Widget _buildVideo() {
    return GestureDetector(
      onTap: () {
        _showCtrlBar();
      },
      onDoubleTap: () {
        if (isPlay()) {
          if (isPlaying()) {
            pause = true;
            videoController.pause();
          } else
            videoController.play();
        }
        setState(() {});
      },
      child: Stack(
        children: <Widget>[
          VideoPlayer(SingleVideoController.videoController),
          _buildVideoController(),
          _buildStatusView(),
        ],
      ),
    );
  }
}
