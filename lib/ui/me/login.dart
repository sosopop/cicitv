import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/strings.dart';

class MeLogin extends StatefulWidget {
  @override
  State<MeLogin> createState() => new _MeLoginState();
}

class _MeLoginState extends State<MeLogin> with TickerProviderStateMixin {
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
      appBar: MyTheme.appBar(context),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: MyTheme.sz(20)),
        children: <Widget>[
          Container(
            height: MyTheme.sz(20),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: MyTheme.sz(30),
            child: Text(
              '欢迎您',
              style: TextStyle(fontSize: MyTheme.sz(24)),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            height: MyTheme.sz(30),
            child: Text(
              '正在使用手机号注册',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: MyTheme.sz(10)),
            child: TextField(
              maxLines: 1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: '请输入手机号',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
