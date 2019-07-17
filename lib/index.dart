import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollViewController =  ScrollController();
    _tabController =  TabController(vsync: this, length: 3);// 和下面的 TabBar.tabs 数量对应
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar:  AppBar(
          elevation: 0,
          leading:  IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
            }
          ),
          backgroundColor: Colors.white,
          title:  TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 10),
            indicatorSize: TabBarIndicatorSize.label,
            isScrollable: true,
            controller: _tabController,
            tabs: <Widget>[
               Tab(text: "精选"),
               Tab(text: "推荐"),
               Tab(text: "影星"),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.access_time),
              onPressed: (){

              }
            )
          ],
        ),
        body:  TabBarView(controller: _tabController, children: <Widget>[
          Center(child:Text('首页')),
          Center(child:Text('推荐')),
          Center(child:Text('精选')),
        ]),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.black54,
          currentIndex: _selectIndex,
          onTap: (int index) {
            setState(() {
              _selectIndex = index;
            });
          },
          items: <BottomNavigationBarItem> [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('首页')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group_work),
              title: Text('圈子')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              title: Text('充值')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('我的')
            ),
          ]
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.orange,
        brightness: Brightness.dark, 
      )
    );
  }
}