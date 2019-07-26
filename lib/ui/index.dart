import 'package:cicitv/global/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  TabController _tabController;
  int _selectIndex = 0;

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
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: TabBar(
              labelPadding: EdgeInsets.symmetric(horizontal: MyTheme.sz(10)),
              indicatorSize: TabBarIndicatorSize.label,
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyle(
                  fontSize: MyTheme.sz(24), fontWeight: FontWeight.w600),
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
            Center(child: Text('推荐')),
            Center(child: Text('影星')),
            Center(child: Text('韩日')),
            Center(child: Text('欧美')),
            Center(child: Text('武侠'))
          ]),
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedItemColor: MyTheme.fontColor,
              currentIndex: _selectIndex,
              onTap: (int index) {
                setState(() {
                  _selectIndex = index;
                });
              },
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.video_library), title: Text('视频')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.group_work), title: Text('圈子')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.ondemand_video), title: Text('直播')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('我的')),
              ]),
        ),
        theme: ThemeData(
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            primaryIconTheme: IconThemeData(
              color: MyTheme.colorDark
            ),
            primarySwatch: MyTheme.color,
            primaryColor: MyTheme.color));
  }
}