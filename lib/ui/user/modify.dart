import 'dart:async';
import 'dart:io';

import 'package:cicitv/common/global_controller.dart';
import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/model/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cicitv/common/myimage.dart';
import 'package:image_cropper/image_cropper.dart';

class UserModify extends StatefulWidget {
  @override
  State<UserModify> createState() => new _UserModifyState();
}

class _UserModifyState extends State<UserModify> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final double itemPadding = 10;
  String modifyUserName = "";
  String modifyGender = "";
  String modifyBirth = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyTheme.appBar(context, text: "编辑个人资料"),
      body: StreamBuilder<UserModel>(
        initialData: GlobalController.user.initialData(),
        stream: GlobalController.user.stream,
        builder: (context, snapshot) {
          var user = snapshot.data;
          return Container(
            color: MyTheme.bgColor,
            child: ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    showDialog<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('请选择图像来源'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 0);
                              },
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.photo_album),
                                  SizedBox(
                                    width: MyTheme.sz(10),
                                  ),
                                  const Text('相册'),
                                ],
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, 1);
                              },
                              child: Row(
                                children: <Widget>[
                                  const Icon(Icons.camera),
                                  SizedBox(
                                    width: MyTheme.sz(10),
                                  ),
                                  const Text('相机'),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ).then(
                      (source) {
                        if (source == 0) {
                          return ImagePicker.pickImage(
                              source: ImageSource.gallery);
                        } else if (source == 1) {
                          return ImagePicker.pickImage(
                              source: ImageSource.camera);
                        }
                        throw 0;
                      },
                    ).then(
                      (File file) {
                        if (file == null) throw 0;
                        return ImageCropper.cropImage(
                          sourcePath: file.path,
                          ratioX: 1.0,
                          ratioY: 1.0,
                          maxWidth: 128,
                          maxHeight: 128,
                        );
                      },
                    ).then(
                      (file) {
                        if (file == null) throw 0;
                        //GlobalController.user.modifyAvatar(file.path);
                      },
                    ).catchError((e) {
                      print(e);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: MyTheme.sz(30)),
                    alignment: Alignment.center,
                    height: MyTheme.sz(150),
                    child: Column(
                      children: <Widget>[
                        user.avatar.isNotEmpty
                            ? ClipOval(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  color: Colors.grey,
                                  child: MyImage(user.avatar),
                                ),
                              )
                            : ClipOval(
                                child: Container(
                                  height: 70,
                                  width: 70,
                                  padding: EdgeInsets.all(MyTheme.sz(3)),
                                  color: Colors.grey,
                                  child: Icon(
                                    Icons.person,
                                    color: Colors.white,
                                    size: MyTheme.sz(60),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: MyTheme.sz(5),
                        ),
                        Text("点击更换头像",
                            style: TextStyle(
                                fontSize: MyTheme.sz(12),
                                color: MyTheme.fontColor))
                      ],
                    ),
                  ),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(20),
                      vertical: MyTheme.sz(itemPadding)),
                  onPressed: () async {
                    TextEditingController nameController =
                        TextEditingController();
                    int ret = await showDialog<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('请输入您的昵称'),
                          content: TextField(
                            controller: nameController,
                            decoration:
                                InputDecoration(hintText: '${user.userName}'),
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('确定'),
                              onPressed: () {
                                Navigator.of(context).pop(1);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (ret == 1) {
                      modifyUserName =
                          nameController.value.text ?? modifyUserName;
                      setState(() {});
                    }
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "昵称",
                        ),
                      ),
                      Text(
                        modifyUserName.isNotEmpty
                            ? modifyUserName
                            : user.userName,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: MyTheme.fontColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  indent: MyTheme.sz(10),
                  endIndent: MyTheme.sz(10),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(20),
                      vertical: MyTheme.sz(itemPadding)),
                  onPressed: () async {
                    modifyGender = await showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text('请选择性别'),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '男');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.mars,
                                  ),
                                  SizedBox(
                                    width: MyTheme.sz(10),
                                  ),
                                  const Text('男生'),
                                ],
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                Navigator.pop(context, '女');
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    FontAwesomeIcons.venus,
                                  ),
                                  SizedBox(
                                    width: MyTheme.sz(10),
                                  ),
                                  const Text('女生'),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    );
                    modifyGender = modifyGender ?? "";
                    setState(() {});
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "性别",
                        ),
                      ),
                      Text(
                        modifyGender.isEmpty ? user.gender : modifyGender,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: MyTheme.fontColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  indent: MyTheme.sz(10),
                  endIndent: MyTheme.sz(10),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(20),
                      vertical: MyTheme.sz(itemPadding)),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2030),
                      builder: (BuildContext context, Widget child) {
                        return Theme(
                          data: Theme.of(context),
                          child: child,
                        );
                      },
                    ).then((DateTime date) {
                      if (date != null) {
                        modifyBirth =
                            '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
                        setState(() {});
                      }
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "生日",
                        ),
                      ),
                      Text(
                        modifyBirth.isNotEmpty ? modifyBirth : user.birth,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: MyTheme.fontColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  indent: MyTheme.sz(10),
                  endIndent: MyTheme.sz(10),
                ),
                FlatButton(
                  padding: EdgeInsets.symmetric(
                      horizontal: MyTheme.sz(20),
                      vertical: MyTheme.sz(itemPadding)),
                  onPressed: () {
                    Navigator.pushNamed(context, '/user/modpass');
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          "修改密码",
                        ),
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: MyTheme.fontColor,
                      )
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  indent: MyTheme.sz(10),
                  endIndent: MyTheme.sz(10),
                ),
                SizedBox(
                  height: MyTheme.sz(20),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: MyTheme.sz(5), horizontal: MyTheme.sz(15)),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MyTheme.sz(30))),
                    padding: EdgeInsets.all(MyTheme.sz(8)),
                    onPressed: () async {
                      await showLoadingDialog<void>(
                        context: context,
                        callback: (context) async {
                          GlobalController.user.login();
                          await Future.delayed(Duration(seconds: 2));
                        },
                      );
                      Navigator.pop(context);
                    },
                    color: MyTheme.color,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('提交修改',
                            style: TextStyle(
                                fontSize: MyTheme.sz(18), color: Colors.white))
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                      vertical: MyTheme.sz(5), horizontal: MyTheme.sz(15)),
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(MyTheme.sz(30))),
                    padding: EdgeInsets.all(MyTheme.sz(8)),
                    onPressed: () {
                      GlobalController.user.logout();
                      Navigator.pop(context);
                    },
                    color: MyTheme.bgColor,
                    child: Text('注销登录'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
