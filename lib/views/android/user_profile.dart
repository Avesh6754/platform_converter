import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/profileControler.dart';

var profileController = Get.put(ProfileController());

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Profile",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Obx(
        () => Column(
          children: [
            SwitchListTile(
              title: Text("Change profile"),
              value: profileController.isUpdate.value,
              onChanged: (value) => profileController.profileChange(value),
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
                                      .contactImage.isEmpty
                                  ? const AssetImage('assets/image/1.jpg')
                                  : FileImage(File(
                                          profileController.contactImage.value))
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
      Divider(),
      Text("Theme",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      Obx(
        () => SwitchListTile(
          title: Text("Change Theme"),
          value: profileController.isDark.value,
          onChanged: (value) => profileController.themeChange(value),
        ),
      ),
    ]);
  }
}
