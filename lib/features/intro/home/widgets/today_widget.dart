import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/core/widgets/custom_button.dart';
import 'package:taskati_app/features/intro/home/pages/add_task.dart';

class TodayWidget extends StatelessWidget {
  const TodayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormat.yMMMEd().format(DateTime.now()),
                style: getTitleStyle(context, fontSize: 16),
              ),
              Text("Today", style: getBodyStyle(context)),
            ],
          ),
        ),
        Gap(20),
        CustomButton(
          width: 130,
          onPressed: () {
            context.pushTo(AddTask());
          },
          text: "Add Task",
        ),
      ],
    );
  }
}
