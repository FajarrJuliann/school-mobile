import 'package:get/get.dart';

import '../controllers/list_sekolah_controller.dart';

class ListSekolahBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListSekolahController>(
      () => ListSekolahController(),
    );
  }
}
