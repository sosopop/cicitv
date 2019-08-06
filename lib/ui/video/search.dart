import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/page.dart';

class VideoSearch extends StatefulWidget {
  @override
  State<VideoSearch> createState() => new _VideoSearchState();
}

class _VideoSearchState extends State<VideoSearch>
    with TickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
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
        title: Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          child: Container(),
        ),
        elevation: 0,
        backgroundColor: MyTheme.bgColor,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      body: Container(),
    );
  }
}
