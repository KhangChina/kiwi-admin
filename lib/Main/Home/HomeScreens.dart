import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Main/Home/HomeController.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomeScreens extends StatelessWidget {
  const HomeScreens({super.key});
  @override
  Widget build(BuildContext context) {
    // final screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(HomeController());
    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        Stack(
          children: [
            SizedBox(
                height: 214, // Đặt chiều cao cố định cho PageView
                child: PageView(
                    controller: controller.pageController,
                    onPageChanged: controller.updateCurrentPageChanged,
                    children: [
                      Image.asset("assets/images/banner1.jpg",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/banner2.jpg",
                          fit: BoxFit.cover),
                      Image.asset("assets/images/banner3.jpg",
                          fit: BoxFit.cover),
                    ])),
            Padding(
              padding:
                  const EdgeInsets.only(top: 214 - 15), // Cách phần dưới 10px
              child: NavigateItemHome(),
            ),
          ],
        ),
        productGroupClinic(),
        productGroupDoctor(),
      ])),
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
          count: 3,
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

class ItemClinic extends StatelessWidget {
  const ItemClinic({super.key, this.item});

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
                    child: Image.network(item["url_image"], fit: BoxFit.cover)),
              ),
              SizedBox(
                width: 200,
                height: 50,
                child: DecoratedBox(
                    decoration: BoxDecoration(
                        color: Color(0xFFF7F8FD),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(16),
                          bottomRight: Radius.circular(16),
                        ) // Màu nền cho Row
                        ),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(left: 5, top: 5),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                item["name"],
                                style: TextStyle(
                                    color: Color(0xFF1F2024),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //Expanded(child: Row()),
                      // Row(
                      //   children: [
                      //     Padding(
                      //       padding: EdgeInsets.only(left: 5, bottom: 5),
                      //       child: Text(item["address"],
                      //           style: TextStyle(
                      //               color: Color(0xFF1F2024),
                      //               fontSize: 12,
                      //               fontWeight: FontWeight.normal),
                      //           textAlign: TextAlign.left),
                      //     ),
                      //   ],
                      // ),
                    ])), // Tên,
              ),
            ],
          ),
        ));
  }
}

class productGroupClinic extends StatelessWidget {
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
          height: 170,
          child: Obx(() {
            if (controller.isLoading.value) {
              // Hiển thị danh sách loading skeleton khi đang tải dữ liệu
              return ListView.builder(
                padding: EdgeInsets.only(left: 16),
                scrollDirection: Axis.horizontal,
                itemCount: 3, // Số lượng skeleton hiển thị
                itemBuilder: (context, index) {
                  return ItemClinicSkeleton(); // Hiển thị UI skeleton
                },
              );
            }

            // Nếu không có dữ liệu, hiển thị thông báo
            if (controller.itemsClinic.isEmpty) {
              return Center(child: Text("Không có phòng khám nào"));
            }

            // Hiển thị danh sách thực tế sau khi dữ liệu được tải
            return ListView.builder(
              padding: EdgeInsets.only(left: 16),
              scrollDirection: Axis.horizontal,
              itemCount: controller.itemsClinic.length,
              itemBuilder: (context, index) {
                final item = controller.itemsClinic[index];
                return ItemClinic(item: item);
              },
            );
          }),
        ),
      ),
    ]);
  }
}

class productGroupDoctor extends StatelessWidget {
  List<dynamic> items = [
    {
      "image": "assets/images/onboarding_images.png", // Đường dẫn tới hình ảnh
      "name": "Bs Nguyễn văn ABC",
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
    },
    {
      "image": "assets/images/onboarding_images.png",
      "name": "Item 3",
      "price": "300.0",
      "description": "Description for Item 3",
      "category": "Category 3",
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
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
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
          height: 200, // Đặt chiều cao cố định cho ListView
          width: double.infinity, // Chiếm hết chiều ngang có sẵn
          child: ListView.builder(
            padding: EdgeInsets.only(left: 16),
            scrollDirection: Axis.vertical,
            itemCount: items.length, // Số lượng phần tử trong danh sách
            itemBuilder: (context, index) {
              var item = items[index];
              return ItemDoctor(item: item);
            },
          ),
        ),
      )
    ]);
  }
}

class ItemClinicSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          width: 200,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}

class ItemDoctor extends StatelessWidget {
  const ItemDoctor({super.key, this.item});

  final dynamic item;
  @override
  Widget build(Object context) {
    return Padding(
      padding: EdgeInsets.only(right: 8, bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 60,
            height: 60,
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(50)),
                child: Image.asset(item["image"], fit: BoxFit.cover)),
          ),
          Expanded(
              child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      item["name"],
                      style: TextStyle(
                          color: Color(0xFF1F2024),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: 6),
                      child: Icon(
                        Icons.edit,
                        size: 20,
                        color: Color(0xFF006FFD),
                      ))
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 6),
                    child: Text(
                      "0964440775",
                      style: TextStyle(
                          color: Color(0xFFC5C6CC),
                          fontSize: 12,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              )
            ],
          ))

          // Tên,
        ],
      ),
    );
  }
}
