import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';

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
                "Hello ${LocalStorage.getData("name")}",
                style: getTitleStyle(color: AppColors.primaryColor),
              ),
              Text("Have A Nice Day", style: getBodyStyle()),
            ],
          ),
        ),
        CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(File(LocalStorage.getData("image"))),
        ),
      ],
    );
  }
}
