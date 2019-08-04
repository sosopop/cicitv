import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cicitv/common/mytheme.dart';

class MyImage extends CachedNetworkImage {
  MyImage(url)
      : super(
          placeholder: (context, url) => DecoratedBox(
            decoration: BoxDecoration(color: MyTheme.holderColor),
          ),
          errorWidget: (context, url, error) {
            return DecoratedBox(
              decoration: BoxDecoration(color: MyTheme.holderColor),
            );
          },
          imageUrl: url,
          fit: BoxFit.cover,
        );
}

/*
Widget MyImage(String url) {
  if (url.startsWith('http'))
    return _MyImage(url);
  else
    Image.file(File(url));

  return Image.network(
    url,
    fit: BoxFit.cover,
  );
}
*/
