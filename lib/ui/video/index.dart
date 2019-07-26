import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/page.dart';

class VideoIndex extends StatefulWidget {
  @override
  State<VideoIndex> createState() => new _IndexState();
}

class _IndexState extends State<VideoIndex> with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(vsync: this, length: 5); // 和下面的 TabBar.tabs 数量对应
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
                Tab(text: "推荐"),
                Tab(text: "影星"),
                Tab(text: "韩日"),
                Tab(text: "欧美"),
                Tab(text: "武侠")
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
            Center(child: MyPage('http://www.baidu.com')),
            Center(child: Text('影星')),
            Center(child: Text('韩日')),
            Center(child: Text('欧美')),
            Center(child: Text('武侠'))
          ])
        );
  }
}