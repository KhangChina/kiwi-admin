import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiwi_admin/Main/Home/HomeScreens.dart';
import 'package:kiwi_admin/Main/LayoutMain.dart';
import 'package:local_auth/local_auth.dart';

class ProfileController extends GetxController {
  static ProfileController get instance => Get.find();
  var isBiometricEnabled = false.obs;
  final box = GetStorage();
  Future<void> loadBiometricSetting() async {
    isBiometricEnabled.value = box.hasData('biometric_enabled');
  }

  Future<void> toggleBiometric(bool value) async {
    if (value) {
      bool authenticated = await authenticateWithBiometric();
      if (authenticated) {
        isBiometricEnabled.value = true;
        box.write('biometric_enabled', true);
        Get.snackbar("Thành công", "Đã bật đăng nhập bằng vân tay");
      } else {
        Get.snackbar("Lỗi", "Xác thực vân tay thất bại");
      }
    } else {
      isBiometricEnabled.value = false;
      box.write('biometric_enabled', false);
    }
  }

  void logout() {
    final box = GetStorage();
    box.remove('auth_token');
    Future.delayed(Duration.zero, () {
      if (Get.context != null) {
        Get.offAll(() => LayoutMainScreens()); // Điều hướng đến màn hình login
      }
    });
  }

  final LocalAuthentication _localAuth = LocalAuthentication();
  Future<bool> authenticateWithBiometric() async {
    try {
      // 🔍 Kiểm tra xem thiết bị có hỗ trợ sinh trắc học không
      bool canCheckBiometrics = await _localAuth.canCheckBiometrics;
      bool isDeviceSupported = await _localAuth.isDeviceSupported();

      if (!isDeviceSupported || !canCheckBiometrics) {
        Get.snackbar("Lỗi", "Thiết bị không hỗ trợ vân tay/Face ID!",
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      // 🔐 Hiển thị hộp thoại xác thực vân tay
      bool authenticated = await _localAuth.authenticate(
        localizedReason: "Xác thực bằng vân tay hoặc Face ID để tiếp tục",
        options: AuthenticationOptions(
          biometricOnly: true, // Chỉ dùng sinh trắc học
          stickyAuth: true, // Giữ trạng thái xác thực
          useErrorDialogs: true, // Hiển thị lỗi nếu có
        ),
      );

      return authenticated; // ✅ Trả về kết quả xác thực
    } catch (e) {
      Get.snackbar("Lỗi", "Có lỗi khi xác thực: $e",
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }
}
