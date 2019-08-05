import 'package:fluttertoast/fluttertoast.dart';

class MyToast {
  MyToast(String msg) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: msg,
    );
  }
}
