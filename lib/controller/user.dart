import 'dart:async';
import 'package:cicitv/model/user.dart';

class UserController {
  final controller = StreamController<UserModel>.broadcast();
  get sink => controller.sink;
  get stream => controller.stream;

  dispose() {
    controller.close();
  }

  UserModel _lastData = UserModel();

  UserModel initialData() {
    return _lastData;
  }

  add(UserModel userModel) {
    _lastData = userModel;
    sink.add(_lastData);
  }

  login() async {
    //这里先进行网络调用
    add(
      UserModel(
        userId: "2313123131",
        userName: "吴亦凡",
        avatar: "https://g2.ykimg.com/051400005C2732E9ADA7B2194206B4B5",
        phone: "12300000000",
        vip: true,
        vipEndTime: "2019-08-11 22:11",
        balance: 20,
        income: 22,
        viewTimes: 1,
        totalViewTimes: 3,
      ),
    );
  }
}
