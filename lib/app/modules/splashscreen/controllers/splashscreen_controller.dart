import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToNextPage();
  }

  void _navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 3)); // Delay 3 detik

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token'); // Cek apakah token ada

    if (token != null && token.isNotEmpty) {
      Get.offNamed(Routes.MAIN_PAGE); // Jika sudah login, ke MainPage
    } else {
      Get.offNamed(Routes.HOME); // Jika belum login, ke LoginPage
    }
  }
}
