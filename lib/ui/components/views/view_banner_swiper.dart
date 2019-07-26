import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cicitv/common/mytheme.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:cicitv/common/myimage.dart';

class ViewBannerSwiper extends StatefulWidget {
  ViewBannerSwiper() {
  }
  @override
  State<ViewBannerSwiper> createState() => _ViewBannerSwiperState();
}

class _ViewBannerSwiperState extends State<ViewBannerSwiper> {
  List<String> _urls = [
    "https://liangcang-material.alicdn.com/prod/upload/5624b16126ac452a9c965d2c9f0a4212.jpg",
    "https://liangcang-material.alicdn.com/prod/upload/8a38f9e25568433db87be7bb03664da9.jpg",
    "https://r1.ykimg.com/050C00005B3A17CFADBA1F1DE80B3B91",
    "https://r1.ykimg.com/050E00005D1C68B8ADA7B27AED016D5E?x-oss-process=image/resize,w_290/interlace,1/quality,Q_80/sharpen,100"
  ];

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
    return Container(
      child: AspectRatio(
      aspectRatio: 2.2,
      child: Swiper(
      autoplay: true,
      itemBuilder: (BuildContext context, int index) {
        return ClipRRect(
          borderRadius:BorderRadius.circular(MyTheme.sz(5)),
          child:  MyImage(_urls[index])
        );
      },
      itemCount: _urls.length,
      viewportFraction: 0.8,
      scale: 0.9,
      pagination: new SwiperPagination(
        margin: new EdgeInsets.all(MyTheme.sz(5.0))
      ),
    ))
    );
  }
}