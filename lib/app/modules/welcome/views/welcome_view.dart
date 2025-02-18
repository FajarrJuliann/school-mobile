import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';
import 'package:school_mobile/app/data/utils/color.dart';
import '../controllers/welcome_controller.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [mainColor, Colors.blue.shade900],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Bounce(
              infinite: true,
              child: Lottie.asset(
                "assets/lotties/hi.json",
                width: 220,
                height: 220,
              ),
            ),
            const SizedBox(height: 20),
            FadeInDown(
              child: const Text(
                'Welcome!',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            FadeInUp(
              child: Obx(() {
                String roleName = getRoleName(controller.role.value);
                return Text(
                  "${controller.username.value.toUpperCase()} | $roleName", // Menampilkan Username + Role
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Fungsi untuk mengubah role ID menjadi nama peran
  String getRoleName(int role) {
    switch (role) {
      case 0:
        return "Super Admin";
      case 1:
        return "Admin";
      case 2:
        return "Guest";
      default:
        return "User";
    }
  }
}
