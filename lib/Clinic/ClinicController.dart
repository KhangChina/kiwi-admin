import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multi_dropdown.dart';
import 'package:permission_handler/permission_handler.dart';

class ClinicController extends GetxController {
  static ClinicController get instance => Get.find();

  final MultiSelectController<String> multiSelectController =
      MultiSelectController<String>();

  RxList<DropdownItem<String>> itemsProducts = [
    DropdownItem(label: 'Item 1', value: "1"),
    DropdownItem(label: 'Item 2', value: "2"),
    DropdownItem(label: 'Item 3', value: "32"),
  ].obs;

  RxList<String> selectedItems = <String>[].obs;

  Rx<File?> imageFile = Rx<File?>(null);

  final ImagePicker _picker = ImagePicker();

  Future<bool> requestGalleryPermission() async {
  var status = await Permission.photos.status;

  if (status.isGranted) {
    return true; // Quyền đã được cấp
  }

  if (status.isDenied || status.isRestricted) {
    // Hiển thị dialog xin quyền
    bool? result = await Get.dialog<bool>(
      AlertDialog(
        title: Text("Yêu cầu quyền truy cập"),
        content: Text("Ứng dụng cần quyền truy cập thư viện ảnh để chọn ảnh."),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("Từ chối"),
          ),
          TextButton(
            onPressed: () async {
              Get.back(result: true);
              var newStatus = await Permission.photos.request();
              if (newStatus.isGranted) {
                return;
              }
            },
            child: Text("Cho phép"),
          ),
        ],
      ),
    );

    if (result == true) {
      status = await Permission.photos.status;
    }
  }

  if (status.isPermanentlyDenied) {
    // Người dùng đã từ chối quyền vĩnh viễn => Mở cài đặt
    bool? openSettings = await Get.dialog<bool>(
      AlertDialog(
        title: Text("Quyền bị từ chối"),
        content: Text("Bạn cần cấp quyền truy cập thư viện ảnh trong Cài đặt."),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: Text("Đóng"),
          ),
          TextButton(
            onPressed: () async {
              Get.back(result: true);
              await openAppSettings(); // Mở cài đặt hệ thống
            },
            child: Text("Mở cài đặt"),
          ),
        ],
      ),
    );

    return openSettings == true;
  }

print(status.isGranted);
  return status.isGranted;
}

  Future<void> pickImageFromGallery() async {
    if (await requestGalleryPermission()) {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        imageFile.value = File(pickedFile.path);
      }
    }
  }

  // Chụp ảnh từ camera
  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }
}
