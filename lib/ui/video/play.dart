import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/mytoast.dart';
import 'package:flutter/material.dart';
import 'package:cicitv/ui/components/views/view_video_player.dart';

class VideoPlay extends StatefulWidget {
  @override
  State<VideoPlay> createState() => _VideoPlayState();
}

class _VideoPlayState extends State<VideoPlay> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isBuy = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: isBuy
                    ? ViewVideoPlayer(
                        adUrl:
                            'https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4',
                        videoUrl:
                            'https://mp4.vjshi.com/2019-07-30/7c2674b6f15c206a2b3155072d477255.mp4',
                        coverBuilder: (BuildContext context) {
                          return Container(
                            alignment: Alignment.center,
                            color: Colors.black,
                          );
                        },
                        autoPlay: true,
                      )
                    : Container(
                        color: Colors.black,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              '播放此视频需要100钻石',
                              style: TextStyle(
                                  fontSize: MyTheme.sz(14),
                                  color: Colors.white),
                            ),
                            SizedBox(
                              height: MyTheme.sz(5),
                            ),
                            SizedBox(
                              width: MyTheme.sz(100),
                              child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(MyTheme.sz(30))),
                                padding: EdgeInsets.all(MyTheme.sz(8)),
                                onPressed: () async {
                                  await showLoadingDialog<void>(
                                    context: context,
                                    callback: (context) async {
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      setState(() {
                                        isBuy = true;
                                      });
                                    },
                                  );
                                  MyToast('购买成功');
                                },
                                color: MyTheme.color,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '立即购买',
                                      style: TextStyle(
                                        fontSize: MyTheme.sz(14),
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
