import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewTwoColItem extends StatelessWidget {
  final String picUrl;
  final String title;
  final String targetUrl;
  ViewTwoColItem( {this.picUrl, this.title, this.targetUrl} );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          alignment: const FractionalOffset(0.95, 0.0),//方法一
          children: <Widget>[
            AspectRatio(
              child: MyImage(
                picUrl
              ),
              aspectRatio: 16/9,
            ),
            ClipRRect(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(MyTheme.sz(3))),
              child:Container(
              padding: EdgeInsets.all(MyTheme.sz(3)),
              color: MyTheme.tagColor,
              child: Text(
                "100钻石",
                style: TextStyle(
                  fontSize: MyTheme.sz(10),
                  color: MyTheme.revFontColor
                ),
                ))
                ),
          ],
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.all(MyTheme.sz(5)),
          child: Text(
            title,
            style: TextStyle(
              fontSize: MyTheme.sz(14)
            ),
            maxLines: 1,
            ),
        )
      ]
    );
  }
}