import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:school_mobile/app/modules/login/controllers/login_controller.dart';
import 'package:school_mobile/app/modules/profile/controllers/profile_controller.dart';

import 'app/routes/app_pages.dart';

import 'package:school_mobile/app/data/provider/sekolah_provider.dart';

void main() {
  Get.put(SekolahProvider());
  Get.put(LoginController());
  Get.put(ProfileController());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: Routes.SPLASHSCREEN,
      getPages: AppPages.routes,
    ),
  );
}
