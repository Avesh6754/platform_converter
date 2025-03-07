import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController{
  var txtName = TextEditingController();
  var txtChat = TextEditingController();
  RxString contactImage = ''.obs;
  RxBool isDark=false.obs;
  RxBool isUpdate=false.obs;
  RxBool isFilled=true.obs;
  Future<void> imagePickerMethod() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    final File contactUserImage = File(image!.path);
    contactImage.value = contactUserImage.path;
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
}