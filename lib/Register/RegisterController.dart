import 'package:get/get.dart';
import 'package:kiwi_admin/Login/LoginScreens.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  void navLogin()
  {
   Get.to(() => LoginScreens());
  }
  void navHome()
  {
    Get.off(() => LayoutMainScreens());
  }
}
