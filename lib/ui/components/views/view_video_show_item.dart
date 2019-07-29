import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
//import 'package:chewie/chewie.dart';
//import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:cicitv/ui/components/views/view_video_player.dart';
import 'package:flutter/foundation.dart';

class ViewVideoShowItem extends StatefulWidget {
  final String picUrl;
  final String videoUrl;
  final String title;
  final String targetUrl;
  final int playCount;
  ViewVideoShowItem(
      {this.picUrl, this.videoUrl, this.title, this.targetUrl, this.playCount});
  @override
  State<ViewVideoShowItem> createState() => _ViewVideoShowItemState();
}

class _ViewVideoShowItemState extends State<ViewVideoShowItem> {
  _ViewVideoShowItemState();

  bool _player = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    debugPrint("dispose");
    super.dispose();
  }

  // void videoCheck(Timer timer) {
  //   RenderObject obj = context.findRenderObject();
  //   RenderAbstractViewport viewport = RenderAbstractViewport.of(obj);
  //   if (viewport != null) {
  //     double vpHeight = viewport.paintBounds.height;
  //     ScrollableState scrollableState = Scrollable.of(context);
  //     ScrollPosition scrollPosition = scrollableState.position;
  //     final Size size = obj?.semanticBounds?.size;
  //     RevealedOffset vpOffset = viewport.getOffsetToReveal(obj, 0.0);
  //     final double deltaTop = vpOffset.offset - scrollPosition.pixels;
  //     final double deltaBottom = deltaTop + size.height;

  //     bool isInViewport = false;

  //     isInViewport = (deltaTop >= 0.0 && deltaTop < vpHeight);
  //     if (!isInViewport) {
  //       isInViewport = (deltaBottom > 0.0 && deltaBottom < vpHeight);
  //     }

  //     if (!isInViewport) {
  //       timer.cancel();
  //       resetViewState();
  //     }

  //     debugPrint(
  //         'scrollPosition.pixels:${scrollPosition.pixels}, deltaTop:$deltaTop, offset: $vpOffset -- VP?: $isInViewport');
  //   }
  // }

  void resetViewState() {
    _player = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            _player = true;
            setState(() {});
          },
          child: _player
              ? AspectRatio(
                  child: ViewVideoPlayer(
                    url: widget.videoUrl,
                    autoPlay: true,
                  ),
                  aspectRatio: 16 / 9,
                )
              : Stack(
                  children: <Widget>[
                    AspectRatio(
                      child: MyImage(widget.picUrl),
                      aspectRatio: 16 / 9,
                    ),
                    Positioned(
                      top: 0,
                      right: MyTheme.sz(
                          MediaQuery.of(context).size.width * 3 / 100),
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(MyTheme.sz(3))),
                        child: Container(
                          padding: EdgeInsets.all(MyTheme.sz(3)),
                          color: MyTheme.tagColor,
                          child: Text(
                            "100钻石",
                            style: TextStyle(
                                fontSize: MyTheme.sz(10),
                                color: MyTheme.revFontColor),
                          ),
                        ),
                      ),
                    ),
                    AspectRatio(
                      child: Center(
                        child: ClipOval(
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.play_arrow,
                              size: MyTheme.sz(50),
                              color: MyTheme.transWhiteIcon,
                            ),
                            color: MyTheme.transBlackIcon,
                          ),
                        ),
                      ),
                      aspectRatio: 16 / 9,
                    )
                  ],
                ),
        ),
        FlatButton(
          onPressed: () {},
          padding: EdgeInsets.all(MyTheme.sz(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: MyTheme.sz(16)),
                  maxLines: 1,
                ),
              ),
              Icon(Icons.visibility, color: MyTheme.fontColor),
              SizedBox(
                width: MyTheme.sz(5),
              ),
              Text(
                "1001",
                style: TextStyle(
                    color: MyTheme.fontColor, fontSize: MyTheme.sz(12)),
              ),
              SizedBox(
                width: MyTheme.sz(7),
              ),
              Icon(Icons.chat_bubble_outline, color: MyTheme.fontColor),
              SizedBox(
                width: MyTheme.sz(5),
              ),
              Text(
                "97",
                style: TextStyle(
                    color: MyTheme.fontColor, fontSize: MyTheme.sz(12)),
              )
            ],
          ),
        )
      ],
    );
  }
}
