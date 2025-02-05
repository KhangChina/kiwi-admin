import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Main/Home/HomeScreens.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';
class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();

  void logout() {
    final box = GetStorage();
    box.remove('auth_token');
    Future.delayed(Duration.zero, () {
      if (Get.context != null) {
        Get.offAll(() => LayoutMainScreens()); // Điều hướng đến màn hình login
      }
    });
  }
}
