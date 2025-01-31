import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiwi_admin/Clinic/ClinicController.dart';
import 'package:multi_dropdown/multi_dropdown.dart';

class ClinicScreens extends StatelessWidget {
  const ClinicScreens({super.key});
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    final controller = Get.put(ClinicController());

    return Scaffold(
        backgroundColor: Color(0xFF0064D2),
        body: SingleChildScrollView(
            child: SafeArea(
                child: Column(children: [
          navViewMiniapp(),
          clinicViewMiniApp(),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25)),
                child: ColoredBox(
                    color: Color(0xFFFFFFFF),
                    child: SizedBox(
                        width: screenWidth,
                        height: screenHeight * 0.8,
                        child: Padding(
                          padding:
                              EdgeInsets.only(left: 32, top: 32, right: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Tên phòng khám",
                                style: TextStyle(
                                    color: Color(0xFF22313F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 7),
                              clinicNameInput(),
                              SizedBox(height: 16),
                              Text(
                                "Số điện thoại liên hệ phòng khám",
                                style: TextStyle(
                                    color: Color(0xFF22313F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 7),
                              clinicPhoneInput(),
                              SizedBox(height: 16),
                              Text(
                                "Chuyên khoa",
                                style: TextStyle(
                                    color: Color(0xFF22313F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 7),
                              multiDropdownSelect(),
                              SizedBox(height: 16),
                              Text(
                                "Hình ảnh phòng khám",
                                style: TextStyle(
                                    color: Color(0xFF22313F),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 7),
                              SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: InkWell(
                                    onTap: () {
                                      controller.pickImageFromGallery();
                                    },
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8)),
                                          border: Border.all(
                                              color: Color(0xFF808080))),
                                      child: Obx(() {
                                        return controller.imageFile.value !=
                                                null
                                            ? Image.file(
                                                controller
                                                    .imageFile.value!.absolute,
                                                fit: BoxFit.cover)
                                            : Center(
                                                child: Icon(
                                                  Icons.add_a_photo_outlined,
                                                  size: 20,
                                                  color: Color(0xFF0064D2),
                                                ),
                                              );
                                      }),
                                    ),
                                  )),
                              SizedBox(height: 24),
                              ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Color(0xFF0064D2),
                                    elevation: 0,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    minimumSize: Size(double.infinity, 48),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Tạo",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontFamily: 'Inter',
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Image(
                                          image: AssetImage(
                                              'assets/images/arrow_circle_right.png'),
                                          height: 20,
                                          width: 20)
                                    ],
                                  ))
                            ],
                          ),
                        )))),
          )
        ]))));
  }
}

class clinicNameInput extends StatelessWidget {
  const clinicNameInput({super.key});
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

class clinicViewMiniApp extends StatelessWidget {
  const clinicViewMiniApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 16, right: 12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: ColoredBox(
            color: Color(0xFFFFFFFF),
            child: Row(
              children: [
                Image.asset("assets/images/onboarding_images.png",
                    height: 100, width: 100, fit: BoxFit.cover),
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phòng khám đa khoa ABC",
                        softWrap: true,
                        style: TextStyle(
                            fontFamily: "Inter",
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0D1634)),
                      ),
                      Text(
                        "Địa chỉ ABC xyz",
                        softWrap: true,
                        style: TextStyle(
                            color: Color.fromARGB(255, 179, 181, 184)),
                      ),
                      SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.stars,
                              color: Color.fromARGB(255, 255, 238, 0),
                              size: 24),
                          SizedBox(width: 4),
                          Text("5"),
                          SizedBox(width: 60),
                          Icon(Icons.play_circle_outline,
                              color: Color(0xFF0064D2), size: 24),
                          SizedBox(width: 4),
                          Text(
                            "Bật vị trí",
                            style: TextStyle(
                                fontFamily: "Inter",
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0064D2)),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

class navViewMiniapp extends StatelessWidget {
  const navViewMiniapp({super.key});
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 16, top: 12, bottom: 12),
          child: Icon(Icons.chevron_left, color: Color(0xFFFFFFFF), size: 24),
        ),
        Expanded(
            child: Center(
          child: Text(
            "Tạo phòng khám của bạn",
            style: TextStyle(
              fontFamily: "Inter",
              fontWeight: FontWeight.normal,
              fontSize: 20,
              color: Color(0xFFFFFFFF),
            ),
          ),
        )),
      ],
    );
  }
}

class multiDropdownSelect extends StatelessWidget {
  const multiDropdownSelect({super.key});
  Widget build(BuildContext context) {
    final controller = ClinicController.instance;

    return MultiDropdown(
      controller: controller.multiSelectController,
      items: controller.itemsProducts.value,
      onSelectionChange: (selectedItems) {
        // debugPrint("OnSelectionChange: $selectedItems");
      },
      fieldDecoration: FieldDecoration(
        hintText: 'Chọn chuyên khoa',
        hintStyle: const TextStyle(color: Colors.black87),
        prefixIcon: Icon(
          Icons.checklist,
          color: Color(0xFF0064D2),
        ),
        showClearIcon: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF808080)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Color(0xFF0064D2),
          ),
        ),
      ),
      chipDecoration: const ChipDecoration(
        deleteIcon: Icon(
          Icons.highlight_off,
          color: Color(0xFFFFFFFF),
          size: 16,
        ),
        backgroundColor: Color(0xFF0064D2),
        labelStyle:
            TextStyle(color: Color(0xFFFFFFFF), fontWeight: FontWeight.bold),
        wrap: true,
        runSpacing: 2,
        spacing: 10,
      ),
      searchEnabled: true,
      dropdownItemDecoration: DropdownItemDecoration(
        selectedIcon: const Icon(Icons.check_box, color: Color(0xFF0064D2)),
        disabledIcon: Icon(Icons.lock, color: Colors.grey.shade300),
      ),
    );
  }
}

class clinicPhoneInput extends StatelessWidget {
  const clinicPhoneInput({super.key});
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: TextInputType.phone,
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
                  Icons.phone,
                  color: Color(0xFF0064D2),
                ),
                onPressed: () {},
              ),
            )),
      ),
    );
  }
}
