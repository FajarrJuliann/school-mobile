import 'package:get/get.dart';

import '../controllers/list_sekolah_by_bentuk_controller.dart';

class ListSekolahByBentukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListSekolahByBentukController>(
      () => ListSekolahByBentukController(),
    );
  }
}
