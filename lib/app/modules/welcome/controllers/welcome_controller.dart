import 'package:get/get.dart';
import 'package:school_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:school_mobile/app/routes/app_pages.dart';

class WelcomeController extends GetxController {
  var username = ''.obs;
  var role = 0.obs; // Tambahkan role

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    navigateToDashboard();
  }

  void fetchUserData() {
    final loginController =
        Get.find<LoginController>(); // Ambil LoginController
    username.value = loginController.user.value?.username ?? 'Pengguna';
    role.value = loginController.user.value?.role ?? 0; // Ambil role
  }

  void navigateToDashboard() async {
    await Future.delayed(const Duration(seconds: 5));
    Get.offNamed(Routes.MAIN_PAGE); // Pindah ke Dashboard setelah 5 detik
  }
}
