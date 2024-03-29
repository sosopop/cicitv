import 'package:cicitv/common/mytoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/video/index.dart';
import 'package:cicitv/ui/user/index.dart';
import 'package:cicitv/ui/live/index.dart';
import 'package:cicitv/ui/social/index.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Index extends StatefulWidget {
  @override
  State<Index> createState() => new _IndexState();
}

class _IndexState extends State<Index> with TickerProviderStateMixin {
  TabController _tabController;
  int _selectPage = 0;
  List<StatefulWidget> _pageList;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
    _pageList = <StatefulWidget>[
      new VideoIndex(),
      new SocialIndex(),
      new LiveIndex(),
      new UserIndex()
    ];
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  bool exit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (BuildContext context) {
        return WillPopScope(
            onWillPop: () async {
              if (exit) return true;
              MyToast('再次后退离开');
              exit = true;
              return Future.delayed(Duration(seconds: 2), () {
                exit = false;
                return false;
              });
            },
            child: _pageList[_selectPage]);
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: MyTheme.fontColor,
        currentIndex: _selectPage,
        onTap: (int index) {
          setState(() {
            _selectPage = index;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text('视频'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_work), title: Text('圈子')),
          BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video), title: Text('直播')),
          BottomNavigationBarItem(
            icon: Stack(children: <Widget>[
              Container(
                width: 30,
                child: Icon(Icons.person),
              ),
              Positioned(
                // draw a red marble
                top: 0.0,
                right: 0.0,
                child: Icon(Icons.brightness_1,
                    size: 8.0, color: Colors.redAccent),
              )
            ]),
            title: Text('我的'),
          ),
        ],
      ),
    );
  }
}
