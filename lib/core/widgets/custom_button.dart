import 'package:flutter/material.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
  });
  final String text;
  final Function() onPressed;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: width ?? 260,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        child: Text(
          text,
          style: getTitleStyle(
            context,
            color: AppColors.whiteColor,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
