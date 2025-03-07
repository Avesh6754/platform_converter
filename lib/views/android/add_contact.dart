import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';

import '../ios/ios_page.dart';

class AddContact extends StatefulWidget {
  const AddContact({super.key});

  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.setAllData();
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                homeController.imagePickerMethod();
              },
              child: Obx(
                () => CircleAvatar(
                  radius: 80,
                  backgroundImage: homeController.contactImage.isEmpty
                      ? const AssetImage('assets/image/1.jpg')
                      : FileImage(File(homeController.contactImage.value))
                          as ImageProvider,
                ),
              ),
            ),
            const SizedBox(height: 20), // ✅ Added spacing
            textMethod(
                controller: homeController.txtName,
                hint: 'Full Name',
                isNumber: false,
                iconData: Icon(Icons.person_2_outlined)),
            textMethod(
                controller: homeController.txtPhone,
                hint: 'Phone Number',
                isNumber: true,
                iconData: Icon(Icons.phone_outlined)),
            textMethod(
                controller: homeController.txtChat,
                hint: 'Chat Conversation',
                isNumber: false,
                iconData: Icon(Icons.chat_outlined)),
            GetBuilder<HomeController>(
              builder: (controller) => Column(
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            controller.datePickerMethod(context);
                          },
                          icon: Icon(Icons.date_range)),
                      (controller.pickDate != null)
                          ? Text(controller.contactDate ?? 'Pick Date')
                          : Text('Pick Date')
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            homeController.timePickerMethod(context);
                          },
                          icon: Icon(Icons.access_time)),
                      (controller.timePick != null)
                          ? Text(controller.contactTime ?? "Pick Time")
                          : Text('Pick Time')
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20), // ✅ Added spacing
            ElevatedButton(
                onPressed: () async {
                  if ((homeController.txtPhone.text.isNotEmpty) &&
                      (homeController.txtChat.text.isNotEmpty) &&
                      (homeController.txtName.text.isNotEmpty)) {
                    print(homeController.contactImage.value);
                    await homeController.addContactData();
                    homeController.setAllData();
                  }
                },
                child: Text('Save')),
          ],
        ),
      ),
    );
  }
}
Padding textMethod(
    {required String hint,
      required TextEditingController controller,
      required bool isNumber,
      required var iconData}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0), // ✅ Spacing
    child: TextField(
      controller: controller,
      keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        prefixIcon: iconData,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        hintStyle: TextStyle(fontWeight: FontWeight.w500),
      ),
    ),
  );
}
