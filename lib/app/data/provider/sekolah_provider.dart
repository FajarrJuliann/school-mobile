import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/sekolah_model.dart';

class SekolahProvider extends GetConnect {
  final String baseUrl1 = 'http://10.0.2.2:8000/api';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token'); // Ambil token dari SharedPreferences
  }

  Future<List<Sekolah>> fetchSekolah({String search = ''}) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token tidak ditemukan, harap login ulang.");
    }

    final response = await get(
      '$baseUrl1/sekolah?search=$search',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null && response.body['data'] != null) {
        return (response.body['data'] as List)
            .map((e) => Sekolah.fromJson(e))
            .toList();
      } else {
        return []; // Return list kosong jika data tidak tersedia
      }
    } else {
      throw Exception("Gagal mengambil data sekolah: ${response.statusCode}");
    }
  }

  Future<Sekolah> fetchDetailSekolah(int id) async {
    final token = await _getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Token tidak ditemukan, harap login ulang.");
    }

    final response = await get(
      '$baseUrl1/sekolah/$id',
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == HttpStatus.ok) {
      if (response.body != null && response.body['data'] != null) {
        return Sekolah.fromJson(response.body['data']);
      } else {
        throw Exception("Data sekolah tidak ditemukan.");
      }
    } else {
      throw Exception("Gagal mengambil detail sekolah: ${response.statusCode}");
    }
  }
}
