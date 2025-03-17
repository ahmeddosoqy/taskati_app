import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/features/intro/home/pages/profile_screen.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello, ${LocalStorage.getData("name")}",
                style: getTitleStyle(context, color: AppColors.primaryColor),
              ),
              Text("Have A Nice Day", style: getBodyStyle(context)),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            context.pushTo(ProfileScreen());
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: FileImage(File(LocalStorage.getData("image"))),
          ),
        ),
      ],
    );
  }
}
