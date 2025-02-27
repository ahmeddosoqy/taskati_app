import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/core/widgets/custom_button.dart';
import 'package:taskati_app/core/widgets/dialogs.dart';
import 'package:taskati_app/features/intro/home/page/home_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? path;
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              if (path != null && nameController.text.isNotEmpty) {
                LocalStorage.cacheData("name", nameController.text);
                LocalStorage.cacheData("image", path);
                context.pushTo(HomeScreen());
              } else {
                showErrorText(context, "Please Provide both Name and image ");
              }
            },
            child: Text(
              "Done",
              style: getBodyStyle(color: AppColors.primaryColor),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage:
                    path != null
                        ? FileImage(File(path!))
                        : AssetImage("assets/images/avatar.png"),
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Upload From Camera",
                onPressed: () {
                  uploadAmage(true);
                },
              ),
              SizedBox(height: 20),
              CustomButton(
                text: "Upload From Gallery",
                onPressed: () {
                  uploadAmage(false);
                },
              ),
              SizedBox(height: 20),
              Divider(thickness: 4.0),
              SizedBox(height: 10),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(hintText: "Enter Your Name"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadAmage(bool isCamera) async {
    XFile? pickedImage = await ImagePicker().pickImage(
      source: isCamera ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        path = pickedImage.path;
      });
    }
  }
}
