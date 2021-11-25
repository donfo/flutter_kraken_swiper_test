
import 'dart:ui';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kraken_swiper_test/components/az_image/az_image.dart';
import 'az_banner_model.dart';
export 'az_banner_model.dart';

// 轮播图

class AzBanner extends StatelessWidget {
  AzBanner({
    this.list,
    this.child,
    this.customBanner,
    this.width,
    this.height,
    this.margin,
    this.autoplay,
    this.duration,
    this.autoplayDelay,
    this.showTitle,
    this.onTap,
    this.showPagination,
    this.radius,
    this.controller,
    this.onIndexChanged,
  });

  List<AzBannerModel> list;
  final List<Widget> customBanner;
  final Widget child;
  EdgeInsets margin;
  double width;
  double height;
  bool autoplay;
  int duration;
  int autoplayDelay;
  bool showTitle;
  final Function onTap;
  int customBannerLength;
  final Function onIndexChanged;
  bool showPagination;
  double radius;
  SwiperController controller;

  @override
  Widget build(BuildContext context) {
    //判断值
    margin = margin ?? EdgeInsets.fromLTRB(15, 0, 15, 0);
    width = width ?? window.physicalSize.width / window.devicePixelRatio;
    radius = radius ?? 5;
    height = height ?? width * 0.45;
    showPagination = showPagination ?? true;
    autoplay = autoplay ?? true;
    showTitle = showTitle ?? false;
    duration = duration ?? 1000;
    autoplayDelay = autoplayDelay ?? 3000;
    customBannerLength = customBanner == null ? 0 : customBanner.length;
    return ConstrainedBox(
      constraints: BoxConstraints.loose(Size(width, height)),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: _buildSwiper(),
      ),
    );
  }

  //轮播图
  Widget _buildSwiper() {
    return Swiper(
      controller: controller,
      autoplay: autoplay,
      duration: duration,
      autoplayDelay: autoplayDelay,
      onTap: (index) {
        final bannerIndex = index - customBannerLength;
        if (onTap != null) {
          onTap(bannerIndex);
        } else if (list[bannerIndex].link.isNotEmpty) {
        }
      },
      onIndexChanged: onIndexChanged,
      itemBuilder: (context, index) {
        if (index < customBannerLength) {
          return customBanner[index];
        } else {
          return _buildBottomTextBanner(index - customBannerLength);
        }
      },
      itemCount: customBannerLength + list.length,
      viewportFraction: 1,
      scale: 0.9,
      pagination: SwiperPagination(
        alignment: showTitle ? Alignment.bottomRight : Alignment.bottomCenter,
        margin: EdgeInsets.only(bottom: 5, right: 23),
        builder: DotSwiperPaginationBuilder(
          color: showPagination ? Color(0x66ffffff) : Colors.transparent,
          activeColor: showPagination ? Color(0xffffffff) : Colors.transparent,
          space: 2.5,
          size: 5,
          activeSize: 6,
        ),
      ),
    );
  }

  //图片
  Widget _buildBottomTextBanner(index) {
    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
      child: Stack(
        children: <Widget>[
          AzImage(
            list[index].url,
            fit: BoxFit.cover,
            width: width,
            height: height,
            radius: radius,
          ),
          showTitle && list[index].title != ''
              ? Positioned(
                  bottom: 0.0,
                  child: Container(
                    width: width - 30,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 12,
                      top: 15,
                    ),
                    child: Text(
                      list[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5),
                        bottomLeft: Radius.circular(5),
                      ),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0x00000000), Color(0x66000000)],
                      ),
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
