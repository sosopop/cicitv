import 'dart:math';
import 'package:flutter/cupertino.dart';
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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyPage extends StatefulWidget {
  final String url;
  MyPage(this.url);
  @override
  State<MyPage> createState() {
    return _MyPageState(url);
  }
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  String url;
  _MyPageState(this.url);
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @protected
  bool get wantKeepAlive => true;

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
    super.build(context);

    if (url == "video") {
      return Center(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scroll) {
            return false;
          },
          child: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: true,
            onRefresh: () async {
              return Future<void>.delayed(Duration(seconds: 1)).then((_) {
                _refreshController.resetNoData();
                _refreshController.refreshCompleted();
              });
            },
            onLoading: () async {
              return Future<void>.delayed(Duration(seconds: 1)).then((_) {
                //_refreshController.loadComplete();
                _refreshController.loadNoData();
              });
            },
            header: MaterialClassicHeader(),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                Widget body;
                if (mode == LoadStatus.idle) {
                  body = Text("上拉加载更多");
                } else if (mode == LoadStatus.loading) {
                  body = CircularProgressIndicator();
                } else if (mode == LoadStatus.failed) {
                  body = Text("加载失败,点击重试");
                } else {
                  body = Text("这是我的底线");
                }
                return Container(
                  height: 55.0,
                  child: Center(child: body),
                );
              },
            ),
            child: ListView(
              padding: EdgeInsets.only(top: MyTheme.sz(0)),
              children: <Widget>[
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://img1.doubanio.com/view/photo/m/public/p2557578729.webp",
                  title: "姚芊羽李建上演新农村创业",
                  videoUrl:
                      'https://mp4.vjshi.com/2019-07-30/7c2674b6f15c206a2b3155072d477255.mp4',
                ),
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://img3.doubanio.com/view/photo/l/public/p2560501335.webp",
                  title: "邓伦马思纯都市情感甜怼恋",
                  videoUrl:
                      'https://mp4.vjshi.com/2017-08-09/1b2c78c7296655d1c47faa6c765555c7.mp4',
                ),
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://liangcang-material.alicdn.com/prod/upload/91df128bd3e04e87b63847b65e37207a.jpg",
                  title: "行走画报！威神V抱大葱帅炸",
                  videoUrl:
                      'http://vt1.doubanio.com/201907290459/2791672f6b2f62f675131ad5297bcec6/view/movie/M/402420330.mp4',
                ),
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://img3.doubanio.com/view/photo/l/public/p2548088320.webp",
                  title: "姜昆朱时茂追忆旧时光",
                  videoUrl:
                      'https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_30mb.mp4',
                ),
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://r1.ykimg.com/050C0000589C166967BC3C4AA003DCB8",
                  title: "国外m3u8测试视频",
                  videoUrl:
                      'https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8',
                ),
                ViewVideoShowItem(
                  adUrl:
                      "https://mp4.vjshi.com/2018-03-25/97eeb9c48ca02676a369a445606ed850.mp4",
                  picUrl:
                      "https://r1.ykimg.com/050C00005CC03170ADA7B2A3F20D7F40",
                  title: "国内m3u8测试视频",
                  videoUrl:
                      'http://hls.videocc.net/ce0812b122/c/ce0812b1223bb292333a4ce6e092a949_3.m3u8',
                ),
              ],
            ),
          ),
        ),
      );
    } else if (url == "star") {
      return Center(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              _refreshController.resetNoData();
              _refreshController.refreshCompleted();
            });
          },
          onLoading: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              //_refreshController.loadComplete();
              _refreshController.loadNoData();
            });
          },
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载更多");
              } else if (mode == LoadStatus.loading) {
                body = CircularProgressIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败,点击重试");
              } else {
                body = Text("这是我的底线");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          child: StaggeredGridView.countBuilder(
            padding: EdgeInsets.all(MyTheme.sz(5.0)),
            crossAxisCount: 4,
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index) => list[index],
            staggeredTileBuilder: (int index) => new StaggeredTile.fit(2),
            mainAxisSpacing: MyTheme.sz(5.0),
            crossAxisSpacing: MyTheme.sz(5.0),
          ),
        ),
      );
    } else {
      return Center(
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              _refreshController.resetNoData();
              _refreshController.refreshCompleted();
            });
          },
          onLoading: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              //_refreshController.loadComplete();
              _refreshController.loadNoData();
            });
          },
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载更多");
              } else if (mode == LoadStatus.loading) {
                body = CircularProgressIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败,点击重试");
              } else {
                body = Text("这是我的底线");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          child: ListView(
            padding: EdgeInsets.only(top: MyTheme.sz(0)),
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
            ],
          ),
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
