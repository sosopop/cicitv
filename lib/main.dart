import 'package:flutter/material.dart';
import 'package:cicitv/ui/index.dart';
import 'package:flutter/services.dart';

void main() async {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //   statusBarColor: Colors.black, // status bar color
  // ));
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(Index());
}
