import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/app_colors.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/features/intro/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("userBox");
  LocalStorage.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: getSmallStyle(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 5.0, color: AppColors.primaryColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 5.0, color: AppColors.primaryColor),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 5.0, color: AppColors.pinkColor),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(width: 5.0, color: AppColors.pinkColor),
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
