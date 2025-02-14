import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../models/sekolah_model.dart';

class SekolahProvider extends GetConnect {
  final String baseUrl1 = 'http://10.0.2.2:8000/api';

  Future<List<Sekolah>> fetchSekolah({String search = ''}) async {
    final response = await get('$baseUrl1/sekolah?search=$search');
    if (response.statusCode == HttpStatus.ok) {
      return (response.body['data'] as List)
          .map((e) => Sekolah.fromJson(e))
          .toList();
    } else {
      throw Exception("Gagal mengambil data sekolah");
    }
  }

  // Fetch detail sekolah
  Future<Sekolah> fetchDetailSekolah(int id) async {
    final response = await get('$baseUrl1/sekolah/$id');
    if (response.statusCode == HttpStatus.ok) {
      return Sekolah.fromJson(response.body['data']);
    } else {
      throw Exception("Gagal mengambil detail sekolah");
    }
  }
}
