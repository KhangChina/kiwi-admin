import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Register/RegisterController.dart';

class RegisterScreens extends StatelessWidget {
  const RegisterScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    // bool isPasswordVisible = false;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, top: 80),
                child: Text(
                  "Đăng kí",
                  style: TextStyle(
                      color: Color(0xFF0D1634),
                      fontSize: 40,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 16),
                  child: Text('Start Your Journey with affordable price',
                      style: TextStyle(
                          color: Color(0xFF808080),
                          fontSize: 14,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.bold)))
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 38),
                  child: Text("EMAIL",
                      style: TextStyle(
                        color: Color(0xFF808080),
                        fontSize: 12,
                        fontFamily: 'Inter',
                      )))
            ],
          ),
          Row(children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: 5, left: 24, right: 24),
                child: SizedBox(
                  height: 32,
                  child: TextField(
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                    decoration: InputDecoration(
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Color(0xFF808080),
                        width: 1,
                      )),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                        color: Color(0xFF0D1634),
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide:
                            BorderSide(color: Color(0xFF0064D2), width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          // Row(
          //   children: [
          //     Padding(
          //         padding: EdgeInsets.only(left: 24, top: 24),
          //         child: Text("PASSWORD",
          //             style: TextStyle(
          //               color: Color(0xFF808080),
          //               fontSize: 12,
          //               fontFamily: 'Inter',
          //             )))
          //   ],
          // ),
          // Row(children: [
          //   Expanded(
          //     child: Padding(
          //       padding: EdgeInsets.only(top: 5, left: 24, right: 24),
          //       child: SizedBox(
          //         height: 32,
          //         child: TextField(
          //           style: TextStyle(
          //             fontSize: 14,
          //             fontFamily: 'Inter',
          //           ),
          //           decoration: InputDecoration(
          //             border: UnderlineInputBorder(
          //                 borderSide: BorderSide(
          //               color: Color(0xFF808080),
          //               width: 1,
          //             )),
          //             hintText: "Enter Your Password",
          //             hintStyle: TextStyle(
          //               color: Color(0xFF0D1634),
          //               fontSize: 14,
          //               fontFamily: 'Inter',
          //             ),
          //             contentPadding: EdgeInsets.symmetric(
          //               vertical: 10,
          //             ),
          //             focusedBorder: UnderlineInputBorder(
          //               borderSide:
          //                   BorderSide(color: Color(0xFF0064D2), width: 1),
          //             ),
          //             suffixIcon: Transform.translate(
          //                 offset: Offset(0, -4),
          //                 child: SizedBox(
          //                   width: 24,
          //                   height: 24,
          //                   child: IconButton(
          //                     icon: Icon(
          //                       isPasswordVisible
          //                           ? Icons.visibility
          //                           : Icons.visibility_off,
          //                       color: Color(0xFF808080),
          //                     ),
          //                     onPressed: () {},
          //                   ),
          //                 )),
          //           ),
          //         ),
          //       ),
          //     ),
          //   )
          // ]),
          Row(children: [
            Expanded(
                child: Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: ElevatedButton(
                onPressed: () {
                  controller.navHome();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0064D2),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  minimumSize: Size(double.infinity, 48),
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: 'Inter',
                    ),
                  ),
                  SizedBox(width: 8),
                  Image(
                      image: AssetImage('assets/images/check_circle.png'),
                      height: 20,
                      width: 20)
                ]),
              ),
            ))
          ]),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24, left: 24, right: 24),
                child: Text("Or Sign In With",
                    style: TextStyle(
                      color: Color(0xB2252831),
                      fontSize: 14,
                      fontFamily: 'Inter',
                      height: 0,
                    )),
              )
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image(
                      image: AssetImage('assets/images/facebook.png'),
                      height: 64),
                  SizedBox(width: 16),
                  Image(
                      image: AssetImage('assets/images/google.png'),
                      height: 64),
                  SizedBox(width: 16),
                  Image(image: AssetImage('assets/images/app.png'), height: 64),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(top: 24, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Color(0xB2252831),
                      fontSize: 14,
                      fontFamily: 'Inter',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.navLogin();
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Color(0xFF0064D2),
                        fontSize: 14,
                        fontFamily: 'Inter',
                      ),
                    ),
                  )
                ],
              ))
        ],
      ),
    ));
  }
}
