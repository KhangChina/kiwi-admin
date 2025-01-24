import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';

class OnboardingController extends GetxController {
  static OnboardingController get instance => Get.find();
  final pageController = PageController();
  final textPageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  Rx<String> textLogin = "Next".obs;
  RxList<dynamic> itemsOnboarding = <dynamic>[
    {
      "id": 1,
      "image": "assets/gif/onboarding1.json",
      "text": "Đặt lịch nhanh chóng, dễ dàng chỉ với vài thao tác đơn giản."
    },
    {
      "id": 2,
      "image": "assets/gif/onboarding2.json",
      "text": "Luôn đồng hành và hỗ trợ bạn mọi lúc, mọi nơi."
    },
    {
      "id": 3,
      "image": "assets/gif/onboarding3.json",
      "text": "Tối ưu trải nghiệm của bạn với công nghệ tiên tiến."
    }
  ].obs;

  void updateCurrentPageChanged(index) {
    currentPageIndex.value = index;
  }

  void nextPage() {
    // ignore: invalid_use_of_protected_member
    int count = itemsOnboarding.value.length;

    if (currentPageIndex.value == (count - 2)) {
      textLogin.value = "Login";
    }
    if (currentPageIndex.value >= (count - 1)) {
      Get.off(() => LayoutMainScreens());
      return;
    }

    currentPageIndex.value += 1;
    pageController.animateToPage(
      currentPageIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    textPageController.animateToPage(
      currentPageIndex.value,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void skipToMain() {
    Get.off(() => LayoutMainScreens());
    return;
  }
}
