
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../modal/contact_modal.dart';
import '../ios/ios_page.dart';
import 'add_contact.dart';

class ChatsList extends StatelessWidget {
  const ChatsList({super.key});

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
            child: CircularProgressIndicator(),
          );
        }
        List<ContactModal> contact = snapshot.data!;
        return ListView.builder(
          itemCount: contact.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      width: double.infinity,
                      child: Column(
                        spacing: 10,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 20,
                          ),
                          CircleAvatar(
                            backgroundImage:
                            FileImage(File(contact[index].image))
                            as ImageProvider,
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
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        homeController.contactImage.value =
                                            contact[index].image;
                                        homeController.txtName =
                                            TextEditingController(
                                                text: contact[index].name);
                                        homeController.txtChat =
                                            TextEditingController(
                                                text: contact[index].chat);
                                        homeController.txtPhone =
                                            TextEditingController(
                                                text: contact[index].phone);
                                        homeController.contactTime =
                                            contact[index].time;

                                        return AlertDialog(
                                          title: Text("Update Data"),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  homeController
                                                      .imagePickerMethod();
                                                },
                                                child: Obx(
                                                      () => CircleAvatar(
                                                    radius: 80,
                                                    backgroundImage: homeController
                                                        .contactImage
                                                        .isEmpty
                                                        ? const AssetImage(
                                                        'assets/image/1.jpg')
                                                        : FileImage(File(
                                                        homeController
                                                            .contactImage
                                                            .value))
                                                    as ImageProvider,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 20),
                                              // ✅ Added spacing
                                              textMethodMaterial(
                                                  controller:
                                                  homeController.txtName,
                                                  hint: 'Full Name',
                                                  isNumber: false,
                                                  iconData: Icon(
                                                      Icons.person_2_outlined)),
                                              textMethodMaterial(
                                                  controller:
                                                  homeController.txtPhone,
                                                  hint: 'Phone Number',
                                                  isNumber: true,
                                                  iconData: Icon(
                                                      Icons.phone_outlined)),
                                              textMethodMaterial(
                                                  controller:
                                                  homeController.txtChat,
                                                  hint: 'Chat Conversation',
                                                  isNumber: false,
                                                  iconData: Icon(
                                                      Icons.chat_outlined)),
                                            ],
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  homeController.setAllData();
                                                  Get.back();
                                                },
                                                child: Text('Cancel')),
                                            TextButton(
                                                onPressed: () {
                                                  homeController
                                                      .updateContactData(
                                                      contact[index]);
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text('Update')),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                  onPressed: () {
                                    homeController
                                        .deleteDataFromList(contact[index].id!);
                                    homeController.fetchData();
                                    Get.back();
                                  },
                                  icon: Icon(Icons.delete))
                            ],
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              leading: CircleAvatar(
                backgroundImage:
                FileImage(File(contact[index].image)) as ImageProvider,
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
