import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_video_show_item.dart';

class ViewVideoShowPanel extends StatefulWidget {
  ViewVideoShowPanel();
  @override
  State<ViewVideoShowPanel> createState() => _ViewVideoShowPanelState();
}

class _ViewVideoShowPanelState extends State<ViewVideoShowPanel> {
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MyTheme.sz(5)),
      child:Container(
      color: MyTheme.bgColor,
      child:  ListBody(
      children: <Widget>[
        Row(
          children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(MyTheme.sz(10)),
              child: Text("精选", style: TextStyle(
              fontSize: MyTheme.sz(20),
              fontWeight: FontWeight.w600
              ))
            ),
          ),
          FlatButton(
            onPressed: (){},
            textColor: MyTheme.fontColor,
            child: Text("查看更多",
            ),
          )
        ]),
        Column(
          children: <Widget>[
            ViewVideoShowItem(
              picUrl:"https://ykimg.alicdn.com/develop/image/2019-03-13/013cc9422f4c032737722edf1e6180f7.jpg",
              title:"姚芊羽李建上演新农村创业"
            ),
            ViewVideoShowItem(
              picUrl:"https://liangcang-material.alicdn.com/prod/upload/9a0cd5d5b55746f5954211db3467d717.jpg",
              title:"邓伦马思纯都市情感甜怼恋"
            )
          ],
        ),
      ],
    ),
    ));
  }
}