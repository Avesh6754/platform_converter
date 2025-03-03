import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter/controller/homeController.dart';
import 'package:platform_converter/views/ios/ios_page.dart';

class AddContact extends StatelessWidget {
  const AddContact({super.key});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        spacing: 30,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 80,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 35,
                )),
          ),
          Column(

            spacing: 10,
            children: [
              textMethod(controller: homeController.txtName,hint: 'Full Name',isNumber: false,iconData: Icon(Icons.person_2_outlined)),
              textMethod(controller: homeController.txtPhone,hint: 'Phone Number',isNumber: true,iconData: Icon(Icons.phone_outlined)),
              textMethod(controller: homeController.txtChat,hint: 'Chat Conversation',isNumber: false,iconData: Icon(Icons.chat_outlined)),
              GetBuilder<HomeController>(
                builder: (controller) => Column(
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          controller.datePickerMethod(context);

                        }, icon: Icon(Icons.date_range)),
                        Text('${controller.pickDate}')
                      ],

                    ),
                    Row(
                      children: [
                        IconButton(onPressed: () {
                          homeController.timePickerMethod(context);

                        }, icon: Icon(Icons.date_range)),
                        Text('${homeController.timePick}')
                      ],
                    ),
                  ],
                ),
              ),
                ElevatedButton(onPressed: () {
                  
                }, child: Text('Save'))
              
            ],
          ),
        ],
      ),
    );
  }

  TextField textMethod({required String hint,required TextEditingController controller ,required bool isNumber,required var iconData }) {
    return TextField(
      controller: controller,
          keyboardType:(isNumber)? TextInputType.number:TextInputType.text,
          decoration: InputDecoration(

            prefixIcon: iconData,
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            hintStyle: TextStyle(fontWeight: FontWeight.w500)
          ),
        );
  }
}
