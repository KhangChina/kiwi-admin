import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';
import 'package:kiwi_admin/Onboarding/OnboardingScreens.dart';
import 'package:kiwi_admin/Utility/Utility.dart';

Future<void> main() async {
  await GetStorage.init();
  Get.put(UtilityController());
  runApp(const MainApp());
}
class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final onboarding = !box.hasData('onboarding');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false, // Tắt banner debug
      title: 'Kiwi Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue, // Chủ đề chính
      ),
      home: onboarding ? OnboardingScreens() : LayoutMainScreens(),
    );
  }
}
