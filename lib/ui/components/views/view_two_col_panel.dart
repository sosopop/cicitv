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
    //计算单元宽高比
    int crossAxisCount = 2;
    Size size = MediaQuery.of(context).size;
    double itemWidth = ((size.width - MyTheme.sz(3)*(crossAxisCount-1)) / crossAxisCount);
    double itemHeight = itemWidth * 9/16 + MyTheme.sz(5.0*2 + 20.0);
    double itemRatio = itemWidth / itemHeight;
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
        Container(
          color: Colors.white,
          child: GridView.count(
          shrinkWrap: true,
          physics: new NeverScrollableScrollPhysics(),
          //水平子Widget之间间距
          crossAxisSpacing: MyTheme.sz(3),
          //垂直子Widget之间间距
          mainAxisSpacing: 0.0,
          //一行的Widget数量
          crossAxisCount: crossAxisCount,
          //子Widget宽高比例
          childAspectRatio: itemRatio,
          //子Widget列表
          children: <Widget>[
            ViewTwoColItem(
              picUrl:"https://liangcang-material.alicdn.com/prod/upload/0d46551a90414b439d6a36befe11d645.jpg?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100",
              title:"萧正楠林夏薇破悬疑奇案"
            ),
            ViewTwoColItem(
              picUrl:"https://r1.ykimg.com/050C000059E95739AD881A0485004B7F?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100",
              title:"第一网络神剧贺岁篇"
            ),
            ViewTwoColItem(
              picUrl:"https://liangcang-material.alicdn.com/prod/upload/1cb010ad57a74fdc9ed4622a72d1d8d2.jpg?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100",
              title:"鞠婧祎复仇炎亚纶痴心守护"
            ),
            ViewTwoColItem(
              picUrl:"https://r1.ykimg.com/050E00005CD287A9859B5DB9D801B34F?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100",
              title:"青涩初恋模样"
            )
          ]
        )),
      ],
    ),
    ));
  }
}