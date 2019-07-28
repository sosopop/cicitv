import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:chewie/chewie.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';

class ViewVideoPlayer extends StatefulWidget {
  final String url;
  final bool autoPlay;
  ViewVideoPlayer(this.url, this.autoPlay);
  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState();
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer> {
  _ViewVideoPlayerState();

  IjkMediaController controller;

  @override
  void initState() {
    super.initState();
    if (controller == null) {
      controller = IjkMediaController(autoRotate: false);
    }
    controller.setNetworkDataSource(widget.url, autoPlay: widget.autoPlay);
  }

  @override
  void dispose() {
    if (controller != null) {
      //controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return IjkPlayer(
      mediaController: controller,
      controllerWidgetBuilder: (mediaController) {
        return DefaultIJKControllerWidget(
          controller: mediaController,
          doubleTapPlay: true,
          playWillPauseOther: false,
          verticalGesture: false,
          horizontalGesture: false,
          fullScreenType: FullScreenType.rotateScreen,
          fullscreenControllerWidgetBuilder: (IjkMediaController controller) {
            return WillPopScope(
              onWillPop: () async {
                await IjkManager.setPortrait();
                Timer(Duration(seconds: 1), () {
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown
                  ]);
                });
                return true;
              },
              child: Stack(
                children: <Widget>[
                  DefaultIJKControllerWidget(
                    controller: controller,
                    fullScreenType: FullScreenType.rotateScreen,
                    doubleTapPlay: true,
                    currentFullScreenState: true,
                    showFullScreenButton: false,
                  ),
                  Container(
                    height: 44.0,
                    width: 44.0,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                        IjkManager.setPortrait();
                        Timer(Duration(seconds: 1), () {
                          SystemChrome.setPreferredOrientations([
                            DeviceOrientation.portraitUp,
                            DeviceOrientation.portraitDown
                          ]);
                        });
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      statusWidgetBuilder: (
        BuildContext context,
        IjkMediaController controller,
        IjkStatus status,
      ) {
        // you can custom your self status widget
        return IjkStatusWidget.buildStatusWidget(context, controller, status);
      },
    );
  }
}
