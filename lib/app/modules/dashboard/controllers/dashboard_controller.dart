import 'package:get/get.dart';
import 'package:school_mobile/app/data/provider/sekolah_provider.dart';
import '../../../data/models/sekolah_model.dart';

class DashboardController extends GetxController {
  var isLoading = true.obs;
  var sekolahList = <Sekolah>[].obs;
  final SekolahProvider provider = SekolahProvider();

  @override
  void onInit() {
    fetchTopSekolah(); // Ambil max 5 sekolah saat init
    super.onInit();
  }

  void fetchTopSekolah() async {
    try {
      isLoading(true);
      var data = await provider.fetchSekolah();
      sekolahList.assignAll(data.take(5).toList()); // Ambil max 5 data
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  void fetchSekolahByBentuk(String bentuk) async {
    try {
      isLoading(true);
      var data = await provider.fetchSekolahByBentuk(bentuk);
      sekolahList.assignAll(data); // Perbarui list dengan data dari API
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
