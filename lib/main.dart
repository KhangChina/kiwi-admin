import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Clinic/ClinicScreens.dart';
import 'package:kiwi_admin/Onboarding/OnboardingScreens.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      title: 'Onboarding App',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Chủ đề chính
      ),
      home: OnboardingScreens(),
    );
  }
}
