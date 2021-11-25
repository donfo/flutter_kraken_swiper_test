import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import 'package:cached_network_image/cached_network_image.dart';

// 图片
class AzImage extends StatelessWidget {
  AzImage(
    this.url, {
    this.height,
    this.width,
    this.margin,
    this.round = false,
    this.radius,
    this.fit,
    this.borderWidth,
    this.borderColor,
    this.loding,
    this.error,
    this.preview,
  });

  String url;
  double width;
  double height;
  EdgeInsets margin;
  bool round;
  double radius;
  BoxFit fit;
  double borderWidth;
  Color borderColor;
  String loding;
  String error;
  bool preview;

  @override
  Widget build(BuildContext context) {
    margin = margin ?? EdgeInsets.all(0);
    fit = fit ?? BoxFit.cover;
    borderWidth = borderWidth ?? 0;
    borderColor = borderColor ?? Colors.white;
    loding = loding ?? '';
    error = error ?? 'https://lxq.nmgdj.gov.cn/oss/nmlxq/app/default-avatar/default-image.png';
    preview = preview ?? false;

    if (round) {
      radius = height / 2;
    } else {
      radius = radius ?? 0;
    }

    if (borderWidth == 0) {
      borderColor = Colors.transparent;
    }

    Widget imageWidget = Container(color: Colors.black54);
    if (url != null && url.startsWith('http')) {
      imageWidget = CachedNetworkImage(
        width: width,
        height: height,
        fit: fit,
        imageUrl: url,
        placeholder: (context, url) => Container(color: Colors.black12),
        errorWidget: (context, url, _) {
          return CachedNetworkImage(imageUrl: error);
        },
        fadeOutDuration: Duration(milliseconds: 0),
        fadeInDuration: Duration(milliseconds: 0),
      );
    } else if (url.contains(';base64,')) {
      imageWidget = Image.memory(convert.base64.decode(url.split(',')[1]), width: width, height: height, fit: fit, gaplessPlayback: true);
    } else if (url != null) {
      imageWidget = Image.asset(url, width: width, height: height, fit: fit);
    }

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        border: Border.all(color: borderColor, width: borderWidth),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: imageWidget,
      ),
    );
  }
}
