import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/profileControler.dart';

var profileController = Get.put(ProfileController());

class UserProfile extends StatelessWidget {
  UserProfile({super.key});
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Obx(
        () => Column(
          children: [
            ListTile(
              
              title: Text("Profile"),
              leading: Icon(Icons.person),
              subtitle: Text('Update profile'),
              trailing: Switch(value: profileController.isUpdate.value,
                onChanged: (value) => profileController.profileChange(value),),
            ),
            (profileController.isUpdate.value)
                ? Center(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            profileController.imagePickerMethod();
                          },
                          child: Obx(
                            () => CircleAvatar(
                              radius: 80,
                              backgroundImage: profileController
                                      .userImage.value.isEmpty
                                  ? const AssetImage('assets/image/1.jpg')
                                  : FileImage(File(
                                          profileController.userImage.value))
                                      as ImageProvider,
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextField(
                          controller: profileController.txtName,
                          decoration: InputDecoration(
                              hintText: "Enter your name",
                              enabled: profileController.isFilled.value),
                        ),
                        TextField(
                          controller: profileController.txtChat,
                          decoration: InputDecoration(
                              hintText: "Enter your Bio",
                              enabled: profileController.isFilled.value),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                                onPressed: () {
                                  if (profileController
                                      .txtName.text.isNotEmpty && profileController
                                      .txtChat.text.isNotEmpty) {
                                    profileController.fixedProfile(profileController.isFilled.value);
                                  }
                                },
                                child: Text("SAVE")),
                            TextButton(onPressed: () {

                              profileController.txtName.clear();
                              profileController.txtChat.clear();
                              profileController.fixedProfile(profileController.isFilled.value);
                            }, child: Text("CLEAR")),
                          ],
                        ),
                      ],
                    ),
                  )
                : SizedBox(),
          ],
        ),
      ),
      Obx(
        () => ListTile(
          title: Text("Theme"),
          leading: Icon(Icons.sunny),
          subtitle: Text('Update Theme'),
         trailing: Switch( value: profileController.isDark.value,
           onChanged: (value) => profileController.themeChange(value),),
        ),
      ),
    ]);
  }
}
