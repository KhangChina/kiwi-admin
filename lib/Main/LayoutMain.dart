import 'package:flutter/material.dart';
import 'package:kiwi_admin/Main/Home/HomeScreens.dart';
import 'package:kiwi_admin/Main/Profile/ProfileScreens.dart';

class LayoutMainScreens extends StatelessWidget {
  const LayoutMainScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.directions_car)),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_bike)),
            ],
          ),
          title: const Text('Tabs Demo'),
        ),
        body: const TabBarView(
          children: [
            HomeScreens(),
            ProfileScreens(),
            Icon(Icons.directions_bike),
          ],
        ),
      ),
    );
  }
}
