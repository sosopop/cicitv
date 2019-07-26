import 'package:flutter/material.dart';
import 'package:cicitv/ui/index.dart';
import 'package:flutter/services.dart';

void main() {
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]); 
  runApp(Index());
}