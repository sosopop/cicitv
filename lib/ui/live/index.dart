import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/page.dart';
import 'package:cicitv/ui/components/views/view_two_col_item.dart';

class LiveIndex extends StatefulWidget {
  @override
  State<LiveIndex> createState() => new _IndexState();
}

class _IndexState extends State<LiveIndex> with TickerProviderStateMixin {
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
    return GridView.count(
          //水平子Widget之间间距
          crossAxisSpacing: 10.0,
          //垂直子Widget之间间距
          mainAxisSpacing: 30.0,
          //GridView内边距
          padding: EdgeInsets.all(10.0),
          //一行的Widget数量
          crossAxisCount: 2,
          //子Widget宽高比例
          childAspectRatio: 1.0,
          //子Widget列表
          children: <Widget>[
            ViewTwoColItem(),
            ViewTwoColItem()
          ]
        );
  }
}