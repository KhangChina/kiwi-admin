import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kiwi_admin/Login/LoginScreens.dart';
class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
    print("hello");
    checkAuth(); // Kiểm tra token khi controller khởi tạo
  }

  var isAuthenticated = false.obs;
  Future<void> checkAuth() async {
    final box = GetStorage();
   bool hasToken = box.hasData('auth_token');
    if (!hasToken) {
      isAuthenticated.value = false;
     Future.delayed(Duration.zero, () {
      if (Get.context != null) {
        Get.to(() => LoginScreens()); 
      }
    }); // Điều hướng đến màn hình đăng nhập
    } else {
      isAuthenticated.value = true;
    }
  }

  RxList<DateTime> dialogCalendarPickerValue = [
    DateTime.now(),
    DateTime.now().add(const Duration(days: 5)),
  ].obs;

  Future<void> showDialogSelectDate(context) async {
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig(
          calendarType: CalendarDatePicker2Type.range,
          selectedRangeHighlightColor: Color(0xFFD0D0D0),
          selectedDayHighlightColor: Color(0xFF0064D2)),
      dialogSize: const Size(325, 400),
      value: dialogCalendarPickerValue.value,
      borderRadius: BorderRadius.circular(15),
    );
    if (results != null && results.isNotEmpty) {
      dialogCalendarPickerValue[0] = results[0] as DateTime? ?? DateTime.now();
      if (results.length > 1) {
        dialogCalendarPickerValue[1] = results[1] as DateTime? ??
            DateTime.now().add(const Duration(days: 5));
      }
    }
    dialogCalendarPickerValue.refresh();
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('d/M/y').format(date) : 'N/A';
  }
}
