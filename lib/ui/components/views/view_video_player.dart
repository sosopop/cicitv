import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
import 'dart:async';
import 'package:flutter/services.dart';
//import 'package:chewie/chewie.dart';
import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:flutter/foundation.dart';

class ViewVideoPlayer extends StatefulWidget {
  final String url;
  final bool autoPlay;
  ViewVideoPlayer(this.url, this.autoPlay);
  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState();

  static void reset() {
    controller.reset();
  }
}

IjkMediaController controller = IjkMediaController(autoRotate: false);

class _ViewVideoPlayerState extends State<ViewVideoPlayer>
    with WidgetsBindingObserver {
  _ViewVideoPlayerState();

  @override
  Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.suspending:
        controller.pause();
        break;
      case AppLifecycleState.resumed:
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    controller.setNetworkDataSource(widget.url, autoPlay: widget.autoPlay);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
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
            return DefaultIJKControllerWidget(
              backButton: true,
              controller: controller,
              fullScreenType: FullScreenType.rotateScreen,
              doubleTapPlay: true,
              currentFullScreenState: true,
              showFullScreenButton: true,
            );
          },
        );
      },
      statusWidgetBuilder: (
        BuildContext context,
        IjkMediaController controller,
        IjkStatus status,
      ) {
        if (status == IjkStatus.preparing) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (status == IjkStatus.prepared) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        // you can custom your self status widget
        return IjkStatusWidget.buildStatusWidget(context, controller, status);
      },
    );
  }
}
