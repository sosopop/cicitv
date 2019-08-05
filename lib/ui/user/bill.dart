import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BillModel {
  BillModel({this.type = "", this.time = "", this.money = ""});
  String type;
  String time;
  String money;
}

class BillRecord extends StatelessWidget {
  final BillModel model;

  BillRecord(this.model);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: Colors.grey[200],
          ),
        ),
      ),
      padding: EdgeInsets.symmetric(
        vertical: MyTheme.sz(10),
        horizontal: MyTheme.sz(20),
      ),
      child: Row(
        children: <Widget>[
          Text(
            model.type,
            style: TextStyle(fontSize: MyTheme.sz(16)),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(
                  model.money,
                  style: TextStyle(
                    color: MyTheme.fontColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  model.time,
                  style: TextStyle(
                    fontSize: MyTheme.sz(14),
                    color: MyTheme.fontLightColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class UserBill extends StatefulWidget {
  @override
  State<UserBill> createState() => new _UserBillState();
}

class _UserBillState extends State<UserBill> {
  List<BillModel> bills = <BillModel>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    bills
      ..add(BillModel(
        type: "VIP购买",
        time: "2019-05-02 11:22",
        money: "-1000",
      ))
      ..add(BillModel(
        type: "卡密充值",
        time: "2019-04-12 11:22",
        money: "+2000",
      ))
      ..add(BillModel(
        type: "在线观影",
        time: "2019-04-02 11:22",
        money: "-5",
      ))
      ..add(BillModel(
        type: "VIP购买",
        time: "2019-05-02 11:22",
        money: "-1000",
      ))
      ..add(BillModel(
        type: "卡密充值",
        time: "2019-04-12 11:22",
        money: "+2000",
      ))
      ..add(BillModel(
        type: "在线观影",
        time: "2019-04-02 11:22",
        money: "-5",
      ))
      ..add(BillModel(
        type: "VIP购买",
        time: "2019-05-02 11:22",
        money: "-1000",
      ))
      ..add(BillModel(
        type: "卡密充值",
        time: "2019-04-12 11:22",
        money: "+2000",
      ))
      ..add(BillModel(
        type: "在线观影",
        time: "2019-04-02 11:22",
        money: "-5",
      ))
      ..add(BillModel(
        type: "VIP购买",
        time: "2019-05-02 11:22",
        money: "-1000",
      ))
      ..add(BillModel(
        type: "卡密充值",
        time: "2019-04-12 11:22",
        money: "+2000",
      ))
      ..add(BillModel(
        type: "在线观影",
        time: "2019-04-02 11:22",
        money: "-5",
      ));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.appBar(context, text: "消费充值记录"),
      body: Container(
        color: MyTheme.bgColor,
        child: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: true,
          onRefresh: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              _refreshController.resetNoData();
              _refreshController.refreshCompleted();
            });
          },
          onLoading: () async {
            return Future<void>.delayed(Duration(seconds: 1)).then((_) {
              //_refreshController.loadComplete();
              _refreshController.loadNoData();
            });
          },
          header: MaterialClassicHeader(),
          footer: CustomFooter(
            builder: (BuildContext context, LoadStatus mode) {
              Widget body;
              if (mode == LoadStatus.idle) {
                body = Text("上拉加载更多");
              } else if (mode == LoadStatus.loading) {
                body = CupertinoActivityIndicator();
              } else if (mode == LoadStatus.failed) {
                body = Text("加载失败,点击重试");
              } else {
                body = Text("这是我的底线");
              }
              return Container(
                height: 55.0,
                child: Center(child: body),
              );
            },
          ),
          child: ListView.builder(
            itemCount: bills.length,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return BillRecord(bills[index]);
            },
          ),
        ),
      ),
    );
  }
}
