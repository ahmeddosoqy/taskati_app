import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/constants/assets_manager.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/services/local_storage.dart';
import 'package:taskati_app/core/utills/text_style.dart';
import 'package:taskati_app/features/intro/home/pages/home_screen.dart';
import 'package:taskati_app/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isUploaded = LocalStorage.getData(LocalStorage.isUploaded) ?? false;
    Future.delayed(Duration(seconds: 3), () {
      if (isUploaded) {
        context.pushReplacment(HomeScreen());
      } else {
        context.pushReplacment(LoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(AssetsManager.logo),
            Text("Taskati", style: getTitleStyle(context)),
            Gap(20),
            Text("Organize your tasks with ease", style: getBodyStyle(context)),
          ],
        ),
      ),
    );
  }
}
