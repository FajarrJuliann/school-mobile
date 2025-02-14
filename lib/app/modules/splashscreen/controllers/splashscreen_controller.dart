import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Delay 3 detik
    Get.offNamed(Routes.HOME); // Navigasi ke halaman daftar sekolah
  }
}
