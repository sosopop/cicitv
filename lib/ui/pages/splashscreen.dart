import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIOverlays([
      SystemUiOverlay.bottom,
    ]);
    lastTime = 4;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (--lastTime <= 0) {
        timer.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  routeToHome() {
    Navigator.pushReplacementNamed(context, '/home');
    SystemChrome.setEnabledSystemUIOverlays(const [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool ret = false;
        if (lastTime <= 0) {
          routeToHome();
        } else {
          ret = true;
          assert(() {
            ret = false;
            routeToHome();
          }());
          return ret;
        }
        return ret;
      },
      child: GestureDetector(
        onTap: () async {
          //Navigator.pushReplacementNamed(context, '/me/modpass');
          //return;
          await launch("https://www.baidu.com");
          routeToHome();
        },
        child: Stack(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                "assets/images/splash.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: MyTheme.sz(10),
              right: MyTheme.sz(10),
              child: GestureDetector(
                onTap: () {
                  if (lastTime <= 0) {
                    routeToHome();
                  }
                },
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.all(Radius.circular(MyTheme.sz(3))),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: MyTheme.sz(10), vertical: MyTheme.sz(5)),
                    color: MyTheme.transBlackIcon,
                    child: Text(
                      lastTime > 0 ? "$lastTime秒" : "关闭",
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: MyTheme.sz(12),
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int lastTime = 0;
}
