import 'package:cached_network_image/cached_network_image.dart';
import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/mytoast.dart';
import 'package:cicitv/ui/components/views/view_adv_item.dart';
import 'package:flutter/material.dart';
import 'package:cicitv/ui/components/views/view_video_player.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  bool favorite = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SlidingUpPanel(
          maxHeight: MediaQuery.of(context).size.height / 3 * 2,
          minHeight: MyTheme.sz(60),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          panel: _VideoComment(),
          body: Container(
            child: Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Stack(
                    children: <Widget>[
                      isBuy
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
                                          borderRadius: BorderRadius.circular(
                                              MyTheme.sz(30))),
                                      padding: EdgeInsets.all(MyTheme.sz(8)),
                                      onPressed: () async {
                                        setState(() {
                                          isBuy = true;
                                        });
                                        MyToast('购买成功');
                                      },
                                      color: MyTheme.color,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      ViewAdvItem(),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MyTheme.sz(15)),
                                  child: Text(
                                    '破风',
                                    style: TextStyle(
                                      fontSize: MyTheme.sz(18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: MyTheme.sz(15)),
                                  child: Text(
                                    '剧情 / 动作 / 5.3亿播放量',
                                    style: TextStyle(
                                      fontSize: MyTheme.sz(12),
                                      color: MyTheme.fontColor,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                favorite = !favorite;
                              });
                            },
                            icon: favorite
                                ? Icon(
                                    Icons.favorite,
                                    color: MyTheme.color,
                                  )
                                : Icon(Icons.favorite_border),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        indent: MyTheme.sz(15),
                        endIndent: MyTheme.sz(15),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: MyTheme.sz(15)),
                        child: Text(
                          '简介',
                          style: TextStyle(
                            fontSize: MyTheme.sz(14),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: MyTheme.sz(15)),
                        child: Text(
                          '个性格迥异的女孩相识于大学，志趣相投，结为闺蜜毕业后，她们留在北京，立志奋斗。然而，年少激进的她们时常碰壁，考研失败个性格迥异的女孩相识于大学，志趣相投，撒旦和印度阿',
                          style: TextStyle(
                            fontSize: MyTheme.sz(14),
                            color: MyTheme.fontColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        indent: MyTheme.sz(15),
                        endIndent: MyTheme.sz(15),
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: MyTheme.sz(15)),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                '推荐视频',
                                style: TextStyle(
                                  fontSize: MyTheme.sz(18),
                                ),
                              ),
                            ),
                            GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Text(
                                    '更多',
                                    style: TextStyle(
                                      color: MyTheme.fontColor,
                                    ),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: MyTheme.fontColor,
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      _VideoItem(),
                      _VideoItem(),
                      _VideoItem(),
                      _VideoItem(),
                      _VideoItem(),
                    ],
                  ),
                ),
                SizedBox(height: MyTheme.sz(80)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoComment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        SizedBox(
          height: MyTheme.sz(10.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.all(Radius.circular(12.0))),
            ),
          ],
        ),
        SizedBox(
          height: MyTheme.sz(10.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: MyTheme.sz(15.0),
            ),
            Text.rich(
              TextSpan(
                text: '评论',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: MyTheme.sz(16),
                ),
                children: [
                  TextSpan(
                    text: "（10245）",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: MyTheme.sz(16),
                      color: MyTheme.fontColor,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(
          height: MyTheme.sz(10.0),
        ),
        Divider(
          height: 1,
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: MyTheme.sz(15),
              vertical: MyTheme.sz(10),
            ),
            children: <Widget>[
              _commentItem(),
              _commentItem(),
              _commentItem(),
              _commentItem(),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        Container(
          height: MyTheme.sz(50),
          padding: EdgeInsets.symmetric(
            horizontal: MyTheme.sz(15),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '输入评论的内容',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.send,
                  color: MyTheme.color,
                ),
                onPressed: () {},
              )
            ],
          ),
        ),
        Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom))
      ],
    );
  }

  Widget _commentItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            ClipOval(
              child: Container(
                height: MyTheme.sz(30),
                width: MyTheme.sz(30),
                color: Colors.grey,
                child: MyImage(
                    'https://r1.ykimg.com/0130391F455077AC278C8E04B12F4854133D8D-CFB0-F265-F406-A9C7159D9E27'),
              ),
            ),
            SizedBox(
              width: MyTheme.sz(10),
            ),
            Text(
              "幸福时光",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
        SizedBox(
          height: MyTheme.sz(10),
        ),
        Text(
          "休说苍天不由人，我命由我不由天。新的故事，改编的很不错啊，就是有点短。友情提醒：观影记得带纸巾",
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(color: MyTheme.fontColor),
        ),
        Divider(),
      ],
    );
  }
}

class _VideoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: MyTheme.sz(15),
            vertical: MyTheme.sz(10),
          ),
          height: MyTheme.sz(100),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: MyImage(
                  'https://liangcang-material.alicdn.com/prod/upload/d1c77fbca6c745f19f40a8bbf8647c8f.jpg',
                ),
              ),
              SizedBox(
                width: 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('十二传说⚡人鱼事件'),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    '情侣山洞发现人鱼干尸',
                    style: TextStyle(
                      color: MyTheme.fontColor,
                      fontSize: 12,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        Divider(
          height: MyTheme.sz(5),
        ),
      ],
    );
  }
}
