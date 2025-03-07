import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/views/android/android_page.dart';
import 'package:platform_converter/views/android/user_profile.dart';
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
    return Obx(
      () => (homeController.isCupertino.value)?MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: profileController.isDark.value ? ThemeMode.dark : ThemeMode.light,
          home: TabBarWithPageView(),
        ):Obx(
        () => CupertinoApp(
            theme: CupertinoThemeData(
            brightness: profileController.isDark.value ? Brightness.dark : Brightness.light,
            primaryColor: CupertinoDynamicColor.withBrightness(
            color: CupertinoColors.systemBlue,
            darkColor: CupertinoColors.activeBlue,
                ),scaffoldBackgroundColor: CupertinoDynamicColor.withBrightness(
              color: CupertinoColors.systemGroupedBackground,
              darkColor: CupertinoColors.black,
            ),),
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
                ),
        ),
    );
  }

  void toggleApp() {
    setState(() {
      isMaterial = !isMaterial;
    });
  }
}

