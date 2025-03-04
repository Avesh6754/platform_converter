import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter/modal/contact_modal.dart';
import 'package:platform_converter/services/dbhelper.dart';

class HomeController extends GetxController {
  var txtName = TextEditingController();
  var txtPhone = TextEditingController();
  var txtChat = TextEditingController();

  RxList<ContactModal> contactList = <ContactModal>[].obs;
  DateTime? pickDate;
  TimeOfDay? timePick;
  RxBool switchCondition = false.obs;

  RxString contactImage = ''.obs;
  String? contactDate;
  String? contactTime;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    DbHelper.dbHelper.database;
  }

  void checkCondition(var value) {
    switchCondition.value = false;
  }

  Future<void> datePickerMethod(BuildContext context) async {
    pickDate = await showDatePicker(
        context: context,
        firstDate: DateTime(DateTime.monthsPerYear),
        lastDate: DateTime(2050));
    contactDate = pickDate!.toIso8601String();
    print("==================$pickDate");
    update();
  }

  Future<void> timePickerMethod(BuildContext context) async {
    timePick =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    contactTime = timePick.toString();

    update();
  }

  Future<void> imagePickerMethod() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    final File contactUserImage = File(image!.path);
    contactImage.value = contactUserImage.path;
  }

  Future<void> fetchData() async {
    final data = await DbHelper.dbHelper.fetchData();
    contactList.value = data
        .map(
          (e) => ContactModal.fromMap(e),
        )
        .toList();
  }

  Future<void> addContactData() async {
    ContactModal contact = ContactModal(
        image: contactImage.value,
        name: txtName.text,
        chat: txtChat.text,
        date: pickDate!.toIso8601String(),
        phone: txtPhone.text,
        time: timePick.toString());
    await DbHelper.dbHelper.insertData(contact);
    await fetchData();

  }

  Future<void> updateContactData(contact) async {
    await DbHelper.dbHelper.insertData(contact);
    await fetchData();
  }

  void setAllData() {
    txtName.clear();
    txtChat.clear();
    txtPhone.clear();
    contactTime=null;
    contactDate=null;
    contactImage.value='https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png';
  }
}
