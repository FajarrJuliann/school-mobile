import 'package:get/get.dart';
import 'package:school_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:school_mobile/app/routes/app_pages.dart';

class WelcomeController extends GetxController {
  var username = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsername();
    navigateToDashboard();
  }

  void fetchUsername() {
    final loginController =
        Get.find<LoginController>(); // Ambil LoginController
    username.value = loginController.user.value?.username ?? 'Pengguna';
  }

  void navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 3));
    Get.offNamed(Routes.MAIN_PAGE); // Pindah ke Dashboard setelah 3 detik
  }
}
