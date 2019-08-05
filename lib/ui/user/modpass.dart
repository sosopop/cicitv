import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserModPass extends StatefulWidget {
  @override
  State<UserModPass> createState() => new _UserModPassState();
}

class _UserModPassState extends State<UserModPass> {
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
                '修改密码',
                style: TextStyle(
                    fontSize: MyTheme.sz(22), fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: MyTheme.sz(20),
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
                  hintText: '请输入当前密码',
                  prefixIcon: Icon(
                    Icons.lock_open,
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
              padding: EdgeInsets.symmetric(
                  vertical: MyTheme.sz(5), horizontal: MyTheme.sz(0)),
              child: TextFormField(
                maxLines: 1,
                maxLength: 32,
                obscureText: !showPwd,
                decoration: InputDecoration(
                    counterText: "",
                    hintText: '请输入新密码',
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
                      Future.delayed(Duration(seconds: 2)).then((_) {
                        Navigator.pop(context);
                      });
                    },
                  );
                  Navigator.pop(context);
                },
                color: MyTheme.color,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '确 定',
                      style: TextStyle(
                          fontSize: MyTheme.sz(18), color: Colors.white),
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
