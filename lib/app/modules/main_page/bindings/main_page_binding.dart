import 'package:get/get.dart';
import 'package:school_mobile/app/modules/dashboard/controllers/dashboard_controller.dart';

import '../controllers/main_page_controller.dart';

class MainPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainPageController>(
      () => MainPageController(),
    );
    Get.put(DashboardController());
  }
}
