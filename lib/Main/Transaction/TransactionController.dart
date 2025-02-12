import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kiwi_admin/Utility/Config.dart';
class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();
  @override
  void onInit() {
    super.onInit();
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
  RxBool isLoading = false.obs;
  RxList<dynamic> itemsTransaction = <dynamic>[].obs;
  Future<void> get_data_transaction()
  async {
    var headers = {
      'Content-Type': 'application/json',
    };
    isLoading.value = true;
    var dio = Dio();
    try {
      var response = await dio.request(
        Config.API_BASE_URL + '/wp-json/mobile/v1/appointment',
        options: Options(
          method: 'GET',
          headers: headers,
        ),
      );
      isLoading.value = false;
      if (response.statusCode == 200) {
        var responseData = response.data;
        var data = responseData['data'];
        if (data != null) {
          // itemsClinic.value = data;
          itemsTransaction.assignAll(data);
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }
}
