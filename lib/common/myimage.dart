import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cicitv/common/mytheme.dart';

class MyImage extends CachedNetworkImage {
  MyImage(url):super(
    placeholder: (context, url) => DecoratedBox(
      decoration: BoxDecoration(
        color: MyTheme.holderColor
      ),
    ),
    imageUrl:url,
    fit: BoxFit.cover);
}
