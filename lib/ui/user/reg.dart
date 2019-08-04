import 'dart:async';

import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class UserReg extends StatefulWidget {
  @override
  State<UserReg> createState() => new _UserRegState();
}

class _UserRegState extends State<UserReg> {
  @override
  void initState() {
    showPwd = false;
    vcodeTimer = 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showPwd;
  int vcodeTimer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.appBar(context, iconData: Icons.close),
      body: Container(
        color: MyTheme.bgColor,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: MyTheme.sz(20)),
          children: <Widget>[
            Container(
              height: MyTheme.sz(30),
            ),
            Container(
              alignment: Alignment.centerLeft,
              height: MyTheme.sz(30),
              child: Text(
                '用户注册',
                style: TextStyle(
                    fontSize: MyTheme.sz(22), fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MyTheme.sz(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MyTheme.sz(5),
                horizontal: MyTheme.sz(0),
              ),
              child: TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.number,
                maxLength: 11,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  counterText: "",
                  hintText: '请输入手机号',
                  prefixIcon: Icon(
                    Icons.phone_iphone,
                    color: MyTheme.hintColor,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: MyTheme.sz(5),
                horizontal: MyTheme.sz(0),
              ),
              child: Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: <Widget>[
                  TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly
                    ],
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: '请输入验证码',
                      prefixIcon: Icon(
                        Icons.dialpad,
                        color: MyTheme.hintColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        if (vcodeTimer > 0) {
                          return;
                        }
                        vcodeTimer = 60;
                        setState(() {});
                        Timer.periodic(Duration(seconds: 1), (timer) {
                          if (--vcodeTimer <= 0) {
                            timer.cancel();
                          }
                          setState(() {});
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.all(4),
                        child: Text(
                          vcodeTimer > 0 ? '还剩($vcodeTimer)秒' : '获取验证码',
                          style: TextStyle(
                              fontSize: 12,
                              color: vcodeTimer > 0
                                  ? MyTheme.fontLightColor
                                  : MyTheme.fontDeepColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: MyTheme.sz(5), horizontal: MyTheme.sz(0)),
              child: TextFormField(
                maxLines: 1,
                maxLength: 32,
                obscureText: !showPwd,
                decoration: InputDecoration(
                    counterText: "",
                    hintText: '请输入密码',
                    prefixIcon: Icon(
                      Icons.lock,
                      color: MyTheme.hintColor,
                    ),
                    suffix: GestureDetector(
                      onTap: () {
                        showPwd = !showPwd;
                        setState(() {});
                      },
                      child: Icon(
                        showPwd ? Icons.visibility : Icons.visibility_off,
                        size: MyTheme.sz(20),
                        color: MyTheme.hintColor,
                      ),
                    )),
              ),
            ),
            Container(
              height: MyTheme.sz(20),
            ),
            Container(
              height: MyTheme.sz(20),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: MyTheme.sz(5), horizontal: MyTheme.sz(0)),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(MyTheme.sz(30))),
                padding: EdgeInsets.all(MyTheme.sz(8)),
                onPressed: () {
                  Navigator.pop(context);
                },
                color: MyTheme.color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('注 册',
                        style: TextStyle(
                            fontSize: MyTheme.sz(18), color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
