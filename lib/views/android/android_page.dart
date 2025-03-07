

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/views/android/add_contact.dart';
import 'package:platform_converter/views/android/call_list.dart';
import 'package:platform_converter/views/android/chatslist.dart';
import 'package:platform_converter/views/android/user_profile.dart';
import 'package:platform_converter/views/ios/ios_page.dart';

class TabBarWithPageView extends StatelessWidget {
  const TabBarWithPageView({super.key,});


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Obx(
              ()=>Switch(value: homeController.isCupertino.value, onChanged: (value) {
                homeController.widgetChange(value);
              },),
            )
          ],
          title: Text('Platform Converter'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person_add_alt),),
              Tab(text: 'Chats',),
              Tab(text: 'Calls',),
              Tab(text: 'Settings',),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            AddContact(),
            ChatsList(),
            CallList(),
            UserProfile(),
          ],
        ),
      ),
    );
  }
}