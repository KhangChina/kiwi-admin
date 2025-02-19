import 'dart:convert';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:kiwi_admin/Utility/Config.dart';

class TransactionController extends GetxController {
  static TransactionController get instance => Get.find();
  final box = GetStorage();
  @override
  void onInit() {
    super.onInit();
    var start_date = DateFormat('yyyy-MM-dd').format(DateTime.now());
    var end_date = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: 5)));
    getDataTransaction(start_date, end_date, 1);
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
      //Call API
      var end_date = DateFormat('yyyy-MM-dd').format(results[1]!);
      var start_date = DateFormat('yyyy-MM-dd').format(results[0]!);
      await getDataTransaction(start_date, end_date, 1);
    }
    dialogCalendarPickerValue.refresh();
  }

  String formatDate(DateTime? date) {
    return date != null ? DateFormat('d/M/y').format(date) : 'N/A';
  }

  RxBool isLoading = false.obs;
  RxList<dynamic> itemsTransaction = <dynamic>[].obs;
  Future<void> getDataTransaction(start_date, end_date, status) async {
    var token = box.read('auth_token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
    isLoading.value = true;
    var dio = Dio();
    try {
      var response = await dio.request(
        Config.API_BASE_URL +
            '/mobile/v1/appointment?start_date=${start_date}&end_date=${end_date}&status=${status}',
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

  Future<void> changeStatus(id, status) async {
    var data = jsonEncode({
      "appointment_id": id,
      "appointment_status": status.toString(),
    });
    var token = box.read('auth_token');
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ' + token,
    };
    isLoading.value = true;
    var dio = Dio();
    try {
      var response = await dio.request(
        Config.API_BASE_URL + '/mobile/v1/appointment/update-status',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      isLoading.value = false;
      if (response.statusCode == 200) {
        var responseData = response.data;
        print(responseData);
        //var data = responseData['data'];
        // if (data != null) {
        //  print("ok");
        // }
        itemsTransaction.removeWhere((item) => item["id"] == id);
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      isLoading.value = false;
      print(e);
    }
  }

  getAllData(status) {
    var end_date =
        DateFormat('yyyy-MM-dd').format(dialogCalendarPickerValue.value[1]);
    var start_date =
        DateFormat('yyyy-MM-dd').format(dialogCalendarPickerValue.value[0]);
    getDataTransaction(start_date, end_date, status);
  }
}
