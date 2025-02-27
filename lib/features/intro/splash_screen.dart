import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati_app/core/constants/assets_manager.dart';
import 'package:taskati_app/core/extensions/extensions.dart';
import 'package:taskati_app/core/utills/text_style.dart';
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
    Future.delayed(Duration(seconds: 5), () {
      context.pushReplacment(LoginPage());
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
            Text("Taskati", style: getTitleStyle()),
            SizedBox(height: 20),
            Text("Organize your tasks with ease", style: getSmallStyle()),
          ],
        ),
      ),
    );
  }
}
