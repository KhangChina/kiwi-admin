import 'package:flutter/material.dart';

class LoginScreens extends StatelessWidget {
  const LoginScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24, top: 80),
                child: Text(
                  "Sign In",
                  style: TextStyle(
                    color: Color(0xFF0D1634),
                    fontSize: 40,
                    fontFamily: 'Inter',
                  ),
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
                      )))
            ],
          ),
          Row(
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 24, top: 38),
                  child: Text("Email",
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
                        // color: HexColor("#C5C6CC"),
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
                            BorderSide(color: Color(0xFF0064D2), width: 2),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
        ],
      ),
    ));
  }
}
