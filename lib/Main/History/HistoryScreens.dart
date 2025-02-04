import 'package:flutter/material.dart';

class HistoryScreens extends StatelessWidget {
  const HistoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 0,
            bottom: TabBar(
              labelColor: Color(0xFF0064D2),
              unselectedLabelColor: Color(0xFFD0D0D0),
              indicatorColor: Color(0xFF0064D2),
              tabs: [
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min, // Căn giữa icon và chữ
                    children: [
                      Icon(Icons.list, size: 18),
                      SizedBox(width: 5), // Khoảng cách giữa icon và chữ
                      Text("Tất cả"),
                    ],
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.check_circle, size: 18),
                      SizedBox(width: 5),
                      Text("Đã khám"),
                    ],
                  ),
                ),
                Tab(
                    child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.cancel, size: 18),
                    SizedBox(width: 5),
                    Text("Đã huỷ"),
                  ],
                ))
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    ));
  }
}
