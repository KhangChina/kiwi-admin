import 'package:get/get.dart';

class TabsController extends GetxController {
  static TabsController get instance => Get.find();
  Rx<int> bottomNavIndex = 0.obs;

  setStateActive(int index) {
    bottomNavIndex.value = index;
  }

  setSupportButtonActive()
  {
    bottomNavIndex.value = 5;
  }
}
