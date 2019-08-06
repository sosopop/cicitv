import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/model/user.dart';
import 'package:flutter/material.dart';

class UserCashOut extends StatefulWidget {
  @override
  State<UserCashOut> createState() => new _UserCashOutState();
}

class _UserCashOutState extends State<UserCashOut> {
  int typeValue = 0;

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
      appBar: MyTheme.appBar(context, text: "收益提现"),
      body: StreamBuilder<UserModel>(
        initialData: GlobalController.user.initialData(),
        stream: GlobalController.user.stream,
        builder: (context, snapshot) {
          var user = snapshot.data;
          return Container(
            color: MyTheme.bgColor,
            padding: EdgeInsets.symmetric(
              horizontal: MyTheme.sz(15),
            ),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: MyTheme.sz(10)),
                  child: Text(
                    '请选择提现方式',
                    style: TextStyle(color: MyTheme.fontColor),
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Radio(
                        value: 0,
                        groupValue: typeValue,
                        onChanged: (v) {
                          setState(() {
                            typeValue = v;
                          });
                        },
                      ),
                      Text('提现至支付宝'),
                      Radio(
                        value: 1,
                        groupValue: typeValue,
                        onChanged: (v) {
                          setState(() {
                            typeValue = v;
                          });
                        },
                      ),
                      Text('提现至微信'),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    vertical: MyTheme.sz(5),
                    horizontal: MyTheme.sz(15),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '请输入您的支付宝账号',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MyTheme.sz(15),
                    vertical: MyTheme.sz(5),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: '请输入本次提现金额',
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(MyTheme.sz(15)),
                  child: Text(
                    '提现提交后将会在24小时内到账,请注意查收.',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(MyTheme.sz(15)),
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
                        Text('提 交',
                            style: TextStyle(
                                fontSize: MyTheme.sz(18), color: Colors.white))
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
