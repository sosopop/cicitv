import 'package:cicitv/common/mytoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/model/user.dart';

class _ByItem extends StatelessWidget {
  final int type;
  final String content;
  _ByItem({this.type, this.content});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      onTap: () {
        ClipboardData data = new ClipboardData(text: content);
        Clipboard.setData(data);
        MyToast('已经复制到剪贴板');
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: MyTheme.sz(10), vertical: MyTheme.sz(5)),
        child: Row(
          children: <Widget>[
            type == 0
                ? Icon(
                    FontAwesomeIcons.qq,
                    color: MyTheme.fontColor,
                  )
                : Icon(
                    FontAwesomeIcons.weixin,
                    color: MyTheme.fontColor,
                  ),
            SizedBox(
              width: MyTheme.sz(20),
            ),
            Text(
              '88888888',
              style: TextStyle(
                color: MyTheme.fontLightColor,
              ),
            ),
            Spacer(),
            ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(MyTheme.sz(5))),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MyTheme.sz(10),
                  vertical: MyTheme.sz(5),
                ),
                color: MyTheme.transBlackIcon,
                child: Text(
                  '点击复制',
                  style: TextStyle(
                      fontSize: MyTheme.sz(12), color: MyTheme.bgColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class UserRecharge extends StatefulWidget {
  @override
  State<UserRecharge> createState() => new _UserRechargeState();
}

class _UserRechargeState extends State<UserRecharge> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool expend = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.appBar(context, text: "用户充值"),
      body: ListTileTheme(
        //textColor: MyTheme.color,
        dense: true,
        child: StreamBuilder<UserModel>(
          initialData: GlobalController.user.initialData(),
          stream: GlobalController.user.stream,
          builder: (context, snapshot) {
            var user = snapshot.data;
            return Container(
              child: ListView(
                children: <Widget>[
                  Container(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    height: MyTheme.sz(120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          '当前余额 ${user.balance}',
                          style: TextStyle(fontSize: MyTheme.sz(22)),
                        ),
                        SizedBox(
                          width: MyTheme.sz(10),
                        ),
                        Icon(
                          FontAwesomeIcons.solidGem,
                          color: MyTheme.color,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    color: MyTheme.bgColor,
                    child: ExpansionTile(
                      onExpansionChanged: (v) {
                        setState(() {
                          expend = v;
                        });
                      },
                      initiallyExpanded: true,
                      title: Text(
                        "购买卡密",
                        style: TextStyle(fontSize: MyTheme.sz(16)),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: expend ? 1 : 0,
                        child: Icon(
                          Icons.chevron_right,
                          color: MyTheme.fontColor,
                        ),
                      ),
                      children: <Widget>[
                        Container(
                          color: Colors.grey[50],
                          padding: EdgeInsets.symmetric(
                              horizontal: MyTheme.sz(20),
                              vertical: MyTheme.sz(15)),
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                '请点击复制下面的QQ号码或微信客服，加好友购买卡密。',
                                style: TextStyle(
                                    fontSize: MyTheme.sz(12),
                                    color: MyTheme.fontLightColor),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              _ByItem(type: 0, content: "146551345"),
                              _ByItem(type: 1, content: "947854633"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MyTheme.sz(10),
                  ),
                  Container(
                    color: MyTheme.bgColor,
                    child: ListBody(
                      children: <Widget>[
                        ListTile(
                          onTap: () {
                            TextEditingController nameController =
                                TextEditingController();
                            showDialog<int>(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    '卡密激活',
                                  ),
                                  content: TextField(
                                    controller: nameController,
                                    decoration: InputDecoration(
                                        hintText: '请输入您需要激活的卡密'),
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
                            ).then((ret) {
                              if (ret == 1) {
                                MyToast('卡密已经激活成功，充值200钻石');
                                setState(() {});
                              }
                            });
                          },
                          title: Text(
                            "激活卡密",
                            style: TextStyle(fontSize: MyTheme.sz(16)),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: MyTheme.fontColor,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/user/buyvip');
                          },
                          title: Text(
                            "VIP购买",
                            style: TextStyle(fontSize: MyTheme.sz(16)),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: MyTheme.fontColor,
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.pushNamed(context, '/user/bill');
                          },
                          title: Text(
                            "消费充值记录",
                            style: TextStyle(fontSize: MyTheme.sz(16)),
                          ),
                          trailing: Icon(
                            Icons.chevron_right,
                            color: MyTheme.fontColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
