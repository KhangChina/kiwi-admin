import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Clinic/ClinicScreens.dart';
import 'package:kiwi_admin/Utility/Config.dart';
import 'package:kiwi_admin/Utility/Utility.dart';

class HomeController extends GetxController {
  static HomeController get instance => Get.find();
  final utility_controller = Get.put(UtilityController());
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;
  @override
  void onInit() {
    super.onInit();
    startAutoScroll();
    getClinic(); // Kiểm tra token khi controller khởi tạo
  }

  RxBool isLoading = false.obs;
  RxList<dynamic> itemsProducts = <dynamic>[
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Bs Nguyễn Văn",
      "price": "100.0",
      "description": "Description for Item 1",
      "category": "Category 1",
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 2",
      "price": "200.0",
      "description": "Description for Item 2",
      "category": "Category 2",
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 3",
      "price": "300.0",
      "description": "Description for Item 3",
      "category": "Category 3",
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 4",
      "price": "300.0",
      "description": "Description for Item 4",
      "category": "Category 3",
    }
  ].obs;

  RxList<dynamic> itemsClinic = <dynamic>[].obs;
  Future<void> getClinic() async {
    var headers = {
      'Content-Type': 'application/json',
    };
    isLoading.value = true;
    var dio = Dio();
    try {
      var response = await dio.request(
        Config.API_BASE_URL + '/miniapp-zalo/v1/clinic',
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
          itemsClinic.assignAll(data);
        }
      } else {
        print(response.statusMessage);
      }
    } catch (e) {
      print(e);
      isLoading.value = false;
    }
  }

  void updateCurrentPageChanged(index) {
    currentPageIndex.value = index;
  }

  void navToCreateClinic() {
    Get.to(() => ClinicScreens());
  }

  Timer? _timer;
  void startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (pageController.hasClients) {
        int nextPage =
            (currentPageIndex.value + 1) % 3; // Lặp lại khi hết trang
        pageController.animateToPage(
          nextPage,
          duration: Duration(milliseconds: 500), // Hiệu ứng chuyển trang mượt
          curve: Curves.easeInOut,
        );
        currentPageIndex.value = nextPage;
      }
    });
  }

}
