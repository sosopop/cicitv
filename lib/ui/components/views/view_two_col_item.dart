import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewTwoColItem extends StatefulWidget {
  ViewTwoColItem() {
  }
  @override
  State<ViewTwoColItem> createState() => _ViewTwoColItemState();
}

class _ViewTwoColItemState extends State<ViewTwoColItem> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        MyImage(
          "https://liangcang-material.alicdn.com/prod/upload/eb4f72d284dc4a2f92ee324c44c7af4f.jpg?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100"
        ),
        Container(
          padding: EdgeInsets.all(MyTheme.sz(10)),
          child: Text("极限挑战·朱碧石回归？"),
        )
      ]
    );
  }
}