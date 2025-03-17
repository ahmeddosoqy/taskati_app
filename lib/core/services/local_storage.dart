import 'package:hive/hive.dart';
import 'package:taskati_app/core/model/task_model.dart';

class LocalStorage {
  static Box? userBox;
  static Box<TaskModel>? taskBox;

  static String namekey = "name";
  static String imagekey = "image";
  static String isUploaded = "isUploaded";
  static String isdarkTheme = "isdarkTheme";

  static init() {
    userBox = Hive.box("userBox");
    taskBox = Hive.box<TaskModel>("taskBox");
  }

  static cacheData(String key, dynamic value) async {
    await userBox?.put(key, value);
  }

  static getData(String key) {
    return userBox?.get(key);
  }

  static cacheTaskData(String key, TaskModel value) async {
    await taskBox?.put(key, value);
  }

  static TaskModel? getTaskData(String key) {
    return taskBox?.get(key);
  }
}
