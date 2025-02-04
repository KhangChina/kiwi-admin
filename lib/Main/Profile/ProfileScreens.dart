import 'package:flutter/material.dart';

class ProfileScreens extends StatelessWidget {
  const ProfileScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        ColoredBox(
            color: Color(0xFFFFFFFF),
            child: Column(children: [
              ProfileInfo(),
              ClinicInfo(),
            ])),
        SizedBox(height: 24),
        ColoredBox(
            color: Color(0xFFFFFFFF),
            child: Padding(
                padding: EdgeInsets.only(left: 24, right: 24, top: 24),
                child: Column(children: [
                  Row(
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Color(0xFF0064D2),
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                          child: Text(
                        "Thông báo",
                        style: TextStyle(fontSize: 16),
                      )),
                      Icon(
                        Icons.navigate_next,
                        color: Color(0xFFCDD4D3),
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Divider(
                    height: 0.5,
                    color: Color(0xFFCDD4D3),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Icon(
                        Icons.logout,
                        color: Color(0xFF0064D2),
                        size: 24,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                          child: Text(
                        "Đăng xuất",
                        style: TextStyle(fontSize: 16),
                      )),
                      Icon(
                        Icons.navigate_next,
                        color: Color(0xFFCDD4D3),
                        size: 24,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
              
                ])))
      ],
    )));
  }
}

class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 225,
      child: DecoratedBox(
          decoration: BoxDecoration(
            color: Color(0xFF0064D2),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(35),
                bottomRight: Radius.circular(35)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 24, top: 30),
            child: Column(
              children: [
                SizedBox(height: 24),
                Row(children: [
                  Text("My Profile",
                      style: TextStyle(
                          color: Color(0xffFFFFFF),
                          fontSize: 20,
                          fontWeight: FontWeight.bold))
                ]),
                SizedBox(height: 28),
                Row(
                  children: [
                    Image.asset('assets/images/profile.png',
                        width: 80, height: 80),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Khang Nguyễn",
                                    style: TextStyle(
                                        color: Color(0xffFFFFFF),
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                Icon(
                                  Icons.edit_square,
                                  color: Color(0xffFFFFFF),
                                  size: 24,
                                )
                              ],
                            ),
                          ),
                          Text("nguyenkhang1400@gmail.com",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
                          Text("+1 654 785 4462",
                              style: TextStyle(
                                  color: Color(0xffFFFFFF),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class ClinicInfo extends StatelessWidget {
  const ClinicInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  Icons.location_city,
                  color: Color(0xFF0064D2),
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                    child: Text(
                  "Phòng khám của bạn",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(
                  Icons.navigate_next,
                  color: Color(0xFFCDD4D3),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 25),
            Divider(
              height: 0.5,
              color: Color(0xFFCDD4D3),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.medical_services,
                  color: Color(0xFF0064D2),
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                    child: Text(
                  "Dịch vụ (sớm có)",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(
                  Icons.navigate_next,
                  color: Color(0xFFCDD4D3),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 25),
            Divider(
              height: 0.5,
              color: Color(0xFFCDD4D3),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.healing,
                  color: Color(0xFF0064D2),
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                    child: Text(
                  "Chuyên khoa (sớm có)",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(
                  Icons.navigate_next,
                  color: Color(0xFFCDD4D3),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 25),
            Divider(
              height: 0.5,
              color: Color(0xFFCDD4D3),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.group,
                  color: Color(0xFF0064D2),
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                    child: Text(
                  "Bác sĩ (sớm có)",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(
                  Icons.navigate_next,
                  color: Color(0xFFCDD4D3),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 25),
            Divider(
              height: 0.5,
              color: Color(0xFFCDD4D3),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.flip,
                  color: Color(0xFF0064D2),
                  size: 24,
                ),
                SizedBox(width: 16),
                Expanded(
                    child: Text(
                  "Đăng nhập vân tay",
                  style: TextStyle(fontSize: 16),
                )),
                Icon(
                  Icons.navigate_next,
                  color: Color(0xFFCDD4D3),
                  size: 24,
                ),
              ],
            ),
            SizedBox(height: 25),
          ],
        ));
  }
}
