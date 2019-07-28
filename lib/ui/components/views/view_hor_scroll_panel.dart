import 'package:cicitv/ui/components/views/view_video_show_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/views/view_star_show_item.dart';

class ViewHorScrollPanel extends StatefulWidget {
  ViewHorScrollPanel();
  @override
  State<ViewHorScrollPanel> createState() => _ViewHorScrollPanelState();
}

class _ViewHorScrollPanelState extends State<ViewHorScrollPanel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: MyTheme.sz(5)),
        child: Container(
          color: MyTheme.bgColor,
          child: ListBody(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(MyTheme.sz(10)),
                    child: Text(
                      "主播秀",
                      style: TextStyle(
                          fontSize: MyTheme.sz(20),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  textColor: MyTheme.fontColor,
                  child: Row(
                    children: <Widget>[
                      Text(
                        "发现更多 ",
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: MyTheme.fontColor,
                        size: MyTheme.sz(12),
                      )
                    ],
                  ),
                )
              ]),
              Container(
                padding: EdgeInsets.all(MyTheme.sz(5)),
                height: MyTheme.sz(140),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/f00581188e4871ad91d3c1aae927241b-320_320.jpg",
                        title: "💃暴走的呐呐💫"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/92ababd9c29b660949ebc5a635cd7a4a-320_320.jpg",
                        title: "晴菀菀🌈"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/683a97eaa1aef27e993bb809fe8425bb-320_320.jpg",
                        title: "🌸ゅ≈心儿≈ゅ"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/99250e2dd21c8d473a5e8048fd644655-320_320.jpg",
                        title: "🎀美伢子🎀"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/ece5a1a545ef3b0d8ec7dd5610e50262-320_320.jpg",
                        title: "🍑淘气的小桃子"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/1c1f1141084ebcc5beff27fcee4be179-320_320.jpg",
                        title: "木木哒🎉新人求罩"),
                    ViewStarShowItem(
                        picUrl:
                            "http://image.huajiao.com/700f2ff82574b37f46f9c8e7cde3ccf2-320_320.jpg",
                        title: "女神@小羽YU")
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
