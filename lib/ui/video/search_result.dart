import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/ui/components/page.dart';
import 'package:flutter/material.dart';

class VideoSearchResult extends StatefulWidget {
  @override
  State<VideoSearchResult> createState() => _VideoSearchResultState();
}

class _VideoSearchResultState extends State<VideoSearchResult>
    with TickerProviderStateMixin {
  TextEditingController _searchTextController;
  int selIndex = 0;

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
    final String searchKey = ModalRoute.of(context).settings.arguments ?? "";
    if (_searchTextController.text?.isEmpty ?? true) {
      _searchTextController.text = searchKey;
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
              value: selIndex,
              onChanged: (v) {
                setState(() {
                  selIndex = v;
                });
              },
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
            onPressed: () {},
          ),
        ],
      ),
      body: IndexedStack(
        index: selIndex,
        children: <Widget>[
          Center(child: MyPage('video')),
          Center(child: MyPage('star')),
        ],
      ),
    );
  }
}
