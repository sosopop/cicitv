import 'package:flutter/material.dart';
import 'dart:ui';

class MyTheme {
  //按屏幕尺寸计算大小
  static double sz(double size) {
    return size;
  }

  static Icon backIcon() {
    return Icon(Icons.arrow_back_ios);
  }

  static AppBar appBar(context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios),
      ),
    );
  }

  static Color colorDark = Color.fromARGB(255, 96, 96, 96);
  static Color color = Colors.pink;
  static Color colorDeep = Colors.pink[700];
  static Color accentColor = Colors.pinkAccent;
  static Color bgColor = Colors.white;
  static Color fontColor = Color.fromARGB(255, 96, 96, 96);
  static Color fontDeepColor = Color.fromARGB(255, 32, 32, 32);
  static Color holderColor = Colors.grey[200];
  static Color tagColor = Colors.orange;
  static Color revFontColor = Colors.white;
  static Color transBlackIcon = Color.fromARGB(128, 0, 0, 0);
  static Color transWhiteIcon = Color.fromARGB(128, 255, 255, 255);
}
