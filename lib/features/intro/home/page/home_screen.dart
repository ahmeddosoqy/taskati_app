import 'package:flutter/material.dart';
import 'package:taskati_app/features/intro/home/widgets/header_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(children: [HeaderWidget()]),
        ),
      ),
    );
  }
}
