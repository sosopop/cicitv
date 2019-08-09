import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewStarShowItem extends StatelessWidget {
  final String picUrl;
  final String title;
  final String targetUrl;
  ViewStarShowItem({this.picUrl, this.title, this.targetUrl});

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        Navigator.pushNamed(context, '/video/person');
      },
      padding: EdgeInsets.symmetric(horizontal: MyTheme.sz(2)),
      child: Column(children: <Widget>[
        Container(
          height: MyTheme.sz(90),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(MyTheme.sz(50)),
              child: MyImage(picUrl),
            ),
          ),
        ),
        Container(
          alignment: Alignment.center,
          width: MyTheme.sz(90),
          height: MyTheme.sz(30),
          padding: EdgeInsets.symmetric(vertical: MyTheme.sz(5)),
          child: Text(
            title,
            maxLines: 1,
          ),
        ),
      ]),
    );
  }
}
