import 'package:flutter/material.dart';
import 'dart:ui';

class MyTheme {
  //按屏幕尺寸计算大小
  static double sz(double size) {
    return size;
  }

  static Color colorDark = Colors.black54;
  static Color color = Colors.pink;
  static Color colorDeep = Colors.pink[700];
  static Color accentColor = Colors.pinkAccent;
  static Color bgColor = Colors.white;
  static Color fontColor = Colors.black54;
  static Color fontDeepColor = Colors.black87;
  static Color holderColor = Colors.grey[200];
  static Color tagColor = Colors.orange;
  static Color revFontColor = Colors.white;
  static Color transBlackIcon = Color.fromARGB(128, 0, 0, 0);
  static Color transWhiteIcon = Color.fromARGB(128, 255, 255, 255);
}
