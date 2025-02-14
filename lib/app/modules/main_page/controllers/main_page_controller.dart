import 'package:get/get.dart';

class MainPageController extends GetxController {
  var currentIndex = 1; // Default di halaman Dashboard

  void changePage(int index) {
    currentIndex = index;
    update(); // Untuk memperbarui UI
  }
}
