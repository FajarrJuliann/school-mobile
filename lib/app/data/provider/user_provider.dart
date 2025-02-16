import 'package:get/get.dart';
import 'package:school_mobile/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';

class UserProvider extends GetConnect {
  final String baseUrl1 = 'http://10.0.2.2:8000/api';

  Future<UserModel?> login(String email, String password) async {
    final response = await post(
      '$baseUrl1/login',
      {
        'email': email,
        'password': password,
      },
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == HttpStatus.ok) {
      final body = response.body;

      if (body['success'] == true) {
        final user = UserModel.fromJson(body['user']);
        final token = body['token'];

        // Simpan token ke SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', token);

        // print("✅ Login Berhasil: ${user.username}, Role: ${user.role}");

        return user;
      } else {
        throw Exception("Login gagal: ${body['message']}");
      }
    } else {
      throw Exception("Login gagal: ${response.statusText}");
    }
  }

  Future<bool> register(
      String username, String email, String password, int role) async {
    final response = await post(
      '$baseUrl1/register',
      {
        'username': username,
        'email': email,
        'password': password,
        'role': role,
      },
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == HttpStatus.created) {
      final body = response.body;
      if (body['success'] == true) {
        // print("✅ Register Berhasil: $username");
        return true;
      } else {
        throw Exception("Register gagal: ${body['message']}");
      }
    } else {
      throw Exception("Register gagal: ${response.statusText}");
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    if (token == null) {
      // print("⚠ Tidak ada token yang ditemukan, mungkin sudah logout");
      return;
    }

    final response = await post(
      '$baseUrl1/logout',
      {},
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      final body = response.body;

      if (body['success'] == true) {
        await prefs.remove('token'); // Hapus token dari SharedPreferences
        // print("🚪 Logout Berhasil: Token dihapus");
      } else {
        // print("❌ Logout gagal: ${body['message']}");
        Get.snackbar("❌ Logout gagal", "${body['message']}");
      }
    } else {
      // print("❌ Logout gagal: ${response.statusText}");
      Get.snackbar("❌ Logout gagal", " ${response.statusText}");
    }
  }
}
