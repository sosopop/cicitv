import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/ui/index.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/splash.jpg", fit: BoxFit.cover);
  }
}
