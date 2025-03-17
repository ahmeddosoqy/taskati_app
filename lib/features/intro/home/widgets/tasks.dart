import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key, required this.selectedDate});
  final String selectedDate;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: LocalStorage.taskBox!.listenable(),
        builder: (context, box, child) {
          List<TaskModel> tasks =
              box.values.where((e) => e.date == selectedDate).toList();
          if (tasks.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Lottie.asset("assets/images/Time.json"),
                  Gap(20),
                  Text(
                    "No Tasks For This Day 😁 !",
                    style: getTitleStyle(context),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: UniqueKey(),
                background: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.delete, color: AppColors.whiteColor),
                      Gap(10),
                      Text(
                        "Delete",
                        style: getTitleStyle(
                          context,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                secondaryBackground: Container(
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.done, size: 30, color: AppColors.whiteColor),
                      Gap(10),
                      Text(
                        "Done",
                        style: getTitleStyle(
                          context,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    box.delete(tasks[index].id);
                  } else {
                    box.put(
                      tasks[index].id,
                      tasks[index].copyWith(isCompleted: true),
                    );
                  }
                },
                child: TaskItem(task: tasks[index]),
              );
            },
          );
        },
      ),
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({super.key, required this.task});
  final TaskModel task;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color:
            task.isCompleted
                ? Colors.lightGreenAccent
                : task.color == 0
                ? AppColors.primaryColor
                : task.color == 1
                ? AppColors.pinkColor
                : AppColors.orangeColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: getTitleStyle(context, color: AppColors.whiteColor),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.watch_later_outlined,
                      color: AppColors.whiteColor,
                    ),
                    Text(
                      "${task.startTime} - ${task.endTime}",
                      style: getBodyStyle(
                        context,

                        color: AppColors.whiteColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  task.description,
                  style: getSmallStyle(context, color: AppColors.whiteColor),
                ),
              ],
            ),
          ),
          Container(width: 2, height: 60, color: AppColors.whiteColor),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              task.isCompleted ? "Completed" : "TO DO",
              style: getSmallStyle(context, color: AppColors.whiteColor),
            ),
          ),
        ],
      ),
    );
  }
}
