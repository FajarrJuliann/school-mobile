import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/data/provider/sekolah_provider.dart';
import '../../../data/models/sekolah_model.dart';

class ListSekolahController extends GetxController {
  var isLoading = true.obs;
  var sekolahList = <Sekolah>[].obs;
  final SekolahProvider provider = SekolahProvider();
  TextEditingController searchController =
      TextEditingController(); // Controller untuk input search

  @override
  void onInit() {
    fetchSekolah();
    super.onInit();
  }

  void fetchSekolah({String search = ''}) async {
    try {
      isLoading(true);
      var data = await provider.fetchSekolah(search: search);
      sekolahList.assignAll(data);
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  // Fungsi untuk menangani perubahan teks di pencarian
  void onSearchChanged(String searchText) {
    fetchSekolah(search: searchText);
  }
}
