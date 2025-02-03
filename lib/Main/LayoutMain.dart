import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Main/Home/HomeScreens.dart';
import 'package:kiwi_admin/Main/Profile/ProfileScreens.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:kiwi_admin/Main/TabController.dart';
import 'package:kiwi_admin/Main/Transaction/TransactionScreens.dart';

class LayoutMainScreens extends StatelessWidget {
  const LayoutMainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TabsController());
    final iconList = [
      Icons.home,
      Icons.local_activity,
      Icons.history,
      Icons.account_circle,
    ];
    final iconName = ["Home", "Transaction", "History", "Profile"];
    return Scaffold(
      body: Obx(() {
        // Hiển thị màn hình tương ứng với tab được chọn
        switch (controller.bottomNavIndex.value) {
          case 0:
            return HomeScreens();
          case 1:
            return TransactionScreens();
          case 2:
            return Center(child: Text("History Screen"));
          case 3:
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
      bottomNavigationBar: Obx(() {
        return AnimatedBottomNavigationBar.builder(
            backgroundColor: Color(0xFFFFFFFF),
            height: 79,
            onTap: (index) {
              controller.setStateActive(index);
            },
            gapLocation: GapLocation.center,
            leftCornerRadius: 32,
            rightCornerRadius: 32,
            activeIndex: controller.bottomNavIndex.value,
            itemCount: iconList.length,
            tabBuilder: (int index, bool isActive) {
              final color = isActive ? Color(0xFF0064D2) : Color(0xFF808080);
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
    );
  }
}
