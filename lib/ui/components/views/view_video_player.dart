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
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/**
 * chewie和videoplayer的问题，播放完毕后没法重播，seekto（ 0）后获取不到进度信息，如果设置looping的话，获取不到进度事件
 * 全屏状态后，如果非全屏的widget状态丢失，全屏状态的controller也会释放，导致异常
 * 多个播放器互斥问题
 */

enum VideoShowStatus {
  cover,
  adver,
  video,
}

class SingleVideoController {
  static VideoPlayerController videoController;
  static VideoPlayerController adverController;
  static _ViewVideoPlayerState currentState;
}

class ViewVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final Function coverBuilder;
  final String adUrl;
  final bool fullscreen;
  final _ShareState state;

  ViewVideoPlayer({
    this.state,
    this.videoUrl,
    this.coverBuilder,
    this.adUrl,
    this.fullscreen = false,
  });

  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState(state);
}

class _ShareState {
  _ShareState();
  VideoPlayerController videoController;
  VideoPlayerController adverController;
  int ref = 0;
  bool pause = false;
  VideoShowStatus status = VideoShowStatus.cover;
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer> {
  _ViewVideoPlayerState(stat) {
    if (stat == null) {
      _state = _ShareState();
    } else {
      _state = stat;
      playerValid = true;
    }
  }

  _ShareState _state;

  //VideoShowStatus status = VideoShowStatus.cover;
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

  void restorePlayStatus() {
    if (_state.videoController != null) {
      startProgressTime();
      _state.videoController.removeListener(videoListener);
      _state.videoController.addListener(videoListener);
    }
  }

  @override
  void initState() {
    _state.ref++;
    print(
        "key:${widget.key},fullscreen:${widget.fullscreen} @@@@@@@@@@@@@@@@@@@@@@@,initState");
    super.initState();
    restorePlayStatus();
  }

  @override
  void dispose() {
    _state.ref--;
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
        print("progressCallback");
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
        _state.status = VideoShowStatus.cover;
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
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: _buildChild(),
    );
  }

  Widget _buildChild() {
    switch (_state.status) {
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
        (_state.videoController.value.isPlaying || _state.pause);
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
        if (SingleVideoController.currentState != null &&
            SingleVideoController.currentState._state != this._state) {
          var disposeVideoController = SingleVideoController.videoController;
          SingleVideoController.videoController = null;
          var currentState = SingleVideoController.currentState;
          currentState._state.videoController = null;
          currentState.disposing = true;
          currentState._state.status = VideoShowStatus.cover;
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
    } catch (e) {
      debugPrint('$e');
    }
  }

  clean() {
    //释放上个播放器
    playerValid = false;
    lastProgressPos = 0;
    position = Duration(seconds: 0);
    lastPlayerRelease();
    destoryVideoPlayer();
  }

  adPlay() async {
    try {
      clean();

      File fileStream = await DefaultCacheManager().getSingleFile(widget.adUrl);
      _state.adverController = VideoPlayerController.file(fileStream);

      _state.status = VideoShowStatus.video;
      SingleVideoController.currentState = this;

      _state.pause = false;
      setState(() {});
      _state.videoController.addListener(videoListener);
      _state.videoController.initialize().then((_) {
        startProgressTime();

        playerValid = true;
        _state.videoController.play();
        setState(() {});
      }).catchError((_) {
        _state.status = VideoShowStatus.cover;
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  videoPlay() async {
    try {
      //释放上个播放器
      if (disposing) return;
      clean();

      _state.videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      _state.status = VideoShowStatus.video;
      SingleVideoController.currentState = this;

      _state.pause = false;
      setState(() {});
      _state.videoController.addListener(videoListener);
      _state.videoController.initialize().then((_) {
        startProgressTime();

        playerValid = true;
        _state.videoController.play();
        setState(() {});
      }).catchError((_) {
        _state.status = VideoShowStatus.cover;
      });
    } catch (e) {
      debugPrint('$e');
    }
  }

  Widget _buildPlayIcon() {
    return GestureDetector(
      onTap: () {
        if (_state.videoController != null) {
          if (_state.pause) {
            _state.pause = false;
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
        //adPlay();
        videoPlay();
      },
      child: widget.coverBuilder != null ? widget.coverBuilder() : Container(),
    );
  }

  Widget _buildAdv() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            VideoPlayer(_state.adverController),
          ],
        ),
      ),
    );
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
    return ((showBar || _state.pause) && isPlay()) || !isPlay();
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
        if (_state.pause) {
          if (_state.videoController == null) return;
          _state.pause = false;
          _state.videoController.play();
        } else {
          _state.pause = true;
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
    if (lastTotalPos == 0) lastTotalPos = 1;
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

    SystemChrome.setEnabledSystemUIOverlays([]);
    if (!widget.fullscreen) {
      //_state.status = VideoShowStatus.cover;
      //setState(() {});

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Material(
            child: RotatedBox(
              child: ViewVideoPlayer(
                videoUrl: widget.videoUrl,
                coverBuilder: widget.coverBuilder,
                adUrl: widget.adUrl,
                fullscreen: true,
                state: _state,
              ),
              quarterTurns: 1,
            ),
          ),
        ),
      ).then((_) {
        return SystemChrome.setEnabledSystemUIOverlays(const [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ]);
      }).then((_) {
        if (mounted) {
          _state.status = VideoShowStatus.video;
          setState(() {});
        }
      });
    } else {
      Navigator.pop(context);
    }
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
            _state.pause = true;
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
            VideoPlayer(_state.videoController),
            _buildVideoController(),
            _buildStatusView(),
          ],
        ),
      ),
    );
  }
}
