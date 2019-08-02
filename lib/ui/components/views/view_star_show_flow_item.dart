import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewStarShowFlowItem extends StatelessWidget {
  final String picUrl;
  final String title;
  final String desc;
  final String targetUrl;
  final double ratio;
  ViewStarShowFlowItem(
      {this.picUrl, this.title, this.desc, this.targetUrl, this.ratio = 1});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MyTheme.sz(5)),
        child: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: <Widget>[
            Container(
              child: AspectRatio(
                  aspectRatio: ratio,
                  child: FittedBox(
                    child: MyImage(picUrl),
                    fit: BoxFit.cover,
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                // Box decoration takes a gradient
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  stops: [0.1, 1],
                  colors: [
                    // Colors are easy thanks to Flutter's Colors class.
                    Colors.transparent,
                    MyTheme.transBlackIcon,
                  ],
                ),
              ),
              padding: EdgeInsets.fromLTRB(
                  MyTheme.sz(5), MyTheme.sz(50), MyTheme.sz(5), MyTheme.sz(10)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 1,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    "1.1万",
                    style: TextStyle(
                        color: Colors.white, fontSize: MyTheme.sz(12)),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
