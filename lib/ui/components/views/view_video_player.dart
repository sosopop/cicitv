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
import 'package:flutter/services.dart';
import 'dart:io';

/**
 * chewie和videoplayer的问题，播放完毕后没法重播，seekto（ 0）后获取不到进度信息，如果设置looping的话，获取不到进度事件
 * 全屏状态后，如果非全屏的widget状态丢失，全屏状态的controller也会释放，导致异常
 * 多个播放器互斥问题
 */

typedef Widget AnimationPageBuilder(BuildContext context,
    Animation<double> animation, Animation<double> secondaryAnimation);

class DialogRoute<T> extends PageRoute<T> {
  final Color barrierColor;
  final String barrierLabel;
  final bool maintainState;
  final Duration transitionDuration;
  final AnimationPageBuilder builder;

  DialogRoute({
    this.barrierColor = const Color(0x44FFFFFF),
    this.barrierLabel = "full",
    this.maintainState = true,
    this.transitionDuration = const Duration(milliseconds: 300),
    @required this.builder,
  }) : assert(barrierColor != Colors.transparent,
            "The barrierColor must not be transparent.");

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder(context, animation, secondaryAnimation);
  }
}

class FullScreenRoute<T> extends DialogRoute<T> {
  FullScreenRoute({WidgetBuilder builder})
      : super(builder: (ctx, a, s) => fullScreenBuilder(ctx, builder, a, s));

  static Widget fullScreenBuilder(
    BuildContext context,
    WidgetBuilder builder,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget child) {
        return Opacity(
          opacity: animation.value,
          child: builder(context),
        );
      },
    );
  }
}

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
  final bool fullscreen;
  final _ShareState state;

  ViewVideoPlayer(
    Key id, {
    this.state,
    this.videoUrl,
    this.coverBuilder,
    this.advUrl,
    this.fullscreen = false,
  }) : super(key: id);

  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState(state);
}

class _ShareState {
  _ShareState();
  VideoPlayerController videoController;
  int ref = 0;
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer> {
  _ViewVideoPlayerState(stat) {
    if (stat == null) {
      _state = _ShareState();
    } else {
      _state = stat;
      status = VideoShowStatus.video;
      playerValid = true;
    }
  }

  _ShareState _state;

  VideoShowStatus status = VideoShowStatus.cover;
  bool pause = false;
  bool showBar = false;
  bool playerValid = false;
  //缓存当前时间位置
  Duration position = Duration(seconds: 0);

  //隐藏控制栏的定时器
  Timer showCtrlTimer;
  Timer progressTimer;
  int showCount = 5;
  //拖拽使用
  double dragPos = 0;
  bool draging = false;
  double lastProgressPos = 0;
  double lastTotalPos = 0;
  bool disposing = false;
  VideoPlayerValue lastValue;

  void startProgressTime() {
    if (progressTimer == null) {
      progressTimer = Timer.periodic(Duration(seconds: 1), progressCallback);
    }
  }

  @override
  void initState() {
    print(
        "key:${widget.key},fullscreen:${widget.fullscreen} @@@@@@@@@@@@@@@@@@@@@@@,initState");
    super.initState();

    if (widget.fullscreen) {
      startProgressTime();
      _state.videoController?.addListener(videoListener);

      SystemChrome.setEnabledSystemUIOverlays([]).then((_) {
        return SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
      });
    }
  }

  @override
  void dispose() {
    if (_state.ref == 0) {
      destoryVideoPlayer();
      print(
          "key:${widget.key},fullscreen:${widget.fullscreen} @@@@@@@@@@@@@@@@@@@@@@@,state dispose");
    } else {
      closeTimer();
      print(
          "key:${widget.key},fullscreen:${widget.fullscreen} @@@@@@@@@@@@@@@@@@@@@@@,dispose");
    }
    super.dispose();
  }

  progressCallback(timer) {
    if (mounted) {
      if (isPlay()) {
        _state.videoController.position.then(
          (duration) {
            if (mounted) {
              position = duration;
            }
          },
        );
      }
      setState(() {});
    }
  }

  void closeTimer() {
    showCtrlTimer?.cancel();
    showCtrlTimer = null;
    progressTimer?.cancel();
    progressTimer = null;
  }

  destoryVideoPlayer() {
    closeTimer();

    //print("key:${widget.key}@@@@@@@@@@@@@@@@@@@@@@@,destoryVideoPlayer");
    if (SingleVideoController.videoController == _state.videoController)
      SingleVideoController.videoController = null;
    if (_state.videoController != null) {
      try {
        disposing = true;
        var disposeVideoController = _state.videoController;
        _state.videoController = null;
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
        _state.videoController != null &&
        _state.videoController.value != null &&
        _state.videoController.value.duration != null &&
        _state.videoController.value.isPlaying;
  }

  //包括暂停状态
  bool isPlay() {
    return playerValid &&
        _state.videoController != null &&
        _state.videoController.value != null &&
        _state.videoController.value.duration != null &&
        (_state.videoController.value.isPlaying || pause);
  }

  videoListener() {
    //print('${_state.videoController.value}');
    if (mounted) {
      if (_state.videoController == null) return;
      if (_state.videoController.value.hasError) {
        print('${_state.videoController.value.errorDescription}');
        destoryVideoPlayer();
        return;
      }
    }
  }

  lastPlayerRelease() {
    //print("key:${widget.key}@@@@@@@@@@@@@@@@@@@@@@@,lastPlayerRelease");
    try {
      if (SingleVideoController.videoController != null) {
        if (SingleVideoController.currentState != this) {
          if (widget.key != SingleVideoController.currentKey) {
            var disposeVideoController = SingleVideoController.videoController;
            SingleVideoController.videoController = null;
            var currentState = SingleVideoController.currentState;
            currentState._state.videoController = null;
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
      lastProgressPos = 0;
      position = Duration(seconds: 0);
      lastPlayerRelease();
      destoryVideoPlayer();
      _state.videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      status = VideoShowStatus.video;
      SingleVideoController.currentKey = widget.key;
      SingleVideoController.currentState = this;

      pause = false;
      setState(() {});
      _state.videoController.addListener(videoListener);
      _state.videoController.initialize().then((_) {
        startProgressTime();

        playerValid = true;
        _state.videoController.play();
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
        if (_state.videoController != null) {
          if (pause) {
            pause = false;
            _state.videoController.play();
          } else
            videoPlay();
        }
        setState(() {});
      },
      child: ClipOval(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Icon(
            isPlay() ? Icons.play_arrow : Icons.replay,
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
    if (_state.videoController != null) {
      if (!_state.videoController.value.initialized) {
        return CircularProgressIndicator();
      } else if (_state.videoController.value.isBuffering) {
        return CircularProgressIndicator();
      } else if (!_state.videoController.value.isPlaying) {
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
            _state.videoController.value.duration.inMilliseconds;
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

  _showCtrlBar() {
    showBar = true;
    showCount = 5;
    if (showCtrlTimer == null) {
      showCtrlTimer = Timer.periodic(Duration(seconds: 1), (t) {
        if (--showCount == 0) {
          t.cancel();
          showCtrlTimer = null;
          showBar = false;
          if (mounted) {
            setState(() {});
          }
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
    if (_state.videoController != null) {
      if (isPlaying()) {
        playIcon = Icon(Icons.pause, color: Colors.white);
      }
    }
    return IconButton(
      onPressed: () {
        _showCtrlBar();
        if (pause) {
          if (_state.videoController == null) return;
          pause = false;
          _state.videoController.play();
        } else {
          pause = true;
          _state.videoController.pause();
        }
        setState(() {});
      },
      icon: playIcon,
    );
  }

  Widget _buildCtrlBarTimer() {
    String showTime = '00:00 / 00:00';
    if (_state.videoController != null &&
        _state.videoController.value != null &&
        isPlay()) {
      String totalTime = "";
      totalTime = TimeHelper.getTimeText(
          _state.videoController.value.duration.inSeconds.toDouble());
      String curTime = TimeHelper.getTimeText(position.inSeconds.toDouble());
      showTime = curTime + ' / ' + totalTime;
    }

    return Text(showTime, style: TextStyle(color: Colors.white));
  }

  Widget _buildCtrlBarProgess() {
    double pos = 0;
    double total = 0;
    if (isPlay()) {
      if (_state.videoController.value.duration.inSeconds.toDouble() > 1) {
        pos = position.inSeconds.toDouble();
        total = _state.videoController.value.duration.inSeconds.toDouble();
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
          setState(() {});
        },
        onChangeStart: (value) {
          print("onChangeStart");
          draging = true;
        },
        onChangeEnd: (value) {
          draging = false;
          if (isPlay()) {
            _state.videoController.seekTo(Duration(seconds: value.toInt()));
          }
          print("onChangeEnd");
        },
        min: 0,
        max: lastTotalPos,
        value: lastProgressPos,
      ),
    );
  }

  _showFullScreen() {
    showCtrlTimer?.cancel();
    _state.videoController.removeListener(videoListener);
    Future.delayed(Duration(milliseconds: 200)).then((_) {
      if (!widget.fullscreen) {
        _state.ref++;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Material(
              child: ViewVideoPlayer(
                widget.key,
                videoUrl: widget.videoUrl,
                coverBuilder: widget.coverBuilder,
                advUrl: widget.advUrl,
                fullscreen: true,
                state: _state,
              ),
            ),
          ),
        ).then((_) {
          return SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }).then((_) {
          return SystemChrome.restoreSystemUIOverlays();
        }).then((_) {
          SystemChrome.setEnabledSystemUIOverlays(const [
            SystemUiOverlay.top,
            SystemUiOverlay.bottom,
          ]);
        });
      } else {
        _state.ref--;
        Navigator.pop(context);
      }
    });
  }

  Widget _buildCtrlBarFullScreen() {
    Icon fullIcon = Icon(
        widget.fullscreen ? Icons.fullscreen_exit : Icons.fullscreen,
        color: Colors.white);
    return IconButton(
      onPressed: () {
        _showFullScreen();
      },
      icon: fullIcon,
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
            _state.videoController.pause();
          } else
            _state.videoController.play();
        }
        setState(() {});
      },
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            VideoPlayer(SingleVideoController.videoController),
            _buildVideoController(),
            _buildStatusView(),
          ],
        ),
      ),
    );
  }
}
