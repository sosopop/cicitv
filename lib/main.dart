import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/ui/pages/splashscreen.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/index.dart';

void main() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, //top bar color
    statusBarIconBrightness: Brightness.light, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));

  runApp(
    MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              brightness: Brightness.light, color: Colors.transparent),
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          primaryIconTheme: IconThemeData(color: MyTheme.colorDark),
          primarySwatch: MyTheme.color,
          primaryColor: MyTheme.color),
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Index(),
      },
    ),
  );
}
