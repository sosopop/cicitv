import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:cicitv/common/myimage.dart';
//import 'package:chewie/chewie.dart';
//import 'package:flutter_ijkplayer/flutter_ijkplayer.dart';
import 'package:cicitv/ui/components/views/view_video_player.dart';

class ViewVideoShowItem extends StatelessWidget {
  final String picUrl;
  final String adUrl;
  final String videoUrl;
  final String title;
  final String targetUrl;
  final int playCount;
  ViewVideoShowItem(
      {key,
      this.picUrl,
      this.adUrl,
      this.videoUrl,
      this.title,
      this.targetUrl,
      this.playCount})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[_buildVideoView(), _buildBottom()],
    );
  }

  Widget _buildVideoView() {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ViewVideoPlayer(
        adUrl: adUrl,
        videoUrl: videoUrl,
        coverBuilder: _buildCover,
      ),
    );
  }

  Widget _buildBottom() {
    return FlatButton(
      onPressed: () {},
      padding: EdgeInsets.all(MyTheme.sz(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: TextStyle(fontSize: MyTheme.sz(16)),
              maxLines: 1,
            ),
          ),
          Icon(Icons.visibility, color: MyTheme.fontColor),
          SizedBox(
            width: MyTheme.sz(5),
          ),
          Text(
            "1001",
            style:
                TextStyle(color: MyTheme.fontColor, fontSize: MyTheme.sz(12)),
          ),
          SizedBox(
            width: MyTheme.sz(7),
          ),
          Icon(Icons.chat_bubble_outline, color: MyTheme.fontColor),
          SizedBox(
            width: MyTheme.sz(5),
          ),
          Text(
            "97",
            style:
                TextStyle(color: MyTheme.fontColor, fontSize: MyTheme.sz(12)),
          )
        ],
      ),
    );
  }

  Widget _buildCover() {
    return Stack(
      children: <Widget>[
        AspectRatio(
          child: MyImage(picUrl),
          aspectRatio: 16 / 9,
        ),
        Positioned(
          top: 0,
          right: MyTheme.sz(20),
          child: ClipRRect(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(MyTheme.sz(3))),
            child: Container(
              padding: EdgeInsets.all(MyTheme.sz(3)),
              color: MyTheme.tagColor,
              child: Text(
                "100钻石",
                style: TextStyle(
                    fontSize: MyTheme.sz(10), color: MyTheme.revFontColor),
              ),
            ),
          ),
        ),
        AspectRatio(
          child: Center(
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(10),
                child: Icon(
                  Icons.play_arrow,
                  size: MyTheme.sz(40),
                  color: Colors.black54,
                ),
                color: Colors.white60,
              ),
            ),
          ),
          aspectRatio: 16 / 9,
        )
      ],
    );
  }
}
