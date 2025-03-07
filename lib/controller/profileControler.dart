import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController{
  var txtName = TextEditingController();
  var txtChat = TextEditingController();
  RxString userImage = ''.obs;
  RxBool isDark=false.obs;
  RxBool isUpdate=false.obs;
  RxBool isFilled=true.obs;
  Future<void> imagePickerMethod() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    final File contactUserImage = File(image!.path);
    userImage.value = contactUserImage.path;
  }
  void themeChange(var value)
  {
    isDark.value=value;
  }
  void profileChange(var value)
  {
    isUpdate.value=value;
  }
  void fixedProfile(var value)
  {
    isFilled.value=!value;
  }

  Future<void> saveData(bool Dark,String name,String chat)
  async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    await sharedPreferences.setBool('dark', Dark);
    await sharedPreferences.setString('name', name);
    await sharedPreferences.setString('chat',chat);
  }
  Future<void> getData()
  async {
    SharedPreferences sharedPreferences =await SharedPreferences.getInstance();
    isDark.value=sharedPreferences.getBool('dark')??false;
    txtName.text=sharedPreferences.getString('name')??"";
    txtChat.text=sharedPreferences.getString('chat')??"";
  }
}