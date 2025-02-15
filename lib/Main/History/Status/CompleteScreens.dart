import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:kiwi_admin/Main/History/HistoryController.dart';
import 'package:kiwi_admin/Main/History/Status/CompleteScreensController.dart';
import 'package:kiwi_admin/Utility/Utility.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';

class CompleteHistoryScreens extends StatelessWidget {
  const CompleteHistoryScreens({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CompleteScreensController());
    controller.getAllData(3);
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
          child: Obx(() {
            return RefreshIndicator(
              color: Color(0xFF0064D2),
              onRefresh: () async {
                var end_date = DateFormat('yyyy-MM-dd')
                    .format(controller.dialogCalendarPickerValue.value[1]);
                var start_date = DateFormat('yyyy-MM-dd')
                    .format(controller.dialogCalendarPickerValue.value[0]);
                await controller.getDataTransaction(start_date, end_date, 3);
              },
              child: controller.isLoading.value
                  ? ListView.builder(
                      padding: const EdgeInsets.all(20),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ItemTransactionSkeleton();
                      },
                    )
                  : controller.itemsComplete.isEmpty
                      ? Center(
                          child: Column(
                          children: [
                            Lottie.asset('assets/gif/data_not_found.json',
                                fit: BoxFit.contain),
                            Text(
                              "Không có dữ liệu",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () async {
                                  var end_date = DateFormat('yyyy-MM-dd')
                                      .format(controller
                                          .dialogCalendarPickerValue.value[1]);
                                  var start_date = DateFormat('yyyy-MM-dd')
                                      .format(controller
                                          .dialogCalendarPickerValue.value[0]);
                                  await controller.getDataTransaction(
                                      start_date, end_date, 3);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFF0064D2),
                                  elevation: 0,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                  ),
                                ),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tải lại",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        Icons.loop,
                                        color: Colors.white,
                                      )
                                    ]),
                              ),
                            )
                          ],
                        ))
                      : ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: controller.itemsComplete.length,
                          itemBuilder: (context, index) {
                            final item = controller.itemsComplete[index];
                            return ItemTransaction(item: item);
                          },
                        ),
            );
          }),
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

class ItemTransactionSkeleton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final utility = UtilityController.instance;
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
                                color: Color(0xFF0064D2),
                                size: 20,
                              )),
                          Expanded(
                              child: SizedBox(
                            height: 14,
                            width: 100,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          )),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                          child: SizedBox(
                        height: 14,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 100),
                      Expanded(
                          child: SizedBox(
                        height: 14,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )),
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
                    padding: EdgeInsets.only(left: 5, right: 5, bottom: 5),
                    child: Row(children: [
                      SizedBox(width: 90),
                      Expanded(
                          child: SizedBox(
                        height: 14,
                        child: Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      )),
                      SizedBox(width: 90),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      SizedBox(width: 150),
                      Expanded(
                        child: SizedBox(
                          height: 14,
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 150),
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
                              child: Row(
                                children: [
                                  Text(
                                    "Dịch vụ: ",
                                    style: TextStyle(color: Color(0xFFD0D0D0)),
                                  ),
                                  SizedBox(
                                    width: 50,
                                    height: 14,
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
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
                      onPressed: null,
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
                              "Đang xử lý",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.cached,
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

class ItemTransaction extends StatelessWidget {
  const ItemTransaction({super.key, this.item});
  final dynamic item;

  @override
  Widget build(Object context) {
    final utility = UtilityController.instance;
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
                                color: Color(0xFF0064D2),
                                size: 20,
                              )),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              utility
                                  .formatNameClinic(item["clinic_id"]["label"]),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Color(0xFF22313F),
                                  fontSize: 14,
                                  fontWeight:
                                      FontWeight.bold), // Căn giữa văn bản
                            ),
                          ),
                          SizedBox(width: 10),
                        ],
                      )),
                  Padding(
                    padding: EdgeInsets.only(left: 5, right: 5),
                    child: Row(children: [
                      Expanded(
                        child: Text(
                          item["patient_id"]["label"],
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
                          item["doctor_id"]["label"],
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
                          utility.formatTime(item["appointment_start_time"] +
                              " - " +
                              item["appointment_end_time"]),
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
                          utility.formatDate(item["appointment_start_date"]),
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
                            dashColor: Color(0xFFD0D0D0),
                            dashRadius: 0.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          )),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              "Dịch vụ: " + item["all_services"] ?? "Mặc định",
                              style: TextStyle(color: Color(0xFFD0D0D0)),
                            ),
                          ),
                          Expanded(
                              child: DottedLine(
                            direction: Axis.horizontal,
                            alignment: WrapAlignment.center,
                            lineLength: double.infinity,
                            lineThickness: 1.0,
                            dashColor: Color(0xFFD0D0D0),
                            dashRadius: 0.0,
                            dashGapColor: Colors.transparent,
                            dashGapRadius: 0.0,
                          )),
                        ],
                      )),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 65, 180, 37),
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                      ),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              utility.getStatusText(item["status"]),
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
