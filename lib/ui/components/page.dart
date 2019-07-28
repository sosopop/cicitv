import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_banner_swiper.dart';
import 'package:cicitv/ui/components/views/view_two_col_panel.dart';
import 'package:cicitv/ui/components/views/view_video_show_item.dart';
import 'package:cicitv/ui/components/views/view_adv_item.dart';
import 'package:cicitv/ui/components/views/view_hor_scroll_panel.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cicitv/ui/components/views/view_star_show_flow_item.dart';

class MyPage extends StatefulWidget {
  final String url;
  MyPage(this.url);
  @override
  State<MyPage> createState() {
    return _MyPageState(url);
  }
}

class _MyPageState extends State<MyPage> {
  String url;
  _MyPageState(this.url);
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
    if (url == "video") {
      return Center(
        child: ListView(
          padding: EdgeInsets.only(top: MyTheme.sz(10)),
          children: <Widget>[
            ViewVideoShowItem(
                picUrl:
                    "https://ykimg.alicdn.com/develop/image/2019-03-13/013cc9422f4c032737722edf1e6180f7.jpg",
                title: "姚芊羽李建上演新农村创业"),
            ViewVideoShowItem(
                picUrl:
                    "https://liangcang-material.alicdn.com/prod/upload/9a0cd5d5b55746f5954211db3467d717.jpg",
                title: "邓伦马思纯都市情感甜怼恋"),
            ViewVideoShowItem(
                picUrl:
                    "https://liangcang-material.alicdn.com/prod/upload/91df128bd3e04e87b63847b65e37207a.jpg",
                title: "行走画报！威神V抱大葱帅炸"),
            ViewVideoShowItem(
                picUrl:
                    "https://liangcang-material.alicdn.com/prod/upload/99d553b433b44a9a9cca686d97943d94.jpg",
                title: "姜昆朱时茂追忆旧时光"),
            Container(
                color: MyTheme.holderColor,
                padding: EdgeInsets.all(MyTheme.sz(20)),
                child: Center(child: Text('已经到达底线'))),
          ],
        ),
      );
    } else if (url == "star") {
      return Center(
        child: StaggeredGridView.countBuilder(
          padding: EdgeInsets.all(MyTheme.sz(5.0)),
          crossAxisCount: 4,
          itemCount: list.length,
          itemBuilder: (BuildContext context, int index) => list[index],
          staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
          mainAxisSpacing: MyTheme.sz(5.0),
          crossAxisSpacing: MyTheme.sz(5.0),
        ),
      );
    } else {
      return Center(
        child: ListView(
          padding: EdgeInsets.only(top: MyTheme.sz(10)),
          children: <Widget>[
            ViewBannerSwiper(),
            ViewTwoColPanel(),
            ViewHorScrollPanel(),
            ViewAdvItem(),
            ViewTwoColPanel(),
            ViewAdvItem(),
            ViewTwoColPanel(),
            ViewAdvItem(),
            ViewTwoColPanel(),
            Container(
                color: MyTheme.holderColor,
                padding: EdgeInsets.all(MyTheme.sz(20)),
                child: Center(child: Text('已经到达底线'))),
          ],
        ),
      );
    }
  }
}

List<Widget> list = [
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/f00581188e4871ad91d3c1aae927241b-320_320.jpg",
    title: "💃暴走的呐暴走的呐暴走的呐呐💫",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/92ababd9c29b660949ebc5a635cd7a4a-320_320.jpg",
    title: "晴菀菀🌈",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/683a97eaa1aef27e993bb809fe8425bb-320_320.jpg",
    title: "🌸ゅ≈心儿≈ゅ",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/99250e2dd21c8d473a5e8048fd644655-320_320.jpg",
    title: "🎀美伢子🎀",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/ece5a1a545ef3b0d8ec7dd5610e50262-320_320.jpg",
    title: "🍑淘气的小桃子",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/1c1f1141084ebcc5beff27fcee4be179-320_320.jpg",
    title: "木木哒🎉新人求罩",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/4b87d57da8c6e647491ff3e784cc8134-320_320.jpg",
    title: "女神@小羽YU",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/00695e47964922c81b5fa3c21bea4cce-320_320.jpg",
    title: "💃暴走的呐暴走的呐暴走的呐呐💫",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/e31281c5027c1220a319d028c6ff6266-320_320.jpg",
    title: "晴菀菀🌈",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/72ef4c6f63d51a288cc013730480a4f1-320_320.jpg",
    title: "🌸ゅ≈心儿≈ゅ",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/46b5c7602b5c9a8fef63c34a7d5ea697-320_320.jpg",
    title: "🎀美伢子🎀",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/785a65b7dcc7281a5a722eeca00d98b4-320_320.jpg",
    title: "🍑淘气的小桃子",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/8b6093bc1bfe859dafa31241ef64aad3-320_320.jpg",
    title: "🍀ice 小冰🍀",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
  ViewStarShowFlowItem(
    picUrl:
        "http://image.huajiao.com/02963b50837f506591bb13adc92992c1-320_320.jpg",
    title: "今夜有约吗",
    ratio: 1 / (1 + Random().nextDouble()),
  ),
];
