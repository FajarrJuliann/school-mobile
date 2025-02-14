import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

import 'package:school_mobile/app/data/provider/sekolah_provider.dart';

void main() {
  Get.put(SekolahProvider());
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: Routes.SPLASHSCREEN,
      getPages: AppPages.routes,
    ),
  );
}
