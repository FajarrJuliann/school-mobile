import 'package:get/get.dart';

import '../controllers/sekolah_detail_controller.dart';

class SekolahDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SekolahDetailController>(
      () => SekolahDetailController(),
    );
  }
}
