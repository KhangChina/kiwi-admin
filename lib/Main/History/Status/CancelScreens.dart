import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:kiwi_admin/Main/History/HistoryController.dart';
import 'package:lottie/lottie.dart';

class CancelHistoryScreens extends StatelessWidget {
  const CancelHistoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryController());
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: InkWell(
                    onTap: () async {
                      await controller.showDialogSelectDate(context);
                    },
                    child: Obx(() {
                      return Text(
                        "Đang lọc theo: " +
                            "Từ " +
                            controller.formatDate(
                                controller.dialogCalendarPickerValue.value[0]) +
                            " đến " +
                            controller.formatDate(
                                controller.dialogCalendarPickerValue.value[1]),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          decoration: TextDecoration.underline,
                        ),
                      );
                    }),
                  )),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: 100,
            itemBuilder: (context, index) {
              return ItemTransaction();
            },
          ),
        )
      ],
    )));
  }
}

// 🎨 Vẽ border theo đúng hình cắt vào
class TicketBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double radius = 16;
    double cutRadius = 15;
    double cutPosition = size.height * 0.66; // Vị trí khuyết (có thể thay đổi)

    Paint paint = Paint()
      ..color = Color(0xFFD0D0D0)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    Path path = Path();
    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);
    path.lineTo(size.width, cutPosition - cutRadius);
    path.arcToPoint(Offset(size.width, cutPosition + cutRadius),
        radius: Radius.circular(cutRadius), clockwise: false);
    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
        size.width, size.height, size.width - radius, size.height);
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);
    path.lineTo(0, cutPosition + cutRadius);
    path.arcToPoint(Offset(0, cutPosition - cutRadius),
        radius: Radius.circular(cutRadius), clockwise: false);
    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ItemTransaction extends StatelessWidget {
  const ItemTransaction({super.key});

  @override
  Widget build(Object context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: SizedBox(
          width: 305,
          height: 192,
          child: CustomPaint(
              painter: TicketBorderPainter(),
              child: Column(
                children: [
                  Padding(
                      padding:
                          EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () {},
                              child: Icon(
                                Icons.call,
                                color: Color(0xFF733DF2),
                                size: 20,
                              )),
                          Expanded(
                            child: Text(
                              "Phòng khám ABC",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF22313F),
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.bold), // Căn giữa văn bản
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.cancel,
                              color: Color(0xFFE64B4B),
                              size: 20,
                            ),
                          ),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "Khang Nguyễn",
                          style: TextStyle(
                            color: Color(0xFF22313F),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.start, // Đưa chữ về bên phải
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Trần Kinh Thành",
                          style: TextStyle(
                            color: Color(0xFF22313F),
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.end, // Đưa chữ về bên trái
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "Khách hàng",
                          style: TextStyle(
                            color: Color(0xFFD0D0D0),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.start, // Đưa chữ về bên phải
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Bác sĩ",
                          style: TextStyle(
                            color: Color(0xFFD0D0D0),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.end, // Đưa chữ về bên trái
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "8:00 - 8:30 Sáng",
                          style: TextStyle(
                            color: Color(0xFF22313F),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center, // Đưa chữ về bên phải
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          "03/02/2024 - hôm nay khám",
                          style: TextStyle(
                            color: Color(0xFFD0D0D0),
                            fontWeight: FontWeight.normal,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center, // Đưa chữ về bên phải
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, top: 7, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                              child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            // dashLength: 1.0,
                            dashColor: Color(0xFFD0D0D0),
                            // dashGradient: [Colors.red, Colors.blue],
                            dashRadius: 0.0,
                            // dashGapLength: 1.0,
                            dashGapColor: Colors.transparent,
                            // dashGapGradient: [Colors.red, Colors.blue],
                            dashGapRadius: 0.0,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Dịch vụ: Tim mạch",
                              style: TextStyle(color: Color(0xFFD0D0D0)),
                            ),
                          ),
                          Expanded(
                              child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            // dashLength: 1.0,
                            dashColor: Color(0xFFD0D0D0),
                            // dashGradient: [Colors.red, Colors.blue],
                            dashRadius: 0.0,
                            // dashGapLength: 1.0,
                            dashGapColor: Colors.transparent,
                            // dashGapGradient: [Colors.red, Colors.blue],
                            dashGapRadius: 0.0,
                          )),
                        ],
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF0064D2),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Tiếp nhận",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.verified,
                              color: Colors.white,
                            )
                          ]),
                    ),
                  ])
                ],
              ))),
    );
  }
}

class SearchInput extends StatelessWidget {
  const SearchInput({super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(
        fontSize: 14,
        fontFamily: 'Inter',
      ),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFF808080),
              width: 1,
            )),
        contentPadding: EdgeInsets.symmetric(
          vertical: 10,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF0064D2), width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Transform.translate(
            offset: Offset(0, 0),
            child: SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                icon: Icon(
                  Icons.badge,
                  color: Color(0xFF0064D2),
                ),
                onPressed: () {},
              ),
            )),
      ),
    );
  }
}
