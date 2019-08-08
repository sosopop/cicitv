import 'package:cicitv/common/myloading.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter/material.dart';

class VideoSearch extends StatefulWidget {
  @override
  State<VideoSearch> createState() => _VideoSearchState();
}

class _VideoSearchState extends State<VideoSearch> {
  String searchKey = "";
  TextEditingController _searchTextController;
  List<String> searchRecentKeys = [
    "保时捷车主丈夫停职",
    "b站封禁乔碧萝",
    "任达华拒收赔偿",
    "哪吒票房25亿",
    "91岁打破短跑记录",
  ];

  List<String> searchHotKeys = [
    "保时捷车主丈夫停职",
    "b站封禁乔碧萝",
    "任达华拒收赔偿",
    "哪吒票房25亿",
    "91岁打破短跑记录",
  ];

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> recentWrap = [];
    List<Widget> hotWrap = [];
    for (String recentKey in searchRecentKeys) {
      recentWrap.add(
        GestureDetector(
          onTap: () {
            _searchTextController.text = recentKey;
          },
          child: Chip(
            label: Text(recentKey),
            deleteIcon: Icon(
              Icons.clear,
              size: MyTheme.sz(12),
            ),
            onDeleted: () {
              setState(() {
                searchRecentKeys.remove(recentKey);
              });
            },
          ),
        ),
      );
    }
    for (String hotKey in searchHotKeys) {
      hotWrap.add(
        ActionChip(
          onPressed: () {
            _searchTextController.text = hotKey;
          },
          backgroundColor: MyTheme.color,
          label: Text(
            hotKey,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: TextField(
          controller: _searchTextController,
          decoration: InputDecoration(
            hintText: '输入要搜索的影片或影星',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            border: InputBorder.none,
          ),
        ),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            child: DropdownButton<int>(
              isDense: true,
              underline: Container(),
              value: 0,
              onChanged: (v) {},
              items: [
                DropdownMenuItem(
                  child: Text('视频'),
                  value: 0,
                ),
                DropdownMenuItem(
                  child: Text('影星'),
                  value: 1,
                )
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              await showLoadingDialog<void>(
                context: context,
                callback: (context) async {
                  await Future.delayed(Duration(seconds: 2));
                },
              );
              Navigator.pushReplacementNamed(context, '/video/search_result',
                  arguments: _searchTextController.text);
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.only(
            top: MyTheme.sz(10),
            left: MyTheme.sz(20),
            right: MyTheme.sz(20),
          ),
          children: <Widget>[
            SizedBox(
              height: MyTheme.sz(10),
            ),
            Row(
              children: <Widget>[
                Text('最近的搜索记录'),
                Spacer(
                  flex: 1,
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  color: MyTheme.fontColor,
                  onPressed: () async {
                    int ret = await showDialog<int>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('提示'),
                          content: Text('是否清空搜索记录？'),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('否'),
                              onPressed: () {
                                Navigator.of(context).pop(0);
                              },
                            ),
                            FlatButton(
                              child: Text('是'),
                              onPressed: () {
                                Navigator.of(context).pop(1);
                              },
                            ),
                          ],
                        );
                      },
                    );
                    if (ret == 1) {
                      searchRecentKeys.clear();
                      setState(() {});
                    }
                  },
                ),
              ],
            ),
            SizedBox(
              height: MyTheme.sz(10),
            ),
            Wrap(
              spacing: MyTheme.sz(10),
              children: recentWrap,
            ),
            Divider(),
            SizedBox(
              height: MyTheme.sz(10),
            ),
            Text('推荐的搜索'),
            SizedBox(
              height: MyTheme.sz(10),
            ),
            Wrap(
              spacing: MyTheme.sz(10),
              children: hotWrap,
            ),
          ],
        ),
      ),
    );
  }
}
