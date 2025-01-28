import 'package:get/get.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';
import 'package:kiwi_admin/Register/RegisterScreens.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();
 Rx<bool> isPasswordVisible = false.obs;
  void navRegister()
  {
   Get.to(() => RegisterScreens());
  }

  void viewPassword()
  {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  void navHome()
  {
    Get.off(() => LayoutMainScreens());
  }
}
