import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:html_unescape/html_unescape.dart';
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
    time = time.replaceAll("am", "Sáng").replaceAll("pm", "Chiều");
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
      2: "Tạm ngưng",
      3: "Khách hàng đã khám",
      4: "Vào phòng khám",
      0: "Khách hàng đã Hủy",
    };

    return statusMap[int.tryParse(status.toString())] ?? "Không xác định";
  }

  String formatNameClinic(String encodedString) {
    HtmlUnescape unescape = HtmlUnescape();
    return unescape.convert(encodedString);
  }

  Icon getStatusIcon(dynamic status) {
    Map<int, Map<String, dynamic>> statusMap = {
      1: {"icon": Icons.access_time, "color": Colors.orange}, // Sắp đến
      2: {"icon": Icons.pause_circle, "color": Colors.grey}, // Tạm ngưng
      3: {
        "icon": Icons.check_circle,
        "color": Colors.green
      }, // Khách hàng đã khám
      4: {
        "icon": Icons.medical_services,
        "color": Colors.blue
      }, // Vào phòng khám
      0: {"icon": Icons.cancel, "color": Colors.red}, // Khách hàng đã Hủy
    };

    var statusInfo = statusMap[int.tryParse(status.toString())] ??
        {
          "icon": Icons.help,
          "color": Colors.black
        }; // Trạng thái không xác định

    return Icon(
      statusInfo["icon"],
      color: statusInfo["color"],
    );
  }

  void showConfirmDialog({required dynamic id, required dynamic status, required Function(dynamic, dynamic) onConfirm}) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Xác nhận",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Bạn có chắc chắn muốn tiếp tục?",
          style: TextStyle(fontSize: 16, color: Color(0xFF0D1634)),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Hủy", style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm(id,status);
            },
            child: Text("Đồng ý", style: TextStyle(color: Colors.blue)),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
