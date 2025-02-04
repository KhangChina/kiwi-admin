import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Main/Home/HomeController.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SingleChildScrollView(
          child: SafeArea(
              child: Column(children: [
        Stack(
          children: [
            SizedBox(
                height: 214, // Đặt chiều cao cố định cho PageView
                child: PageView(                
                    controller: controller.pageController,
                    onPageChanged: controller.updateCurrentPageChanged,
                    children: [
                      Image.asset("assets/images/onboarding_images.png",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/onboarding_images.png",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/onboarding_images.png",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/onboarding_images.png",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/onboarding_images.png",
                          fit: BoxFit.cover)
                    ])),
            Padding(
              padding:
                  const EdgeInsets.only(top: 214 - 15), // Cách phần dưới 10px
              child: NavigateItemHome(),
            ),
          ],
        ),
        productGroupPerfect(),
        productGroupSummer(),
      ]))),
    );
  }
}

class NavigateItemHome extends StatelessWidget {
  const NavigateItemHome({super.key});

  Widget build(BuildContext context) {
    final controller = HomeController.instance;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SmoothPageIndicator(
          axisDirection: Axis.horizontal,
          controller: controller.pageController,
          count: 5,
          effect: WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thinUnderground,
              activeDotColor: Color(0xFF006FFD),
              dotColor: Color(0xFFC5C6CC)),
          onDotClicked: (index) {},
        ),
      ],
    );
  }
}

class ItemProduct extends StatelessWidget {
  const ItemProduct({super.key, this.item});
  final dynamic item;
  @override
  Widget build(Object context) {
    return Padding(
        padding: EdgeInsets.only(right: 8),
        child: SizedBox(
          width: 200,
          // height: 189,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 120,
                child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                    child: Image.asset("assets/images/onboarding_images.png",
                        fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 200,
                height: 69,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: Color(0xFFF7F8FD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ) // Màu nền cho Row
                      ),
                  child: Column(children: [
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16, top: 16),
                          child: Text(
                            item["name"],
                            style: TextStyle(
                                color: Color(0xFF1F2024), fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 16),
                          child: Text(item["price"],
                              style: TextStyle(
                                  color: Color(0xFF1F2024),
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left),
                        ),
                      ],
                    ),
                  ]), // Tên,
                ),
              )
            ],
          ),
        ));
  }
}

class productGroupPerfect extends StatelessWidget {
  @override
  Widget build(Object context) {
    final controller = HomeController.instance;
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Phòng khám",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              InkWell(
                onTap: () {
                 controller.navToCreateClinic();
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Text("Đăng kí",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Color(0xFF006FFD))),
              ),
            ],
          )),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: SizedBox(
            height: 189,
            child: Obx(() {
              return ListView.builder(
                padding: EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: controller
                    .itemsProducts.length, // Số lượng phần tử trong danh sách
                itemBuilder: (context, index) {
                  final item = controller.itemsProducts[index];
                  return ItemProduct(item: item);
                },
              );
            })),
      ),
    ]);
  }
}

class productGroupSummer extends StatelessWidget {
  List<dynamic> items = [
    {
      "image": "assets/images/onboarding_images.png", // Đường dẫn tới hình ảnh
      "name": "Item 1",
      "price": "100.0",
      "description": "Description for Item 1",
      "category": "Category 1",
      // Thêm các trường khác nếu cần
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 2",
      "price": "200.0",
      "description": "Description for Item 2",
      "category": "Category 2",
      // Thêm các trường khác nếu cần
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 3",
      "price": "300.0",
      "description": "Description for Item 3",
      "category": "Category 3",
      // Thêm các trường khác nếu cần
    }
  ];
  @override
  Widget build(Object context) {
    return Column(children: [
      Padding(
          padding: EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bác sĩ",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Inter',
                    color: Color(0xFF000000)),
              ),
              InkWell(
                onTap: () {
                  print("Notification image clicked");
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Text("Đăng kí",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Inter',
                        color: Color(0xFF006FFD))),
              ),
            ],
          )),
      Padding(
        padding: EdgeInsets.only(top: 16),
        child: SizedBox(
          height: 189,
          child: ListView.builder(
            padding: EdgeInsets.only(left: 16),
            scrollDirection: Axis.horizontal,
            itemCount: items.length, // Số lượng phần tử trong danh sách
            itemBuilder: (context, index) {
              var item = items[index];
              return ItemProduct(item: item);
            },
          ),
        ),
      ),
    ]);
  }
}
