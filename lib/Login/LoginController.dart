import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';
import 'package:kiwi_admin/Register/RegisterScreens.dart';
import 'package:kiwi_admin/Utility/Config.dart';
import 'package:kiwi_admin/Utility/Utility.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
  // ignore: non_constant_identifier_names
  final utility_controller = Get.put(UtilityController());
  Rx<bool> isPasswordVisible = false.obs;
  void navRegister() {
    Get.to(() => RegisterScreens());
  }

  void viewPassword() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void navHome() {
    Get.off(() => LayoutMainScreens());
  }

  Future<void> login(username, password) async {
    var headers = {
      'Content-Type': 'application/json',
    };
    var data = json.encode({"username": username, "password": password});
    var dio = Dio();

    try {
      utility_controller.showLoadingDialog();
      var response = await dio.request(
        Config.API_BASE_URL+'/jwt-auth/v1/token',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );
      utility_controller.hideLoadingDialog();
      if (response.statusCode == 200) {
        var responseData = response.data;
        String? token = responseData['token'];
        if (token != null) {
          final box = GetStorage();
          box.write('auth_token', token);
          Get.back();
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      utility_controller.hideLoadingDialog();
      utility_controller.showErrorDialog(e.toString());
    }
  }
}
