import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Login/LoginScreens.dart';
import 'package:lottie/lottie.dart';
import 'package:intl/intl.dart';

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

  String formatTime(String time) {
    if (time.contains("am")) {
      return time.replaceAll("am", "").trim() + " Sáng";
    } else if (time.contains("pm")) {
      return time.replaceAll("pm", "").trim() + " Chiều";
    }
    return time;
  }

  String formatDate(String inputDate) {
    try {
      // Chuyển chuỗi thành DateTime
      DateTime date = DateFormat("d MMMM, yyyy").parse(inputDate);

      // Định dạng thành dd/MM/yyyy
      String formattedDate = DateFormat("dd/MM/yyyy").format(date);

      // Lấy ngày hiện tại
      String todayDate = DateFormat("dd/MM/yyyy").format(DateTime.now());

      // Kiểm tra nếu ngày hẹn = ngày hôm nay
      if (formattedDate == todayDate) {
        return "$formattedDate - hôm nay khám";
      }

      return formattedDate;
    } catch (e) {
      print("Lỗi chuyển đổi ngày: $e");
      return inputDate; // Trả về ngày gốc nếu có lỗi
    }
  }

  String getStatusText(dynamic status) {
    Map<int, String> statusMap = {
      1: "Sắp đến",
      2: "Hoàn thành",
      3: "Hủy",
      4: "CheckIn",
      5: "Tạm ngưng",
    };

    return statusMap[int.tryParse(status.toString())] ?? "Không xác định";
  }
}
