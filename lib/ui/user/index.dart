import 'package:cicitv/common/mytoast.dart';
import 'package:cicitv/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/global_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserIndex extends StatefulWidget {
  @override
  State<UserIndex> createState() => new _IndexState();
}

class _UnloginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      onPressed: () {
        Navigator.pushNamed(context, '/user/login');
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
                          fontWeight: FontWeight.bold),
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

class _LoginedWidget extends StatelessWidget {
  final UserModel user;
  _LoginedWidget(this.user);
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(20),
      onPressed: () {
        Navigator.pushNamed(context, '/user/modify');
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
                  color: Colors.grey,
                  child: MyImage(user.avatar),
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
                      user.userName,
                      style: TextStyle(
                          fontSize: MyTheme.sz(20),
                          color: MyTheme.colorDeep,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MyTheme.sz(3),
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.solidGem,
                          color: Colors.orange,
                          size: MyTheme.sz(12),
                        ),
                        SizedBox(
                          width: MyTheme.sz(5),
                        ),
                        Text(
                          user.vip ? "VIP过期时间:${user.vipEndTime}" : "尚未开通vip",
                          style: TextStyle(
                              fontSize: 12,
                              color: MyTheme.fontColor,
                              fontWeight: FontWeight.normal),
                        ),
                      ],
                    ),
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
  final UserModel user;
  _UserStuffWidget(this.user);
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
              onPressed: () {
                if (user.userId.isNotEmpty) {
                  Navigator.pushNamed(context, '/user/recharge');
                } else {
                  Navigator.pushNamed(context, '/user/login');
                }
              },
              child: Column(
                children: <Widget>[
                  Text(
                    user.balance.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.bold,
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
              onPressed: () {
                Navigator.pushNamed(context, '/user/buyvip');
              },
              child: Column(
                children: <Widget>[
                  Text(
                    user.vip ? "已开通" : "未开通",
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.bold,
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
                    user.viewTimes.toString() +
                        "/" +
                        user.totalViewTimes.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.bold,
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
                    user.income.toString(),
                    style: TextStyle(
                        color: MyTheme.fontDeepColor,
                        fontSize: MyTheme.sz(18),
                        fontWeight: FontWeight.bold,
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

class _IndexState extends State<UserIndex> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
    var data = GlobalController.user.initialData();
    return StreamBuilder<UserModel>(
      initialData: data,
      stream: GlobalController.user.stream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return Container();
        var user = snapshot.data;
        return Scaffold(
          body: SafeArea(
            child: SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              onRefresh: () async {
                return Future<void>.delayed(Duration(seconds: 1)).then((_) {
                  _refreshController.refreshCompleted();
                });
              },
              header: MaterialClassicHeader(),
              child: ListView(
                children: <Widget>[
                  user.userId.isEmpty ? _UnloginWidget() : _LoginedWidget(user),
                  _UserStuffWidget(user),
                  Container(
                    padding: EdgeInsets.all(MyTheme.sz(10)),
                    child: Card(
                      elevation: 15.0,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: new Column(
                        // card只能有一个widget，但这个widget内容可以包含其他的widget
                        children: [
                          Container(
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: MyImage(
                                  "https://u8.iqiyipic.com/xiuchang/20190116/3e/b3/xiuchang_5c3ee8ccf6882e0d73463eb3_banner.jpg"),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(
                              horizontal: MyTheme.sz(20),
                              vertical: MyTheme.sz(10),
                            ),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '我的推广码 ',
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                Text(
                                  'Zf43s',
                                  style: TextStyle(color: MyTheme.color),
                                ),
                                Spacer(
                                  flex: 1,
                                ),
                                FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          MyTheme.sz(30))),
                                  onPressed: () {
                                    ClipboardData data = new ClipboardData(
                                        text: "http://www.baidu.com");
                                    Clipboard.setData(data);
                                    MyToast('推广连接已经复制到剪贴板');
                                  },
                                  color: MyTheme.color,
                                  child: Text(
                                    '点击复制推广链接',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Divider(height: 1),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(MyTheme.sz(20)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "推广1人,每日观影次数 +2",
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                SizedBox(
                                  height: MyTheme.sz(3),
                                ),
                                Text(
                                  "推广2人,每日观影次数 +5",
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                SizedBox(
                                  height: MyTheme.sz(3),
                                ),
                                Text(
                                  "推广5人,每日观影次数 +20",
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                SizedBox(
                                  height: MyTheme.sz(3),
                                ),
                                Text(
                                  "推广10人,每日观影次数 +50",
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                SizedBox(
                                  height: MyTheme.sz(3),
                                ),
                                Text(
                                  "推广30人,每日观影次数 +999",
                                  style: TextStyle(color: MyTheme.fontColor),
                                ),
                                SizedBox(
                                  height: MyTheme.sz(10),
                                ),
                                Text(
                                  "用户充值返现40%,提现秒到账",
                                  style: TextStyle(
                                      color: MyTheme.fontDeepColor,
                                      fontSize: MyTheme.sz(16)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Container(
                    padding: EdgeInsets.all(MyTheme.sz(10)),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(MyTheme.sz(10))),
                      padding: EdgeInsets.all(MyTheme.sz(12)),
                      onPressed: () {
                        if (user.userId.isNotEmpty) {
                          Navigator.pushNamed(context, '/user/recharge');
                        } else {
                          Navigator.pushNamed(context, '/user/login');
                        }
                      },
                      color: MyTheme.colorDark,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.attach_money,
                            color: Colors.white,
                          ),
                          Text("我要充值",
                              style: TextStyle(
                                  fontSize: MyTheme.sz(18),
                                  color: Colors.white))
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MyTheme.sz(5),
                  ),
                  Container(
                    color: MyTheme.bgColor,
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          title: Text(
                            "官方邮箱",
                            style: _itemTitleText,
                          ),
                          trailing: Text(
                            "symmetric@163.com",
                            style: _itemContentText,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () async {
                            TextEditingController nameController =
                                TextEditingController();
                            int ret = await showDialog<int>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('意见反馈'),
                                  content: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                      hintText: '请输入您的反馈意见',
                                    ),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text('确定'),
                                      onPressed: () {
                                        Navigator.of(context).pop(1);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                            if (ret == 1) {
                              setState(() {});
                            }
                          },
                          title: Text(
                            "意见反馈",
                            style: _itemTitleText,
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: MyTheme.fontColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MyTheme.sz(40),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
