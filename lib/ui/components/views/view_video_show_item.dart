import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';

class ViewVideoShowItem extends StatelessWidget {
  final String picUrl;
  final String title;
  final String targetUrl;
  final int playCount;
  ViewVideoShowItem( {this.picUrl, this.title, this.targetUrl, this.playCount} );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Stack(
          children: <Widget>[
            AspectRatio(
              child: MyImage(
                picUrl
              ),
              aspectRatio: 16/9,
            ),
            Positioned(
              top:0,
              right: MyTheme.sz(MediaQuery.of(context).size.width*3/100),
              child: ClipRRect(
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
                  )
                )
              )
            ),
            AspectRatio(
              child: Center(
                child: FlatButton(
                  child: Icon(
                    Icons.play_arrow,
                    size: MyTheme.sz(50),
                    color: MyTheme.transWhiteIcon,
                    ),
                  color: MyTheme.transBlackIcon,
                  onPressed: (){},
                  shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(MyTheme.sz(50)))
                        ),
                )
              ),
              aspectRatio: 16/9,
            )
          ],
        ),
        FlatButton(
          onPressed: () {

          },
          padding: EdgeInsets.all(MyTheme.sz(10)),
          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: MyTheme.sz(16)
                  ),
                  maxLines: 1,
                )
              ),
              Icon(
                Icons.visibility,
                color: MyTheme.fontColor
              ),
              SizedBox(
                width: MyTheme.sz(5),
              ),
              Text(
                "1001",
                style: TextStyle(color: MyTheme.fontColor,fontSize: MyTheme.sz(12)),
              ),
              SizedBox(
                width: MyTheme.sz(7),
              ),
              Icon(
                Icons.chat_bubble_outline,
                color: MyTheme.fontColor
              ),
              SizedBox(
                width: MyTheme.sz(5),
              ),
              Text(
                "97",
                style: TextStyle(color: MyTheme.fontColor,fontSize: MyTheme.sz(12)),
              )
        ]
          ),
        )
      ]
    );
  }
}