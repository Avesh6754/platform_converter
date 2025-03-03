import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_converter/views/android/android_page.dart';
import 'package:platform_converter/views/ios/ios_page.dart';

void main() {
  runApp(MyIosApp());
}

class MyIosApp extends StatefulWidget {
  const MyIosApp({super.key});

  @override
  State<MyIosApp> createState() => _MyIosAppState();
}

class _MyIosAppState extends State<MyIosApp> {
  var isMaterial = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TabBarWithPageView(toggleApp: toggleApp),
    );
    //     : CupertinoApp(
    //   debugShowCheckedModeBanner: false,
    //   home: HomeScreen(toggleApp: toggleApp),
    // );
  }

  void toggleApp() {
    setState(() {
      isMaterial = !isMaterial;
    });
  }
}

