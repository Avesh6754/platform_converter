

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';
var homeController=Get.put(HomeController());
class HomeScreen extends StatelessWidget {
  final VoidCallback toggleApp;

  const HomeScreen({super.key, required this.toggleApp});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      resizeToAvoidBottomInset: false,
      tabBar: CupertinoTabBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person_add_solid),
            label: 'Add Person',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.chat_bubble_2),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.phone),
            label: 'Call',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.settings_solid),
            label: 'Setting',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            return CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                automaticBackgroundVisibility: false,
                middle: Text(
                  'Platform Converter',
                  style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                ),
              ),
              child: SafeArea(
                child: Center(
                  child: CupertinoButton(
                    child: Text("Index of ${index + 1}"),
                    onPressed: () {
                      toggleApp();
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}