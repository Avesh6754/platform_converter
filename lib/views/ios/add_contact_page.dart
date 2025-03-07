import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';

import '../ios/ios_page.dart';

class AddContact_Page extends StatefulWidget {
  const AddContact_Page({super.key});

  @override
  State<AddContact_Page> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact_Page> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeController.setAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                onPressed: () {
                  homeController.imagePickerMethod();
                },
                child: Obx(() => ClipOval(
                      child: Container(
                          height: 150,
                          width: 150,
                          decoration: BoxDecoration(
                              color: CupertinoColors.activeBlue,
                              shape: BoxShape.circle),
                          child: homeController.contactImage.isEmpty
                              ? Container(
                                  height: 160,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Icon(
                                    CupertinoIcons.camera,
                                    color: CupertinoColors.white,
                                    size: 40,
                                  ))
                              : Container(
                                  height: 160,
                                  decoration:
                                      BoxDecoration(shape: BoxShape.circle),
                                  child: Image.file(
                                    File(homeController.contactImage.value),
                                    width: 160,
                                    height: 160,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                    )),
              ),
              const SizedBox(height: 20), // ✅ Added spacing
              textMethod(
                  controller: homeController.txtName,
                  hint: 'Full Name',
                  isNumber: false,
                  iconData: Icon(CupertinoIcons.person)),
              textMethod(
                  controller: homeController.txtPhone,
                  hint: 'Phone Number',
                  isNumber: true,
                  iconData: Icon(CupertinoIcons.phone)),
              textMethod(
                controller: homeController.txtChat,
                hint: 'Chat Conversation',
                isNumber: false,
                iconData: Icon(CupertinoIcons.chat_bubble),
              ),
              GetBuilder<HomeController>(
                builder: (controller) => Column(
                  children: [
                    Row(
                      children: [
                        CupertinoButton(
                            onPressed: () {
                              controller.datePickerCupertinoMethod(context);
                            },
                            child: Icon(CupertinoIcons.calendar)),
                        (controller.pickDate != null)
                            ? Text(controller.contactDate ?? 'Pick Date')
                            : Text('Pick Date')
                      ],
                    ),
                    Row(
                      children: [
                        CupertinoButton(
                            onPressed: () {
                              controller.timePickerCupertinoMethod(context);
                            },
                            child: Icon(CupertinoIcons.time)),
                        (controller.cupertinoTime != null)
                            ? Text(controller.contactTime ?? "Pick Time")
                            : Text('Pick Time')
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20), // ✅ Added spacing
              CupertinoButton(
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
    padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 5), // ✅ Spacing
    child: CupertinoTextField(
      prefix: iconData,
      placeholder: hint,
      controller: controller,
      keyboardType: (isNumber) ? TextInputType.number : TextInputType.text,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CupertinoColors.black)
      ),
    ),
  );
}
