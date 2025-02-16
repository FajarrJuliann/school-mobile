import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:school_mobile/app/data/utils/color.dart';
import 'package:school_mobile/app/modules/favorite/views/favorite_view.dart';
import '../controllers/main_page_controller.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../profile/views/profile_view.dart';

class MainPageView extends GetView<MainPageController> {
  const MainPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPageController>(
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: [
              FavoriteView(),
              DashboardView(),
              ProfileView(),
            ],
          ),
          bottomNavigationBar: CircleNavBar(
            activeIcons: [
              Icon(Icons.favorite, color: Colors.white),
              Icon(Icons.home, color: Colors.white),
              Icon(Icons.person, color: Colors.white),
            ],
            inactiveIcons: [
              Icon(Icons.favorite_border, color: Colors.white),
              Icon(Icons.home_outlined, color: Colors.white),
              Icon(Icons.person_outline, color: Colors.white),
            ],
            color: mainColor, // Warna navbar
            circleColor: mainColor, // Warna latar belakang ikon tengah
            height: 60,
            circleWidth: 55,
            activeIndex: controller.currentIndex,
            onTap: (index) {
              controller.changePage(index);
            },
            shadowColor: Colors.black,
            elevation: 10,
          ),
        );
      },
    );
  }
}
