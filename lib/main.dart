import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cicitv/ui/pages/splashscreen.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/index.dart';
import 'package:cicitv/ui/user/reg.dart';
import 'package:cicitv/ui/user/login.dart';
import 'package:cicitv/ui/user/forget.dart';
import 'package:cicitv/ui/user/modpass.dart';

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
      locale: const Locale('zh'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CH'),
      ],
      theme: ThemeData(
        appBarTheme: AppBarTheme(
            brightness: Brightness.light, color: Colors.white, elevation: 0),
        primaryTextTheme:
            TextTheme(button: TextStyle(color: MyTheme.fontColor)),
        highlightColor: Color.fromARGB(10, 0, 0, 0),
        splashColor: Color.fromARGB(10, 0, 0, 0),
        primaryIconTheme: IconThemeData(color: MyTheme.colorDark),
        primarySwatch: MyTheme.color,
        primaryColor: MyTheme.color,
        textTheme: TextTheme(button: TextStyle(color: MyTheme.fontColor)),
        snackBarTheme: SnackBarThemeData(backgroundColor: MyTheme.colorDark),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.color, width: 0.5),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.hintColor, width: 0.5),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: MyTheme.hintColor, width: 0.5),
          ),
          hintStyle: TextStyle(
            color: MyTheme.hintColor,
            fontSize: MyTheme.sz(14),
          ),
        ),
      ),
      showPerformanceOverlay: false,
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => Index(),
        '/me/reg': (BuildContext context) => UserReg(),
        '/me/login': (BuildContext context) => UserLogin(),
        '/me/forget': (BuildContext context) => UserForget(),
        '/me/modpass': (BuildContext context) => UserModPass(),
      },
    ),
  );
}
