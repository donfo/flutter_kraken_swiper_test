import 'dart:convert';
import 'dart:ffi';

import 'package:flutter_kraken_swiper_test/components/az_banner/az_banner.dart';
import 'package:kraken/dom.dart';
import 'package:kraken/kraken.dart';
import 'package:kraken/widget.dart';
import 'package:flutter/material.dart';

class AzBannerElement extends WidgetElement {
  AzBannerElement(int targetId, Pointer<NativeEventTarget> nativeEventTarget, ElementManager elementManager)
      : super(targetId, nativeEventTarget, elementManager);

  @override
  Widget build(BuildContext context, Map<String, dynamic> properties) {
    List<AzBannerModel> list = properties['list'] != null ? getAzBannerModelList(json.decode(properties['list'])) : [];
    print(properties['list']);
    return AzBanner(
      list: list,
    );
  }
}
