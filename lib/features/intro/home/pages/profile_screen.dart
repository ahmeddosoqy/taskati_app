import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/core/widgets/custom_button.dart';
import 'package:taskati_app/features/intro/home/pages/home_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? path;
  TextEditingController nameController = TextEditingController();
  String? name;
  bool isDrarkTheme = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile", style: getTitleStyle(context)),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            if (path != null) {
              LocalStorage.cacheData(LocalStorage.imagekey, path);
            }

            context.pushReplacment(const HomeScreen());
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDrarkTheme ? AppColors.whiteColor : AppColors.darkColor,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isDrarkTheme =
                  LocalStorage.getData(LocalStorage.isdarkTheme) ?? false;
              LocalStorage.cacheData(LocalStorage.isdarkTheme, !isDrarkTheme);

              setState(() {
                isDrarkTheme = !isDrarkTheme;
              });
            },
            icon: Icon(
              isDrarkTheme ? Icons.dark_mode : Icons.light_mode,
              color: isDrarkTheme ? AppColors.whiteColor : AppColors.darkColor,
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 65,
                    backgroundImage:
                        path == null
                            ? FileImage(
                              File(LocalStorage.getData(LocalStorage.imagekey)),
                            )
                            : FileImage(File(path!)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color:
                            isDrarkTheme
                                ? AppColors.darkColor
                                : AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(30),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 200,
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CustomButton(
                                          width: double.infinity,
                                          text: "Upload from Camera",
                                          onPressed: () {
                                            uploadImage(true);
                                          },
                                        ),
                                        const Gap(20),
                                        CustomButton(
                                          width: double.infinity,
                                          text: "Upload from Gallery",
                                          onPressed: () {
                                            uploadImage(false);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: AppColors.primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Divider(color: AppColors.primaryColor, indent: 30, endIndent: 30),
              const Gap(40),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.primaryColor,
                ),
                padding: const EdgeInsets.all(10),

                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        name == null
                            ? LocalStorage.getData(LocalStorage.namekey)
                            : name!,
                        style: getTitleStyle(
                          context,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor:
                              isDrarkTheme
                                  ? AppColors.darkColor
                                  : AppColors.whiteColor,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                          ),
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom,
                              ),
                              child: SizedBox(
                                width: double.infinity,
                                height: 200,
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextFormField(
                                          controller: nameController,
                                          decoration: InputDecoration(
                                            hintText: LocalStorage.getData(
                                              LocalStorage.namekey,
                                            ),
                                            hintStyle: getBodyStyle(
                                              context,
                                              color:
                                                  isDrarkTheme
                                                      ? AppColors.whiteColor
                                                      : AppColors.darkColor,
                                            ),
                                          ),
                                        ),
                                        Gap(20),
                                        CustomButton(
                                          width: double.infinity,
                                          text: "Update Your Name",
                                          onPressed: () {
                                            LocalStorage.cacheData(
                                              LocalStorage.namekey,
                                              nameController.text,
                                            );
                                            setState(() {
                                              name = nameController.text;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      icon: Icon(
                        Icons.edit_outlined,
                        color: AppColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  uploadImage(bool isCamera) async {
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
