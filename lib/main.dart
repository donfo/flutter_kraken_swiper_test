import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kraken/widget.dart';

import 'components/az_banner/az_banner.dart';
import 'elements/az_banner.dart';

void main() {
  Kraken.defineCustomElement('az-banner', (targetId, nativeEventTarget, elementManager) {
    return AzBannerElement(targetId, nativeEventTarget, elementManager);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage();
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  final list = [
    {"url": "https://img0.baidu.com/it/u=780942188,1793199930&fm=26&fmt=auto", "title": "夜景一"},
    {"url": "https://img1.baidu.com/it/u=703868392,1981536272&fm=26&fmt=auto", "title": "夜景二"}
  ];
  String bundleContent;

  @override
  void initState() {
    super.initState();
    bundleContent = '''
const container = document.createElement("az-banner");
container.setAttribute("list", '${json.encode(list)}');
document.body.appendChild(container);
''';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: index == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Flutter直接使用'),
                AzBanner(
                  list: getAzBannerModelList(list),
                )
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Kraken自定义后使用'),
                Kraken(
                  viewportHeight: MediaQuery.of(context).size.width * 0.45,
                  bundleContent: bundleContent,
                ),
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: index,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            label: 'flutter',
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: 'Kraken',
            icon: Icon(Icons.kayaking),
          )
        ],
        onTap: (int i) {
          index = i;
          setState(() {});
        },
      ),
    );
  }
}
