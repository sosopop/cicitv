import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_banner_swiper.dart';
import 'package:cicitv/ui/components/views/view_two_col_panel.dart';
import 'package:cicitv/ui/components/views/view_video_show_item.dart';
import 'package:cicitv/ui/components/views/view_adv_item.dart';

class MyPage extends StatefulWidget {
  final String url;
  MyPage(this.url);
  @override
  State<MyPage> createState(){
    List<Widget> myList;
    if( url == "video") {
      myList = <Widget>[
        ViewVideoShowItem(
          picUrl:"https://ykimg.alicdn.com/develop/image/2019-03-13/013cc9422f4c032737722edf1e6180f7.jpg",
          title:"姚芊羽李建上演新农村创业"
        ),
        ViewVideoShowItem(
          picUrl:"https://liangcang-material.alicdn.com/prod/upload/9a0cd5d5b55746f5954211db3467d717.jpg",
          title:"邓伦马思纯都市情感甜怼恋"
        ),
        ViewVideoShowItem(
          picUrl:"https://liangcang-material.alicdn.com/prod/upload/91df128bd3e04e87b63847b65e37207a.jpg",
          title:"行走画报！威神V抱大葱帅炸"
        ),
        ViewVideoShowItem(
          picUrl:"https://liangcang-material.alicdn.com/prod/upload/99d553b433b44a9a9cca686d97943d94.jpg",
          title:"姜昆朱时茂追忆旧时光"
        ),
        Container(
          color: MyTheme.holderColor,
          padding: EdgeInsets.all(MyTheme.sz(20)),
          child: Center(child: Text('已经到达底线'))
        ),
      ];
    } else {
      myList = <Widget>[
        ViewBannerSwiper(),
        ViewTwoColPanel(),
        ViewAdvItem(),
        ViewTwoColPanel(),
        ViewAdvItem(),
        ViewTwoColPanel(),
        ViewAdvItem(),
        ViewTwoColPanel(),
        Container(
          color: MyTheme.holderColor,
          padding: EdgeInsets.all(MyTheme.sz(20)),
          child: Center(child: Text('已经到达底线'))
        ),
      ];
    }
    return _MyPageState( myList );
  } 
}

class _MyPageState extends State<MyPage> {
  List<Widget> _myList;
  _MyPageState(List<Widget> myList ){
    _myList = myList;
  }
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
      children: _myList
    ));
  }
}