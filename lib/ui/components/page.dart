import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_banner_swiper.dart';
import 'package:cicitv/ui/components/views/view_two_col_panel.dart';
import 'package:cicitv/ui/components/views/view_video_show_panel.dart';

class MyPage extends StatefulWidget {
  MyPage(String url) {

  }
  @override
  State<MyPage> createState() => new _MyPageState();
}

class _MyPageState extends State<MyPage> {
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
    return Center(child: ListView(
      padding: EdgeInsets.only(top: MyTheme.sz(10)),
      children: <Widget>[
        ViewBannerSwiper(),
        ViewTwoColPanel(),
        ViewVideoShowPanel(),
        Container(
          color: MyTheme.holderColor,
          padding: EdgeInsets.all(MyTheme.sz(20)),
          child: Center(child: Text('已经到达底线'))
        ),
      ]
    ));
  }
}