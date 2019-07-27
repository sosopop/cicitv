import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MeIndex extends StatefulWidget {
  @override
  State<MeIndex> createState() => new _IndexState();
}

class _IndexState extends State<MeIndex> with TickerProviderStateMixin {
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
    return Center(
      child: Text("我的"),
    );
  }
}