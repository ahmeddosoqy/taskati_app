import 'package:flutter/material.dart';
import 'package:taskati_app/core/utills/app_colors.dart';

TextStyle getTitleStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize ?? 18,
    color: color ?? AppColors.darkColor,
    fontWeight: fontWeight ?? FontWeight.bold,
  );
}

TextStyle getBodyStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize ?? 16,
    color: color ?? AppColors.darkColor,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}

TextStyle getSmallStyle({
  double? fontSize,
  Color? color,
  FontWeight? fontWeight,
}) {
  return TextStyle(
    fontSize: fontSize ?? 14,
    color: color ?? AppColors.greyColor,
    fontWeight: fontWeight ?? FontWeight.normal,
  );
}
