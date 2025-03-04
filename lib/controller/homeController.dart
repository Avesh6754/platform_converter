import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtChat = TextEditingController();
  DateTime? pickDate;
  TimeOfDay? timePick;
  RxBool switchCondition = false.obs;
  File? contactUserImage;

  void checkCondition(var value) {
    switchCondition.value = false;
  }

  Future<void> datePickerMethod(BuildContext context) async {
    pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.monthsPerYear),
        lastDate: DateTime(2050));
    print("==================$pickDate");
    update();
  }

  Future<void> timePickerMethod(BuildContext context) async {
    timePick =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    update();
  }

  Future<void> imagePickerMethod() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    contactUserImage = File(image!.path);
  }
}
