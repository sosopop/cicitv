import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/model/user.dart';
import 'package:flutter/material.dart';

class UserIncome extends StatefulWidget {
  @override
  State<UserIncome> createState() => new _UserIncomeState();
}

class _UserIncomeState extends State<UserIncome> {
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
      appBar: MyTheme.appBar(context, text: "推广收益"),
      body: StreamBuilder<UserModel>(
        initialData: GlobalController.user.initialData(),
        stream: GlobalController.user.stream,
        builder: (context, snapshot) {
          var user = snapshot.data;
          return Container(
            child: ListView(
              children: <Widget>[
                Container(
                  color: MyTheme.bgColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: MyTheme.sz(30),
                      ),
                      Text(
                        '您的当前收益',
                        style: TextStyle(
                          fontSize: MyTheme.sz(22),
                        ),
                      ),
                      SizedBox(
                        height: MyTheme.sz(5),
                      ),
                      Text(
                        '${user.income}',
                        style: TextStyle(
                          fontSize: MyTheme.sz(18),
                          color: MyTheme.color,
                        ),
                      ),
                      SizedBox(
                        height: MyTheme.sz(5),
                      ),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: MyTheme.sz(30)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            MyTheme.sz(30),
                          ),
                        ),
                        color: MyTheme.color,
                        onPressed: () {
                          Navigator.pushNamed(context, '/user/cashout');
                        },
                        child: Text(
                          '立即提现',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MyTheme.sz(30),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MyTheme.sz(5),
                ),
                Container(
                  child: Table(
                    columnWidths: {
                      1: FixedColumnWidth(1),
                    },
                    children: <TableRow>[
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(
                              MyTheme.sz(15),
                            ),
                            color: MyTheme.bgColor,
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: '今日注册人数 ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '22',
                                      style: TextStyle(color: MyTheme.color)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyTheme.sz(1),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              MyTheme.sz(15),
                            ),
                            color: MyTheme.bgColor,
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: '今日推广收益 ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '16',
                                      style: TextStyle(color: MyTheme.color)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      TableRow(children: <Widget>[
                        SizedBox(
                          height: MyTheme.sz(1),
                        ),
                        SizedBox(
                          width: MyTheme.sz(1),
                        ),
                        SizedBox(
                          height: MyTheme.sz(1),
                        )
                      ]),
                      TableRow(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(
                              MyTheme.sz(15),
                            ),
                            color: MyTheme.bgColor,
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: '历史注册人数 ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '4',
                                      style: TextStyle(color: MyTheme.color)),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MyTheme.sz(1),
                          ),
                          Container(
                            padding: EdgeInsets.all(
                              MyTheme.sz(15),
                            ),
                            color: MyTheme.bgColor,
                            alignment: Alignment.center,
                            child: Text.rich(
                              TextSpan(
                                text: '历史推广总收益 ',
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '54',
                                      style: TextStyle(color: MyTheme.color)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  color: MyTheme.bgColor,
                  child: Text('账单记录'),
                ),
                Divider(
                  height: 1,
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  color: MyTheme.bgColor,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('收益提现'),
                          Text(
                            '06-05 10:12',
                            style: TextStyle(
                              color: MyTheme.fontColor,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        '-200',
                        style: TextStyle(
                          color: MyTheme.color,
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
    );
  }
}
