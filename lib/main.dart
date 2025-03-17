import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati_app/core/model/task_model.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/themes.dart';
import 'package:taskati_app/features/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  await Future.wait([
    Hive.openBox("userBox"),
    Hive.openBox<TaskModel>("taskBox"),
  ]);
  LocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalStorage.userBox!.listenable(),
      builder: (context, box, child) {
        bool isdarkTheme =
            LocalStorage.getData(LocalStorage.isdarkTheme) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isdarkTheme ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
