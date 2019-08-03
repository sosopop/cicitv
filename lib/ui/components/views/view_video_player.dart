import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/common/mytheme.dart';
import 'dart:async';
import 'package:video_player/video_player.dart';
import 'package:cicitv/common/time_helper.dart';
import 'dart:io';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:screen/screen.dart';

/*
 * chewie和videoplayer的问题，播放完毕后没法重播，seekto（ 0）后获取不到进度信息，如果设置looping的话，获取不到进度事件
 * 全屏状态后，如果非全屏的widget状态丢失，全屏状态的controller也会释放，导致异常
 * 多个播放器互斥问题
 */

enum VideoShowStatus {
  cover,
  adver,
  video,
}

enum VideoDragType {
  position,
  volume,
  brightness,
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
  //广告是否播放完毕
  bool adplayComplete = false;
  //视频是否播放完毕
  bool videoInitComplete = false;
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

  //隐藏控制栏的定时器
  Timer showCtrlTimer;
  Timer progressTimer;
  int showCount = 5;
  //拖拽使用
  double dragPos = 0;
  bool draging = false;
  double lastProgressPos = 0;
  double lastTotalPos = 0;
  bool videoDisposing = false;
  bool adverDisposing = false;
  bool fullscreenState = false;

  //位置拖动状态
  VideoDragType dragType;
  double posSeconds = 0;
  double posBrightness = 0;
  double posVolume = 0;

  void restorePlayStatus() {
    if (_state.videoController != null) {
      _state.videoController.removeListener(videoListener);
      _state.videoController.addListener(videoListener);
    }
    if (_state.adverController != null) {
      _state.adverController.removeListener(adverListener);
      _state.adverController.addListener(adverListener);
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
      adverRelease();
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
        videoDisposing = true;
        var disposeVideoController = _state.videoController;
        _state.videoController = null;
        disposeVideoController.removeListener(videoListener);
        _state.status = VideoShowStatus.cover;
        setState(() {
          disposeVideoController.pause();
          Timer(Duration(milliseconds: 500), () {
            print('@@@ video release ref:${_state.ref}');
            disposeVideoController.dispose().then((_) {
              videoDisposing = false;
            }).catchError((e) {
              videoDisposing = false;
            });
          });
        });
      } catch (e) {
        videoDisposing = false;
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
    if (!fullscreenState) {
      switch (_state.status) {
        case VideoShowStatus.cover:
          return _buildCover();
        case VideoShowStatus.adver:
          return _buildAdv();
        case VideoShowStatus.video:
          return _buildVideo();
      }
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

  DateTime lastRefreshTime = DateTime.now();
  refresh() {
    if (_state.videoController == null) return;

    // 检查是否不可显示
    if (!widget.fullscreen) {
      try {
        if (isPlaying()) {
          final screenSize = MediaQuery.of(context).size;
          final box = context.findRenderObject() as RenderBox;
          final size = box.size;
          final pos = box.localToGlobal(Offset.zero);
          //print('${pos}');
          if (size.height / 2 + pos.dy < 0) {
            _state.videoController.pause();
          } else if (pos.dy > screenSize.height - size.height / 2) {
            _state.videoController.pause();
          } else if (pos.dx < -screenSize.width / 2) {
            _state.videoController.pause();
          } else if (pos.dx > screenSize.width / 2) {
            _state.videoController.pause();
          }
        }
      } catch (e) {}
    }

    //print('${_state.videoController.value}');

    if (_state.videoController.value.hasError) {
      print('${_state.videoController.value.errorDescription}');
      destoryVideoPlayer();
      return;
    }
  }

  //不要在这里面调用控制函数，否则会又调入进来，死循环
  videoListener() {
    if (mounted) {
      if (DateTime.now().difference(lastRefreshTime) >
          Duration(milliseconds: 300)) {
        //最少间隔300毫秒回调一次
        lastRefreshTime = DateTime.now();
        refresh();
      }
      setState(() {});
    }
  }

  lastPlayerRelease() {
    //print("key:${widget.key}@@@@@@@@@@@@@@@@@@@@@@@,lastPlayerRelease");
    try {
      if (SingleVideoController.videoController != null) {
        if (SingleVideoController.currentState != null &&
            SingleVideoController.currentState._state != this._state) {
          SingleVideoController.videoController = null;
          var currentState = SingleVideoController.currentState;
          currentState.destoryVideoPlayer();
        }
      }
    } catch (e) {
      debugPrint('$e');
    }
  }

  lastAdverRelease() {
    //print("key:${widget.key}@@@@@@@@@@@@@@@@@@@@@@@,lastPlayerRelease");
    try {
      if (SingleVideoController.adverController != null) {
        if (SingleVideoController.currentState != null &&
            SingleVideoController.currentState._state != this._state) {
          var currentState = SingleVideoController.currentState;
          currentState.adverRelease();
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
    lastAdverRelease();
    lastPlayerRelease();
    adverRelease();
    destoryVideoPlayer();
  }

  adverRelease() {
    //释放自己
    if (_state.adverController != null) {
      try {
        var releaseController = _state.adverController;
        if (SingleVideoController.adverController == _state.adverController) {
          SingleVideoController.adverController = null;
        }
        _state.adverController = null;
        adverDisposing = true;

        releaseController.removeListener(adverListener);
        releaseController.pause();
        Future.delayed(Duration(milliseconds: 500)).then((_) {
          print('@@@ adv release ref:${_state.ref}');
          return releaseController.dispose();
        }).then((_) {
          adverDisposing = false;
        }).catchError((_) {
          adverDisposing = false;
        });
      } catch (e) {
        adverDisposing = false;
        print('$e');
      }
    }
  }

  advToVideo() {
    adverRelease();
    if (_state.videoController != null) {
      if (_state.videoInitComplete) {
        _state.videoController.play();
      }
    }
    _state.status = VideoShowStatus.video;
    setState(() {});
  }

  int adLastSeconds = 0;
  adverListener() {
    if (mounted) {
      if (_state.adverController.value.hasError) {
        _state.adverController.removeListener(adverListener);
      }
      if (_state.adverController != null &&
          _state.adverController.value != null &&
          _state.adverController.value.initialized) {
        if (_state.adverController.value.duration.inMilliseconds > 0 &&
            _state.adverController.value.position.inMilliseconds > 0) {
          if (_state.adverController.value.isPlaying) {
            adLastSeconds = _state.adverController.value.duration.inSeconds -
                _state.adverController.value.position.inSeconds;
            setState(() {});
          } else {
            _state.adplayComplete = true;
            advToVideo();
          }
        }
      }
    }
  }

  allPlay() {
    if (adverDisposing || videoDisposing) return;
    clean();
    if (widget.adUrl.isEmpty) {
      _state.adplayComplete = true;
      _state.status = VideoShowStatus.video;
    } else {
      adPlay();
    }
    videoPlay();
  }

  adPlay() async {
    try {
      _state.adplayComplete = false;
      _state.videoInitComplete = false;

      print('@@@ advers clean success');

      File fileStream = await DefaultCacheManager().getSingleFile(widget.adUrl);
      SingleVideoController.adverController =
          _state.adverController = VideoPlayerController.file(fileStream);
      _state.status = VideoShowStatus.adver;

      setState(() {});
      _state.adverController.addListener(adverListener);
      _state.adverController.initialize().then((_) {
        print('@@@ advers init success');
        adLastSeconds = _state.adverController.value.duration.inSeconds;
        print('@@@ advers play');
        return _state.adverController.play();
      }).catchError((_) {
        //_state.status = VideoShowStatus.video;
        advToVideo();
      });
    } catch (e) {
      debugPrint('$e');
      advToVideo();
    }
  }

  videoPlay() async {
    try {
      //释放上个播放器
      print('@@@ video clean success');

      _state.videoController = SingleVideoController.videoController =
          VideoPlayerController.network(widget.videoUrl);
      //_state.status = VideoShowStatus.video;
      SingleVideoController.currentState = this;

      _state.pause = false;
      setState(() {});
      _state.videoController.addListener(videoListener);
      _state.videoController.initialize().then((_) {
        print('@@@ video init success');

        playerValid = true;
        _state.videoInitComplete = true;
        if (_state.adplayComplete) {
          print('@@@ video play');
          _state.videoController.play();
        }
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
          } else {
            allPlay();
          }
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
        allPlay();
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
            Positioned(
              bottom: MyTheme.sz(0),
              right: MyTheme.sz(0),
              child: _buildCtrlBarFullScreen(),
            ),
            adLastSeconds == 0
                ? Center(child: CircularProgressIndicator())
                : Positioned(
                    top: MyTheme.sz(10),
                    right: MyTheme.sz(10),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.all(Radius.circular(MyTheme.sz(3))),
                      child: Container(
                        padding: EdgeInsets.all(MyTheme.sz(5)),
                        color: Colors.black54,
                        child: Text(
                          "$adLastSeconds秒",
                          style: TextStyle(
                              fontSize: MyTheme.sz(12),
                              color: MyTheme.revFontColor),
                        ),
                      ),
                    ),
                  )
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
        if (!Platform.isIOS) {
          return CircularProgressIndicator();
        }
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
        value = _state.videoController.value.position.inMilliseconds /
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
        } else if (isPlaying()) {
          _state.pause = true;
          _state.videoController.pause();
        } else {
          allPlay();
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
      String curTime = TimeHelper.getTimeText(
          _state.videoController.value.position.inSeconds.toDouble());
      showTime = curTime + ' / ' + totalTime;
    }

    return Text(showTime, style: TextStyle(color: Colors.white));
  }

  Widget _buildCtrlBarProgess() {
    double pos = 0;
    double total = 0;
    if (isPlay()) {
      if (_state.videoController.value.duration.inSeconds.toDouble() > 1) {
        pos = _state.videoController.value.position.inSeconds.toDouble();
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
    if (_state.videoController != null)
      _state.videoController.removeListener(videoListener);
    if (_state.adverController != null)
      _state.adverController.removeListener(adverListener);

    SystemChrome.setEnabledSystemUIOverlays([]);
    if (!widget.fullscreen) {
      //将当视频置为全屏状态，否则还原的时候会出现调用已经dispose的controller的问题。
      fullscreenState = true;
      setState(() {});

      double currentBrightness = 0;
      Screen.brightness.then((_) {
        Screen.keepOn(true);
        currentBrightness = _;
        return Navigator.push(
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
        );
      }).then((_) {
        return SystemChrome.setEnabledSystemUIOverlays(const [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ]);
      }).then((_) {
        if (mounted) {
          if (_state.videoController != null)
            _state.videoController.addListener(videoListener);
          if (_state.adverController != null)
            _state.adverController.addListener(adverListener);

          //还原Single
          SingleVideoController.adverController = _state.adverController;
          SingleVideoController.videoController = _state.videoController;
          SingleVideoController.currentState = this;

          fullscreenState = false;
          setState(() {});
        }
      }).then((_) {
        Screen.keepOn(false);
        Screen.setBrightness(currentBrightness);
      }).catchError((_) {
        print('$_');
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

  Widget _buildDragView() {
    final RenderBox box = context.findRenderObject();
    if (box == null) return Container();
    final sz = box.size;
    double h = max(min(sz.width, sz.height) / 4, 100);
    String showInfo = "";
    IconData iconData = Icons.block;

    if (dragType == VideoDragType.position) {
      if (posSeconds > 0) {
        iconData = Icons.fast_forward;
        showInfo = '${posSeconds.toStringAsFixed(2)}';
      } else {
        iconData = Icons.fast_rewind;
        showInfo = '${posSeconds.toStringAsFixed(2)}';
      }
    } else if (dragType == VideoDragType.brightness) {
      if (posBrightness > 0.7) {
        iconData = Icons.brightness_high;
      } else if (posBrightness > 0.3) {
        iconData = Icons.brightness_medium;
      } else {
        iconData = Icons.brightness_low;
      }
      showInfo = '${(posBrightness * 100).toInt()}';
    } else if (dragType == VideoDragType.volume) {
      if (posVolume > 0.7) {
        iconData = Icons.volume_up;
      } else if (posVolume > 0.3) {
        iconData = Icons.volume_down;
      } else {
        iconData = Icons.volume_mute;
      }
      showInfo = '${(posVolume * 100).toInt()}';
    }
    return showInfo.isNotEmpty
        ? Center(
            child: Container(
              width: h,
              height: h,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(MyTheme.sz(10))),
                child: Container(
                  padding: EdgeInsets.all(MyTheme.sz(5)),
                  color: Colors.white54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        iconData,
                        size: h / 2,
                        color: Colors.black54,
                      ),
                      Text(showInfo,
                          style: TextStyle(
                              fontSize: MyTheme.sz(16),
                              color: Colors.black54,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ),
          )
        : Container();
  }

  Widget _buildVideo() {
    GestureDragStartCallback onVerticalDragStart;
    GestureDragEndCallback onVerticalDragEnd;
    GestureDragCancelCallback onVerticalDragCancel;
    GestureDragUpdateCallback onVerticalDragUpdate;
    GestureDragStartCallback onHorizontalDragStart;
    GestureDragEndCallback onHorizontalDragEnd;
    GestureDragCancelCallback onHorizontalDragCancel;
    GestureDragUpdateCallback onHorizontalDragUpdate;

    if (widget.fullscreen) {
      onVerticalDragStart = (DragStartDetails details) {
        if (isPlay()) {
          Size sz = MediaQuery.of(context).size;
          if (sz.height / 2 > details.globalPosition.dy) {
            dragType = VideoDragType.volume;
          } else {
            dragType = VideoDragType.brightness;
          }
        }
        print('onVerticalDragStart $details');
      };
      onVerticalDragEnd = (DragEndDetails details) {
        dragType = null;
        posBrightness = 0;
        posVolume = 0;
        print('onVerticalDragEnd $details');
      };
      onVerticalDragCancel = () {
        dragType = null;
        posBrightness = 0;
        posVolume = 0;
        print('onHorizontalDragCancel');
      };
      onVerticalDragUpdate = (DragUpdateDetails details) async {
        if (dragType == VideoDragType.brightness) {
          if (isPlay()) {
            try {
              Size sz = MediaQuery.of(context).size;
              var deltaBrightness = (-details.delta.dy / sz.height);
              double brightness = await Screen.brightness;
              posBrightness = brightness + deltaBrightness;
              if (posBrightness > 1) {
                posBrightness = 1;
              } else if (posBrightness < 0) {
                posBrightness = 0;
              }
              Screen.setBrightness(posBrightness);
              setState(() {});
            } catch (e) {}
          }
        } else if (dragType == VideoDragType.volume) {
          if (isPlay()) {
            try {
              Size sz = MediaQuery.of(context).size;
              var deltaVolume = (-details.delta.dy / sz.height);
              double volume = _state.videoController.value.volume;
              posVolume = volume + deltaVolume;
              if (posVolume > 1) {
                posVolume = 1;
              } else if (posVolume < 0) {
                posVolume = 0;
              }
              _state.videoController.setVolume(posVolume);
            } catch (e) {}
          }
        }
        print('onVerticalDragUpdate $details');
      };
      onHorizontalDragStart = (DragStartDetails details) {
        if (isPlay()) {
          dragType = VideoDragType.position;
          posSeconds = 0.0;
        }
        print('DragStartDetails $details');
      };
      onHorizontalDragEnd = (DragEndDetails details) {
        if (dragType == VideoDragType.position) {
          if (isPlay()) {
            _state.videoController.seekTo(Duration(
                milliseconds:
                    (_state.videoController.value.position.inMilliseconds +
                            posSeconds * 1000)
                        .toInt()));
          }
        }
        dragType = null;
        posSeconds = 0.0;
        print('DragStartDetails $details');
      };
      onHorizontalDragCancel = () {
        dragType = null;
        posSeconds = 0.0;
        print('onHorizontalDragCancel');
      };
      onHorizontalDragUpdate = (DragUpdateDetails details) {
        if (dragType == VideoDragType.position) {
          if (isPlay()) {
            double delta = details.delta.dx;
            delta /= 10;
            posSeconds += delta;

            setState(() {});
            print('pos $posSeconds');
          }
        }
        print('DragStartDetails $details');
      };
    }

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
      onVerticalDragStart: onVerticalDragStart,
      onVerticalDragEnd: onVerticalDragEnd,
      onVerticalDragCancel: onVerticalDragCancel,
      onVerticalDragUpdate: onVerticalDragUpdate,
      onHorizontalDragStart: onHorizontalDragStart,
      onHorizontalDragEnd: onHorizontalDragEnd,
      onHorizontalDragCancel: onHorizontalDragCancel,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      child: Container(
        color: Colors.black,
        child: Stack(
          children: <Widget>[
            VideoPlayer(_state.videoController),
            _buildVideoController(),
            _buildStatusView(),
            _buildDragView(),
          ],
        ),
      ),
    );
  }
}
