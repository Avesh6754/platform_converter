import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../modal/contact_modal.dart';
import '../android/add_contact.dart';
import 'add_contact_page.dart';
import 'ios_page.dart';

class CupertinoCalling extends StatelessWidget {
  const CupertinoCalling({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: homeController.fetchData(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CupertinoActivityIndicator(),
          );
        }
        List<ContactModal> contact = snapshot.data!;
        return ListView.builder(
          itemCount: contact.length,
          itemBuilder: (context, index) {
            return CupertinoListTile(
              onTap: () {
                showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return CupertinoActionSheet(
                      title: Column(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 160,
                            decoration:
                            BoxDecoration(shape: BoxShape.circle),
                            child: Image.file(
                              File(contact[index].image),
                              width: 160,
                              height: 160,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Text(
                            contact[index].name,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20),
                          ),
                          Text(
                            contact[index].chat,
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 17),
                          ),
                          Text(
                            contact[index].time,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CupertinoButton(
                                  onPressed: () {
                                    // Set the values before showing the dialog
                                    homeController.contactImage.value = contact[index].image;
                                    homeController.txtName = TextEditingController(text: contact[index].name);
                                    homeController.txtChat = TextEditingController(text: contact[index].chat);
                                    homeController.txtPhone = TextEditingController(text: contact[index].phone);
                                    homeController.contactTime = contact[index].time;

                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text("Add Task"),
                                          content: Column(
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
                                                        ? Icon(
                                                      CupertinoIcons.camera,
                                                      color: CupertinoColors.white,
                                                      size: 40,
                                                    )
                                                        : Image.file(
                                                      File(homeController.contactImage.value),
                                                      width: 160,
                                                      height: 160,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                )),
                                              ),
                                              const SizedBox(height: 20),
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
                                                  iconData: Icon(CupertinoIcons.chat_bubble)),
                                            ],
                                          ),
                                          actions: [
                                            CupertinoButton(
                                                onPressed: () {
                                                  homeController.setAllData();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Cancel')),
                                            CupertinoButton(
                                                onPressed: () {
                                                  homeController.updateContactData(contact[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Update')),
                                          ],
                                        );
                                      },
                                    );
                                  },


                                  child: Icon(CupertinoIcons.pen)),

                              CupertinoButton(
                                  onPressed: () {
                                    homeController
                                        .deleteDataFromList(contact[index].id!);
                                    contact.removeAt(index);
                                    Navigator.of(context).pop();
                                  },
                                  child: Icon(CupertinoIcons.delete))
                            ],
                          )
                        ],
                      ),
                      actions: [
                        CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              leading: Container(
                height: 160,
                decoration:
                BoxDecoration(shape: BoxShape.circle),
                child: Image.file(
                  File(contact[index].image),
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                contact[index].name,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                contact[index].chat,
                style: TextStyle(),
              ),
              trailing: Text(
                contact[index].time,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            );
          },
        );
      },
    );
  }
}
