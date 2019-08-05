import 'dart:async';
import 'dart:io';
import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/model/user.dart';

class _LoginedWidget extends StatelessWidget {
  final UserModel user;
  _LoginedWidget(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      color: MyTheme.bgColor,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          "我的余额 ",
                          style: TextStyle(
                              fontSize: 18,
                              color: MyTheme.fontDeepColor,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "${user.balance}钻石",
                          style: TextStyle(
                              fontSize: 18,
                              color: MyTheme.colorDeep,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          FontAwesomeIcons.solidGem,
                          color: Colors.orange,
                          size: MyTheme.sz(12),
                        ),
                        SizedBox(
                          width: 10,
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
              )
            ],
          )
        ],
      ),
    );
  }
}

class _VIPItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final String price;
  final int value;
  final int groupValue;
  final Function onChanged;

  _VIPItem(this.onChanged, this.title, this.subTitle, this.value, this.price,
      this.groupValue);

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
      title: Text(
        title,
        style: TextStyle(
          fontSize: MyTheme.sz(14),
        ),
      ),
      subtitle: Text(
        subTitle,
        style: TextStyle(
          fontSize: MyTheme.sz(12),
        ),
      ),
      value: value,
      groupValue: groupValue,
      onChanged: onChanged,
      secondary: Text(
        price,
        style: TextStyle(
          color: MyTheme.colorDeep,
          fontSize: MyTheme.sz(12),
        ),
      ),
      isThreeLine: true,
    );
  }
}

class UserBuyVIP extends StatefulWidget {
  @override
  State<UserBuyVIP> createState() => new _UserBuyVIPState();
}

class VIPInfoModel {
  int id;
  String title;
  String desc;
  int price;
  VIPInfoModel({
    this.id = 0,
    this.title: "",
    this.desc: "",
    this.price: 0,
  });
}

class _UserBuyVIPState extends State<UserBuyVIP> {
  List<VIPInfoModel> vipInfos = <VIPInfoModel>[
    VIPInfoModel(id: 0, title: 'VIP周卡', desc: '7天150钻石', price: 150),
    VIPInfoModel(id: 1, title: 'VIP月卡', desc: '30天300钻石', price: 300),
    VIPInfoModel(id: 2, title: 'VIP季卡', desc: '90天800钻石', price: 800),
    VIPInfoModel(id: 3, title: 'VIP卡', desc: '365天1500钻石', price: 1500),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int selectedType = -1;
  TextStyle _rightsStyle = TextStyle(
    color: MyTheme.fontLightColor,
  );

  int getPrice() {
    for (VIPInfoModel vipInfo in vipInfos) {
      if (vipInfo.id == selectedType) {
        return vipInfo.price;
      }
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> vipWidget = <Widget>[];
    vipWidget.add(Container(
      padding: EdgeInsets.symmetric(
          horizontal: MyTheme.sz(10), vertical: MyTheme.sz(15)),
      color: MyTheme.bgColor,
      child: Text(
        '请选择您要购买的VIP类型',
        style: TextStyle(fontSize: MyTheme.sz(12), color: MyTheme.fontColor),
      ),
    ));
    for (VIPInfoModel vipInfo in vipInfos) {
      vipWidget.add(
        _VIPItem(
          (int newValue) {
            setState(() {
              selectedType = newValue;
            });
          },
          vipInfo.title,
          vipInfo.desc,
          vipInfo.id,
          '${vipInfo.price} 钻石',
          selectedType,
        ),
      );
      vipWidget.add(
        Divider(
          height: 10,
        ),
      );
    }
    vipWidget.add(Container(
      padding: EdgeInsets.all(MyTheme.sz(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "支付金额 ",
            style: TextStyle(
                fontSize: 18,
                color: MyTheme.fontDeepColor,
                fontWeight: FontWeight.normal),
          ),
          Text(
            "${getPrice()}钻石",
            style: TextStyle(
                fontSize: 18,
                color: MyTheme.colorDeep,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ));
    vipWidget.add(Padding(
      padding: EdgeInsets.all(MyTheme.sz(15)),
      child: FlatButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(MyTheme.sz(30))),
        padding: EdgeInsets.all(MyTheme.sz(8)),
        onPressed: () async {
          await showLoadingDialog(
            context: context,
            callback: (context) {
              GlobalController.user.login();
              Future.delayed(Duration(seconds: 2)).then((_) {
                Navigator.pop(context);
              });
            },
          );
          Navigator.pop(context);
          MyToast('购买成功');
        },
        color: MyTheme.color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '变身VIP',
              style: TextStyle(
                fontSize: MyTheme.sz(18),
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    ));
    vipWidget.add(
      Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: EdgeInsets.all(MyTheme.sz(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('会员权益说明'),
            SizedBox(
              height: MyTheme.sz(5),
            ),
            Text(
              '1.会员免费观看所有在线影片',
              style: _rightsStyle,
            ),
          ],
        ),
      ),
    );
    return Scaffold(
      appBar: MyTheme.appBar(context, text: "购买会员"),
      body: StreamBuilder<UserModel>(
        initialData: GlobalController.user.initialData(),
        stream: GlobalController.user.stream,
        builder: (context, snapshot) {
          var user = snapshot.data;
          if (user.userId.isNotEmpty) {}
          return ListTileTheme(
            dense: true,
            child: Container(
              child: ListView(
                children: <Widget>[
                  _LoginedWidget(user),
                  SizedBox(
                    height: MyTheme.sz(10),
                  ),
                  Container(
                    color: MyTheme.bgColor,
                    child: ListBody(
                      children: vipWidget,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
