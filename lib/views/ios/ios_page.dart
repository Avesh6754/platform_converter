import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';
import 'package:platform_converter/views/ios/add_contact_page.dart';
import 'package:platform_converter/views/ios/cupertinoCalling.dart';
import 'package:platform_converter/views/ios/cupertinoUser.dart';
import 'package:platform_converter/views/ios/cupertino_chat.dart';

import '../android/user_profile.dart';

var homeController = Get.put(HomeController());

class HomeScreen extends StatefulWidget {


  const HomeScreen({super.key, });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    profileController.getData();
  }
  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
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
            switch (index) {
              case 0:
                return CupertinoPageScaffold(
                  resizeToAvoidBottomInset: true,
                  navigationBar: CupertinoNavigationBar(
                    trailing: Obx(() => CupertinoSwitch(value: homeController.isCupertino.value, onChanged: (value) {
                        homeController.widgetChange(value);
                      },),
                    ),
                    middle: Text('PlateForm Converter'),
                  ),
                  child: AddContact_Page(),
                );
              case 1:
                return CupertinoPageScaffold(
                  resizeToAvoidBottomInset: true,
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('PlateForm Converter'),
                    trailing: Obx(() => CupertinoSwitch(value: homeController.isCupertino.value, onChanged: (value) {
                      homeController.widgetChange(value);
                    },),
                    ),
                  ),
                  child: CupertinoChat(),
                );
              case 2:
                return CupertinoPageScaffold(
                  resizeToAvoidBottomInset: true,
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('PlateForm Converter'),
                    trailing: Obx(() => CupertinoSwitch(value: homeController.isCupertino.value, onChanged: (value) {
                      homeController.widgetChange(value);
                    },),
                    ),
                  ),
                  child: CupertinoCalling(),
                );
              default:
                return CupertinoPageScaffold(
                  resizeToAvoidBottomInset: true,
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('PlateForm Converter'),
                    trailing: Obx(() => CupertinoSwitch(value: homeController.isCupertino.value, onChanged: (value) {
                      homeController.widgetChange(value);
                    },),
                    ),
                  ),
                  child: CupertinoUser(),
                );
            }
          },
        );
      },
    );
  }
}
