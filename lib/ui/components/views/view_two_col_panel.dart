import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_two_col_item.dart';

class ViewTwoColPanel extends StatefulWidget {
  ViewTwoColPanel() {
  }
  @override
  State<ViewTwoColPanel> createState() => _ViewTwoColPanelState();
}

class _ViewTwoColPanelState extends State<ViewTwoColPanel> {
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
    return Container(child:  ListBody(
      children: <Widget>[
        Row(
          children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text("热门", style: TextStyle(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ViewTwoColItem(),
            ViewTwoColItem()
          ]
        ),
        
      ],
    ),
    color: MyTheme.bgColor,
    );
  }
}