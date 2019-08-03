import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeIndex extends StatefulWidget {
  @override
  State<MeIndex> createState() => new _IndexState();
}

class _UnloginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      onPressed: () {
        Navigator.pushNamed(context, '/me/login');
      },
      color: MyTheme.bgColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipOval(
                child: Container(
                  height: 70,
                  width: 70,
                  padding: EdgeInsets.all(MyTheme.sz(3)),
                  color: Colors.grey,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: MyTheme.sz(60),
                  ),
                ),
              ),
              SizedBox(
                width: MyTheme.sz(10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "登录/注册",
                      style: TextStyle(
                          fontSize: MyTheme.sz(20),
                          color: MyTheme.colorDeep,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: MyTheme.sz(3),
                    ),
                    Text(
                      "快速登录，观看更多精彩视频",
                      style: TextStyle(),
                    )
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: MyTheme.fontColor,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _UserStuffWidget extends StatelessWidget {
  final int balance;
  final bool vip;
  final int watchCount;
  final int watchTotal;
  final int income;
  _UserStuffWidget(
      {this.balance = 0,
      this.vip = false,
      this.watchCount = 0,
      this.watchTotal = 0,
      this.income = 0});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: MyTheme.sz(15)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(0),
              textColor: MyTheme.fontColor,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Text(
                    balance.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Text("我的余额")
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(0),
              textColor: MyTheme.fontColor,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Text(
                    vip ? "已开通" : "未开通",
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Text("我的VIP")
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(0),
              textColor: MyTheme.fontColor,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Text(
                    watchCount.toString() + "/" + watchTotal.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Text("观看次数")
                ],
              ),
            ),
          ),
          Expanded(
            child: FlatButton(
              padding: EdgeInsets.all(0),
              textColor: MyTheme.fontColor,
              onPressed: () {},
              child: Column(
                children: <Widget>[
                  Text(
                    income.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Text("推广收益")
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

final TextStyle _itemTitleText = TextStyle(fontSize: MyTheme.sz(16));
final TextStyle _itemContentText =
    TextStyle(fontSize: MyTheme.sz(14), color: MyTheme.fontColor);

class _IndexState extends State<MeIndex> with TickerProviderStateMixin {
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
    return Scaffold(
      body: ListView(
        children: <Widget>[
          _UnloginWidget(),
          _UserStuffWidget(
              balance: 0, vip: false, watchCount: 0, watchTotal: 0, income: 0),
          SizedBox(
            height: MyTheme.sz(5),
          ),
          Container(
            padding: EdgeInsets.all(MyTheme.sz(10)),
            child: FlatButton(
              highlightColor: Colors.deepOrangeAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MyTheme.sz(10))),
              padding: EdgeInsets.all(MyTheme.sz(12)),
              onPressed: () {},
              color: MyTheme.color,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.attach_money,
                    color: Colors.white,
                  ),
                  Text("我要充值",
                      style: TextStyle(
                          fontSize: MyTheme.sz(18), color: Colors.white))
                ],
              ),
            ),
          ),
          SizedBox(
            height: MyTheme.sz(5),
          ),
          Container(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: MyImage(
                  "https://u8.iqiyipic.com/xiuchang/20190116/3e/b3/xiuchang_5c3ee8ccf6882e0d73463eb3_banner.jpg"),
            ),
          ),
          SizedBox(
            height: MyTheme.sz(5),
          ),
          Container(
            color: MyTheme.bgColor,
            child: Column(
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(15), vertical: MyTheme.sz(20)),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "官方邮箱",
                          style: _itemTitleText,
                        ),
                      ),
                      Text(
                        "14547272@163.com",
                        style: _itemContentText,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MyTheme.sz(15)),
                  height: MyTheme.sz(1),
                  color: Colors.grey[200],
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(15), vertical: MyTheme.sz(20)),
                  onPressed: () {},
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "意见反馈",
                          style: _itemTitleText,
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: MyTheme.fontColor,
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
