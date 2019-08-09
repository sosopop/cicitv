import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewAdvItem extends StatelessWidget {
  final String picUrl;
  final String targetUrl;
  ViewAdvItem({this.picUrl, this.targetUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            AspectRatio(
              child: MyImage(
                  "http://img.zcool.cn/community/01bf7a55752a810000009fcb6638d9.jpg@640w_1l_2o_100sh.jpg"),
              aspectRatio: 3,
            ),
            Positioned(
              top: 0,
              right: MyTheme.sz(MediaQuery.of(context).size.width * 3 / 100),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(MyTheme.sz(3))),
                child: Container(
                  padding: EdgeInsets.all(MyTheme.sz(5)),
                  color: MyTheme.transBlackIcon,
                  child: Text(
                    "广告",
                    style: TextStyle(
                      fontSize: MyTheme.sz(14),
                      color: MyTheme.revFontColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
