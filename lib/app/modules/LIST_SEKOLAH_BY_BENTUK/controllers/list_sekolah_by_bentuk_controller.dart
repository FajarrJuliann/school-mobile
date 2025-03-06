import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/data/models/sekolah_model.dart';
import 'package:school_mobile/app/data/provider/sekolah_provider.dart';

class ListSekolahByBentukController extends GetxController {
  var isLoading = true.obs;
  var sekolahList = <Sekolah>[].obs;
  final SekolahProvider provider = SekolahProvider();
  late String bentuk;
  TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    bentuk = Get.arguments as String; // Ambil argumen 'bentuk' dari navigasi
    fetchSekolahByBentuk();
    super.onInit();
  }

  void fetchSekolahByBentuk({String search = ''}) async {
    try {
      isLoading(true);
      var data = await provider.fetchSekolahByBentuk(bentuk, search: search);
      sekolahList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fungsi untuk menangani perubahan teks di pencarian
  void onSearchChanged(String searchText) {
    fetchSekolahByBentuk(search: searchText);
  }
}
