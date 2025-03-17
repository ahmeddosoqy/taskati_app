import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/core/widgets/custom_button.dart';
import 'package:taskati_app/features/intro/home/pages/home_screen.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  var formKey = GlobalKey<FormState>();
  TextEditingController dateController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController starttimeController = TextEditingController();
  TextEditingController endtimeController = TextEditingController();
  int selectedColor = 0;
  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat("dd/MM/yyyy").format(DateTime.now());
    starttimeController.text = DateFormat("hh:mm a").format(DateTime.now());
    endtimeController.text = DateFormat("hh:mm a").format(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Your Task", style: getTitleStyle(context)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Title", style: getBodyStyle(context)),
                Gap(5),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Title";
                    }
                    return null;
                  },
                  controller: titleController,
                  decoration: InputDecoration(hintText: "Enter Title"),
                ),
                Gap(10),
                Text("Description", style: getBodyStyle(context)),
                Gap(5),
                TextFormField(
                  maxLines: 3,
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: "Description"),
                ),
                Gap(10),
                Text("Date ", style: getBodyStyle(context)),
                Gap(10),
                TextFormField(
                  readOnly: true,
                  controller: dateController,
                  onTap: () async {
                    var pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030),
                    );
                    if (pickedDate != null) {
                      dateController.text = DateFormat(
                        "dd/MM/yyyy",
                      ).format(pickedDate);
                    }
                  },
                  decoration: InputDecoration(
                    suffixIcon: Icon(
                      Icons.calendar_month_rounded,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
                Gap(10),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Start Time", style: getBodyStyle(context)),
                          TextFormField(
                            controller: starttimeController,
                            readOnly: true,
                            onTap: () async {
                              var pickTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickTime != null) {
                                starttimeController.text = pickTime.format(
                                  context,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("End Time", style: getBodyStyle(context)),

                          TextFormField(
                            controller: endtimeController,
                            readOnly: true,
                            onTap: () async {
                              var pickTime = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (pickTime != null) {
                                endtimeController.text = pickTime.format(
                                  context,
                                );
                              }
                            },
                            decoration: InputDecoration(
                              suffixIcon: Icon(
                                Icons.access_time_rounded,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Gap(10),
                Row(
                  children: [
                    Row(
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedColor = index;
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor:
                                  index == 0
                                      ? AppColors.primaryColor
                                      : index == 1
                                      ? AppColors.pinkColor
                                      : AppColors.orangeColor,
                              child:
                                  selectedColor == index
                                      ? Icon(Icons.check, color: Colors.white)
                                      : null,
                            ),
                          ),
                        );
                      }),
                    ),
                    Spacer(),
                    CustomButton(
                      width: 160,
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          var key =
                              DateTime.now().millisecondsSinceEpoch.toString() +
                              titleController.text;
                          await LocalStorage.cacheTaskData(
                            key,
                            TaskModel(
                              id: key,
                              title: titleController.text,
                              description: descriptionController.text,
                              date: dateController.text,
                              startTime: starttimeController.text,
                              endTime: endtimeController.text,
                              color: selectedColor,
                              isCompleted: false,
                            ),
                          );
                          context.pushReplacment(HomeScreen());
                        }
                      },
                      text: "Create Task",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
