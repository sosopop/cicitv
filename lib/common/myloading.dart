import 'dart:ui';

import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

typedef MyLoadingCallback = Future<void> Function(BuildContext context);

Future<T> showLoadingDialog<T>(
    {BuildContext context, String msg = "正在处理中", MyLoadingCallback callback}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    ) {
      callback(context).then((value) {
        Navigator.pop(context, value);
      });
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: SafeArea(
          child: Builder(
            builder: (context) {
              return Material(
                color: Colors.transparent,
                child: Align(
                  alignment: Alignment.center,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        MyTheme.sz(10),
                      ),
                    ),
                    child: Container(
                      color: Colors.black87,
                      height: MyTheme.sz(120),
                      width: MyTheme.sz(120),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SpinKitWave(
                              color: Colors.white,
                              size: MyTheme.sz(50.0),
                            ),
                            SizedBox(
                              height: MyTheme.sz(15),
                            ),
                            Text(
                              msg,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: MyTheme.sz(14),
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
    barrierDismissible: true,
    barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: null,
    transitionDuration: const Duration(milliseconds: 150),
  );
}
