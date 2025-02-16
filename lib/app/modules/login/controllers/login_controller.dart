import 'package:get/get.dart';
import 'package:school_mobile/app/data/models/user_model.dart';
import 'package:school_mobile/app/data/provider/user_provider.dart';
import 'package:school_mobile/app/routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var user = Rxn<UserModel>(); // Rxn untuk user, bisa null

  final UserProvider provider = UserProvider();

  Future<void> loginUser(String email, String password) async {
    try {
      isLoading(true);
      final loggedInUser = await provider.login(email, password);
      user.value = loggedInUser; // Simpan user di state

      if (loggedInUser != null) {
        // print("🎉 User Login: ${loggedInUser.username}");
        // print("📧 Email: ${loggedInUser.email}");
        // print("🔑 Role: ${loggedInUser.role}");

        // Simpan user di GetX state
        user.value = loggedInUser;

        // Redirect ke dashboard setelah login sukses
        Get.offAllNamed(Routes.WELCOME);
      }
    } catch (e) {
      Get.snackbar("Login Gagal", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future<bool> registerUser(
      String username, String email, String password, int role) async {
    try {
      isLoading(true);
      final success = await provider.register(username, email, password, role);
      if (success) {
        // print("🎉 Registrasi Berhasil: $username");

        // Setelah register sukses, langsung login
        await loginUser(email, password);
      }
    } catch (e) {
      Get.snackbar("Registrasi Gagal", e.toString());
    } finally {
      isLoading(false);
    }
    return true;
  }
}
