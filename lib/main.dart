import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cicitv/ui/pages/splashscreen.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/index.dart';
import 'package:cicitv/ui/me/reg.dart';
import 'package:cicitv/ui/me/login.dart';

void main() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, //top bar color
    statusBarIconBrightness: Brightness.light, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.light, //bottom bar icons
  ));

  runApp(
    MaterialApp(
      home: SplashScreen(),
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              brightness: Brightness.light, color: Colors.white, elevation: 0),
          highlightColor: Color.fromARGB(10, 0, 0, 0),
          splashColor: Color.fromARGB(10, 0, 0, 0),
          primaryIconTheme: IconThemeData(color: MyTheme.colorDark),
          primarySwatch: MyTheme.color,
          primaryColor: MyTheme.color,
          snackBarTheme: SnackBarThemeData(backgroundColor: MyTheme.colorDark)),
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Index(),
        '/me/reg': (BuildContext context) => MeRegister(),
        '/me/login': (BuildContext context) => MeLogin(),
      },
    ),
  );
}
