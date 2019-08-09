import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';

class VideoPerson extends StatefulWidget {
  @override
  State<VideoPerson> createState() => _VideoPersonState();
}

class _VideoPersonState extends State<VideoPerson> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back_ios),
                ),
                elevation: 0,
                expandedHeight: MyTheme.sz(160),
                floating: false,
                pinned: true,
                title: Text(
                  '主播合集',
                  style: TextStyle(color: MyTheme.fontDeepColor),
                ),
                flexibleSpace: FlexibleSpaceBar(
                  background: Container(
                    alignment: Alignment.bottomLeft,
                    padding: EdgeInsets.only(
                        left: MyTheme.sz(20), top: MyTheme.sz(50)),
                    child: Row(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              MyTheme.sz(100),
                            ),
                          ),
                          child: Container(
                            height: MyTheme.sz(80),
                            width: MyTheme.sz(80),
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: MyImage(
                                'http://image.huajiao.com/f00581188e4871ad91d3c1aae927241b-320_320.jpg',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MyTheme.sz(10),
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                "晴菀菀",
                                style: TextStyle(
                                  color: MyTheme.fontDeepColor,
                                  fontSize: MyTheme.sz(18),
                                ),
                              ),
                              Text(
                                "生于浙江乐清，小学时随父母迁至杭州，毕业于中央戏剧学院导演系本科。",
                                style: TextStyle(
                                  color: MyTheme.fontColor,
                                  fontSize: MyTheme.sz(14),
                                ),
                              ),
                              Text(
                                "相关视频（21）",
                                style: TextStyle(
                                  color: MyTheme.fontDeepColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyTheme.sz(14),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: Container(
            color: MyTheme.bgColor,
            child: ListView(
              children: <Widget>[
                Divider(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
                _VideoItem(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _VideoItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/video/play');
      },
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.white,
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
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: MyTheme.sz(5),
          ),
        ],
      ),
    );
  }
}
