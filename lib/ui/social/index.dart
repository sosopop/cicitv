import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';

class SocialIndex extends StatefulWidget {
  @override
  State<SocialIndex> createState() => new _IndexState();
}

class _IndexState extends State<SocialIndex> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            title: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: MyTheme.sz(10)),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyle(
                  fontSize: MyTheme.sz(22), fontWeight: FontWeight.w600),
              labelColor: MyTheme.color,
              unselectedLabelColor: MyTheme.fontDeepColor,
              unselectedLabelStyle: TextStyle(fontSize: MyTheme.sz(16)),
              tabs: <Widget>[
                Tab(text: "图片"),
                Tab(text: "视频"),
                Tab(text: "短文"),
              ],
            ),
            elevation: 0,
            backgroundColor: MyTheme.bgColor,
            actions: <Widget>[
              IconButton(icon: Icon( Icons.search), onPressed:(){

              })
            ],
          ),
          body: TabBarView(
            controller: _tabController, children: <Widget>[
            Center(child: Text('图片')),
            Center(child: Text('视频')),
            Center(child: Text('短文'))
          ])
        );
  }
}