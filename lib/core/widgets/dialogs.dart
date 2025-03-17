import 'package:flutter/material.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';

showErrorText(BuildContext context, String messege) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: Duration(seconds: 3),
      backgroundColor: AppColors.pinkColor,
      content: Text(
        messege,
        style: getBodyStyle(context, color: AppColors.whiteColor),
      ),
    ),
  );
}
