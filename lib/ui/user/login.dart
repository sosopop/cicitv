import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserLogin extends StatefulWidget {
  @override
  State<UserLogin> createState() => new _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  @override
  void initState() {
    showPwd = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool showPwd;

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
                '您好，欢迎登录',
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
                  ),
                ),
              ),
            ),
            Container(
              height: MyTheme.sz(20),
            ),
            Container(
              height: MyTheme.sz(40),
              child: Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/user/forget');
                    },
                    child: Text(
                      '忘记密码',
                      style: TextStyle(color: MyTheme.fontColor),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/user/reg');
                    },
                    child: Text(
                      '我要注册',
                      style: TextStyle(color: MyTheme.fontColor),
                    ),
                  )
                ],
              ),
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
                  MyToast('登录成功');
                },
                color: MyTheme.color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '登 录',
                      style: TextStyle(
                        fontSize: MyTheme.sz(18),
                        color: Colors.white,
                      ),
                    )
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
