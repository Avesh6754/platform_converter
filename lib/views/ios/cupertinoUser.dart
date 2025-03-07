import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../controller/profileControler.dart';
import '../android/user_profile.dart';
import 'ios_page.dart';

class CupertinoUser extends StatelessWidget {
   CupertinoUser({super.key});
  final ProfileController profileController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      SizedBox(height: 30,),
      SizedBox(height: 30,),
      SizedBox(height: 30,),
      SizedBox(height: 30,),
      Obx(
            () =>
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CupertinoListTile(leading: Icon(CupertinoIcons.person),
                  title: Text(
                    'Profile', style: TextStyle(fontWeight: FontWeight.bold),),
                  subtitle: Text("Update Profile Data"),
                  trailing: CupertinoSwitch(
                    value: profileController.isUpdate.value,
                    onChanged: (value) =>
                        profileController.profileChange(value),
                  ),),
                (profileController.isUpdate.value)
                    ? Center(
                  child: Column(
                    children: [
                      CupertinoButton(
                        onPressed: () {
                          homeController.imagePickerMethod();
                        },
                        child: Obx(() =>
                            ClipOval(
                              child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      color: CupertinoColors.activeBlue,
                                      shape: BoxShape.circle),
                                  child: homeController.contactImage.isEmpty
                                      ? Container(
                                      height: 160,
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        CupertinoIcons.camera,
                                        color: CupertinoColors.white,
                                        size: 40,
                                      ))
                                      : Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle),
                                    child: Image.file(
                                      File(homeController
                                          .contactImage.value),
                                      width: 160,
                                      height: 160,
                                      fit: BoxFit.cover,
                                    ),
                                  )),
                            )),
                      ),
                      SizedBox(height: 10),
                      CupertinoTextField(

                        controller: profileController.txtName,
                        style: TextStyle(color: CupertinoColors.black),
                        placeholder: 'Name',
                        enabled: profileController.isFilled.value,

                      ),
                      CupertinoTextField(
                        controller: profileController.txtChat,
                        placeholder: 'Bio',
                        enabled: profileController.isFilled.value,
                        style: TextStyle(color: CupertinoColors.black),
                        decoration: BoxDecoration(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CupertinoButton(
                              onPressed: () {
                                if (profileController
                                    .txtName.text.isNotEmpty &&
                                    profileController
                                        .txtChat.text.isNotEmpty) {
                                  profileController.saveData(
                                      profileController.isDark.value,
                                      profileController.txtName.text,
                                      profileController.txtChat.text);
                                  profileController.fixedProfile(
                                      profileController.isFilled.value);
                                }
                              },
                              child: Text("SAVE")),
                          CupertinoButton(
                              onPressed: () {
                                profileController.txtName.clear();
                                profileController.txtChat.clear();
                                profileController.fixedProfile(
                                    profileController.isFilled.value);
                              },
                              child: Text("CLEAR")),
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
            () =>
            CupertinoListTile(leading: Icon(CupertinoIcons.sun_max),
              title: Text(
                'Theme', style: TextStyle(fontWeight: FontWeight.bold),),
              subtitle: Text("Change Theme Data"),
              trailing: CupertinoSwitch(
                value: profileController.isDark.value,
                onChanged: (value) => profileController.themeChange(value),
              ),),
      )
    ]);
  }
}
