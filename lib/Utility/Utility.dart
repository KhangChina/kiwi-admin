import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Login/LoginScreens.dart';
import 'package:lottie/lottie.dart';

class UtilityController extends GetxController {
  static UtilityController get instance => Get.find();

  void showLoadingDialog() {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/gif/loading.json',
                fit: BoxFit.contain, width: 150),
            // SizedBox(height: 20),
            Text("Chờ xíu...",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0D1634),
                )),
          ],
        ),
      ),
      barrierDismissible: false,
    );
  }

  void hideLoadingDialog() {
    if (Get.isDialogOpen!) {
      Get.back();
    }
  }

  void showErrorDialog(e) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset('assets/gif/error.json',
                fit: BoxFit.contain, width: 150),
            Text(e,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0D1634),
                )),
          ],
        ),
        actions: [
          TextButton(
            child: Text("Thoát",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0D1634),
                )),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Rx<bool> isAuthenticated = true.obs;
  Future<void> checkAuth() async {
    final box = GetStorage();
    bool hasToken = box.hasData('auth_token');
    if (!hasToken) {
      isAuthenticated.value = true;
      Future.delayed(Duration.zero, () {
        if (Get.context != null) {
          Get.to(() => LoginScreens());
        }
      }); // Điều hướng đến màn hình đăng nhập
    } else {
      isAuthenticated.value = true;
    }
  }
}
