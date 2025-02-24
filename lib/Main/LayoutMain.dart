import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Main/History/HistoryScreens.dart';
import 'package:kiwi_admin/Main/Home/HomeScreens.dart';
import 'package:kiwi_admin/Main/Profile/ProfileScreens.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:kiwi_admin/Main/TabController.dart';
import 'package:kiwi_admin/Main/Transaction/TransactionScreens.dart';
import 'package:kiwi_admin/Utility/Utility.dart';

class LayoutMainScreens extends StatelessWidget {
  const LayoutMainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabsController());
    final utility = UtilityController.instance;
    final iconList = [
      Icons.home,
      Icons.local_activity,
      Icons.history,
      Icons.account_circle,
    ];
    final iconName = ["Trang chủ", "Sắp đến", "Lịch sử", "Bạn"];
    return Scaffold(
        body: Obx(() {
          // Hiển thị màn hình tương ứng với tab được chọn
          switch (controller.bottomNavIndex.value) {
            case 0:
              return HomeScreens();
            case 1:
              utility.checkAuth();
              return TransactionScreens();
            case 2:
              utility.checkAuth();
              return HistoryScreens();
            case 3:
              utility.checkAuth();
              return ProfileScreens();
            default:
              return HomeScreens();
          }
        }),
        floatingActionButton: Padding(
            padding: EdgeInsets.all(4),
            child: Obx(() {
              Color iconColor = controller.bottomNavIndex.value == 5
                  ? Color(0xFF0064D2) // Màu khi tab đầu tiên được chọn
                  : Color(0xFF808080);
              return FloatingActionButton(
                onPressed: () {
                  controller.setSupportButtonActive();
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100), // Bán kính bo góc
                ),
                child: Icon(
                  Icons.support_agent,
                  size: 35,
                  color: iconColor,
                ),
              );
            })),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: Stack(children: [
          Obx(() {
            return AnimatedBottomNavigationBar.builder(
                backgroundColor: Color(0xFFFFFFFF),
                height: 79,
                onTap: (index) {
                  controller.setStateActive(index);
                },
                splashColor: Color(0xFF0064D2),
                scaleFactor: 0.5,
                gapLocation: GapLocation.center,
                leftCornerRadius: 32,
                rightCornerRadius: 32,
                activeIndex: controller.bottomNavIndex.value,
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  final color =
                      isActive ? Color(0xFF0064D2) : Color(0xFF808080);
                  final textColor =
                      isActive ? Color(0xFF0D1634) : Color(0xFF808080);
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        iconList[index],
                        size: 24,
                        color: color,
                      ),
                      SizedBox(height: 2),
                      Text(
                        iconName[index],
                        style: TextStyle(
                          color: textColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  );
                });
          }),
          Positioned(
              bottom: 17,
              left: 0,
              right: 0,
              child: Center(
                child: Obx(() {
                  Color textColor = controller.bottomNavIndex.value == 5
                      ? Color(0xFF0064D2) // Màu khi tab đầu tiên được chọn
                      : Color(0xFF808080);
                  return Text("Hỗ trợ",
                      style: TextStyle(
                        fontSize: 12,
                        color: textColor,
                      ));
                }),
              ))
        ]));
  }
}
