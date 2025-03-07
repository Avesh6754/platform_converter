import 'dart:developer';
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
  DateTime? cupertinoTime;
  RxBool isCupertino=false.obs;

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
    contactDate = "${pickDate!.month}-${pickDate!.day}-${pickDate!.year}";
    print("==================$pickDate");
    update();
  }

  Future<void> datePickerCupertinoMethod(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.date,
          use24hFormat: true,
          showDayOfWeek: true,
          onDateTimeChanged: (value) {
            pickDate = value;
          },
        ),
      ),
    );
    contactDate = "${pickDate!.month} / ${pickDate!.day} / ${pickDate!.year}";
    print("==================$pickDate");
    update();
  }

  Future<void> timePickerCupertinoMethod(BuildContext context) async {
    await showCupertinoModalPopup(
      context: context,
      builder: (context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        color: CupertinoColors.systemBackground.resolveFrom(context),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          mode: CupertinoDatePickerMode.time,
          onDateTimeChanged: (newTime) {
            cupertinoTime = newTime;
          },
        ),
      ),
    );
    contactTime = '${cupertinoTime!.hour}:${cupertinoTime!.minute}';
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

  Future<List<ContactModal>?> fetchData() async {
    final data = await DbHelper.dbHelper.fetchDataFromDatabase();
    contactList.value = data
        .map(
          (e) => ContactModal.fromMap(e),
        )
        .toList();
    return contactList;
  }

  Future<void> addContactData() async {
    ContactModal contact = ContactModal(
        image: contactImage.value,
        name: txtName.text,
        chat: txtChat.text,
        date: contactDate!,
        phone: txtPhone.text,
        time: contactTime!);
    await DbHelper.dbHelper.insertData(contact);
    await fetchData();
  }

  Future<void> updateContactData(ContactModal contact) async {
    contact.name = txtName.text;
    contact.time = TimeOfDay.now().toString();
    contact.date = DateTime.now().toString();
    contact.phone = txtPhone.text;
    contact.image = contactImage.value;
    contact.chat = txtChat.text;

    try {
      await DbHelper.dbHelper.updateData(contact);
      await fetchData();
    } catch (e) {
      log('not update');
    }
  }

  void setAllData() {
    txtName.clear();
    txtChat.clear();
    txtPhone.clear();
    contactTime = "";
    contactDate = "";
    contactImage.value = '';
  }

  Future<void> deleteDataFromList(int id) async {
    try {
      await DbHelper.dbHelper.deleteData(id);
      await fetchData();
    } catch (e) {
      log('not delete');
    }
  }

  void widgetChange(bool value)
  {
    isCupertino.value=value;
  }
}
