import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/features/intro/home/widgets/header_widget.dart';
import 'package:taskati_app/features/intro/home/widgets/tasks.dart';
import 'package:taskati_app/features/intro/home/widgets/today_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String pickDate = DateFormat("dd/MM/yyyy").format(DateTime.now());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: [
              HeaderWidget(),
              Gap(20),
              TodayWidget(),
              Gap(20),
              DatePicker(
                DateTime.now(),
                width: 70,
                height: 100,
                initialSelectedDate: DateTime.now(),
                dayTextStyle: getSmallStyle(context),
                monthTextStyle: getSmallStyle(context),
                dateTextStyle: getTitleStyle(context),
                selectionColor: AppColors.primaryColor,
                selectedTextColor: AppColors.whiteColor,
                onDateChange: (date) {
                  setState(() {
                    pickDate = DateFormat("dd/MM/yyyy").format(date);
                  });
                },
              ),
              Gap(10),
              Tasks(selectedDate: pickDate),
            ],
          ),
        ),
      ),
    );
  }
}
