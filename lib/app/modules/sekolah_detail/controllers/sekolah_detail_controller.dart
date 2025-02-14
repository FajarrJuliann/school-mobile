import 'package:get/get.dart';
import 'package:school_mobile/app/data/models/sekolah_model.dart';
import 'package:school_mobile/app/data/provider/sekolah_provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SekolahDetailController extends GetxController {
  var isConnected = true.obs; // Status koneksi
  var isLoading = true.obs;
  var sekolah = Sekolah(
    id: 0,
    kodeProp: '',
    propinsi: '',
    kodeKabKota: '',
    kabupatenKota: '',
    kodeKec: '',
    kecamatan: '',
    npsn: '',
    sekolah: '',
    bentuk: '',
    status: '',
    alamatJalan: '',
    lintang: '',
    bujur: '',
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    isDelete: '',
  ).obs;

  void fetchDetailSekolah(int id) async {
    try {
      isLoading(true);
      sekolah.value = await SekolahProvider().fetchDetailSekolah(id);
    } catch (e) {
      Get.snackbar("Error", "Gagal mengambil detail sekolah");
    } finally {
      isLoading(false);
    }
  }

  void checkInternetConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    // ignore: unrelated_type_equality_checks
    isConnected.value = connectivityResult != ConnectivityResult.none;

    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      isConnected.value =
          results.isNotEmpty && results.first != ConnectivityResult.none;
    });
  }

  @override
  void onInit() {
    super.onInit();
    int sekolahId = Get.arguments as int; // Ambil ID dari arguments
    Connectivity().onConnectivityChanged.listen((result) {
      // ignore: unrelated_type_equality_checks
      isConnected.value = result != ConnectivityResult.none;
    });
    fetchDetailSekolah(sekolahId);
  }
}
