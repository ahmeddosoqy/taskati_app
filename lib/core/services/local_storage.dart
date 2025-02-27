import 'package:hive/hive.dart';

class LocalStorage {
  static Box? userBox;

  static init() {
    userBox = Hive.box("userBox");
  }

  static cacheData(String key, dynamic value) async {
    await userBox?.put(key, value);
  }

  static getData(String key) {
    return userBox?.get(key);
  }
}
