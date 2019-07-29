import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
import 'dart:async';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class ViewVideoPlayer extends StatefulWidget {
  final String url;
  final bool autoPlay;
  ViewVideoPlayer({
    this.url,
    this.autoPlay,
  });
  @override
  State<ViewVideoPlayer> createState() => _ViewVideoPlayerState();
}

class _ViewVideoPlayerState extends State<ViewVideoPlayer>
    with WidgetsBindingObserver {
  _ViewVideoPlayerState();

  // @override
  // Future<Null> didChangeAppLifecycleState(AppLifecycleState state) async {
  //   switch (state) {
  //     case AppLifecycleState.inactive:
  //     case AppLifecycleState.paused:
  //     case AppLifecycleState.suspending:
  //       break;
  //     case AppLifecycleState.resumed:
  //       break;
  //   }
  // }

  VideoPlayerController videoPlayerController;
  ChewieController chewieController;

  @override
  void initState() {
    super.initState();
    //WidgetsBinding.instance.addObserver(this);
    videoPlayerController = VideoPlayerController.network(widget.url);
    chewieController = ChewieController(
      overlay: Text(
        "sdlkfj;ajf;a@@@@@@@@@@@@@@@@@@@@@@@",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
      customControls: ClipOval(
        child: Container(
          height: 70,
          width: 70,
          padding: EdgeInsets.all(MyTheme.sz(3)),
          color: Colors.grey,
          child: Icon(
            Icons.person,
            color: Colors.white,
            size: MyTheme.sz(60),
          ),
        ),
      ),
      videoPlayerController: videoPlayerController,
      aspectRatio: 16 / 9,
      autoPlay: true,
      deviceOrientationsAfterFullScreen: [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
  }

  @override
  void dispose() {
    //WidgetsBinding.instance.removeObserver(this);
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(
      controller: chewieController,
    );
  }
}
