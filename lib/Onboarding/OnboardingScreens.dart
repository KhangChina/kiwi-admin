import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Onboarding/OnboardingController.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreens extends StatelessWidget {
  const OnboardingScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
        body: SafeArea(
            child: ColoredBox(
      color: Colors.white,
      child: Column(children: [
        OnboardingImages(),
        Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 20),
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                  expansionFactor: 3,
                  spacing: 8,
                  dotHeight: 6,
                  dotWidth: 21,
                  activeDotColor: Color(0xFF0064D2),
                  dotColor: Color(0xFFE1F0ED)),
              onDotClicked: (index) {},
            )),
        OnboardingTexts(),
        Expanded(child: Container()),
        Padding(
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 45),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                child: Text(
                  "Bỏ qua",
                  style: TextStyle(
                    color: Color(0xFF252831),
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),
                ),
                onPressed: () => {controller.skipToMain()},
              )),
              SizedBox(width: 8),
              Expanded(
                  child: ElevatedButton(
                      onPressed: () => {controller.nextPage()},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0064D2),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Obx(() {
                            return Text(
                              controller.textLogin.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            );
                          }),
                          SizedBox(width: 8),
                          Image(
                              image: AssetImage(
                                  'assets/images/arrow_circle_right.png'),
                              height: 20,
                              width: 20)
                        ],
                      )))
            ],
          ),
        )
      ]),
    )));
  }
}

class OnboardingImages extends StatelessWidget {
  const OnboardingImages({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final controller = OnboardingController.instance;
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 23),
      child: Center(
          child: SizedBox(
              height: screenHeight * 0.5,
              // width: screenWidth,
              child: PageView(
                controller: controller.pageController,
                children: controller.itemsOnboarding.map((items) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(9),
                    child: Lottie.asset(items["image"]),
                  );
                }).toList(),
              ))),
    );
  }
}

class OnboardingTexts extends StatelessWidget {
  const OnboardingTexts({super.key});

  @override
  Widget build(BuildContext context) {
     final controller = OnboardingController.instance;
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16, top: 24),
      child: SizedBox(
          height: 144,
          child: PageView(
            controller: controller.textPageController,
            children: controller.itemsOnboarding.map((items) {
              return Text(
                items["text"],
                style: TextStyle(
                  color: Color(0xFF0A0A0A),
                  fontSize: 40,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w800,
                  height: 1.2, // Đặt giá trị hợp lệ để căn chỉnh dòng
                ),
              );
            }).toList(),
          )),
    );
  }
}
