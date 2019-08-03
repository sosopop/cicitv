import 'package:cicitv/common/myimage.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeRegister extends StatefulWidget {
  @override
  State<MeRegister> createState() => new _MeRegisterState();
}

class _MeRegisterState extends State<MeRegister> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.appBar(context),
      body: Container(
        child: ListView(
          children: <Widget>[],
        ),
      ),
    );
  }
}
