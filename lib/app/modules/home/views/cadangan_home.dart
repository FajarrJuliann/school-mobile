// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:school_mobile/app/data/utils/color.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<bool> checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool firstTime = prefs.getBool('firstTime') ?? true;
    if (firstTime) {
      await prefs.setBool('firstTime', false);
    }
    return firstTime;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: checkFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.data == false) {
          Future.microtask(() => Get.offNamed(Routes.LOGIN));
          return SizedBox();
        }
        return buildOnboarding();
      },
    );
  }

  Widget buildOnboarding() {
    return Scaffold(
      body: IntroductionScreen(
        globalBackgroundColor: mainColor,
        pages: [
          PageViewModel(
            title: "Welcome to School App",
            body:
                "An application to easily manage school data and assist users in finding and applying to schools.",
            image: Center(
              child: Lottie.asset(
                "assets/lotties/onboard1.json",
                width: 250,
                height: 250,
              ),
            ),
            decoration: pageDecoration(),
          ),
          PageViewModel(
            title: "Data Management",
            body:
                "Securely and efficiently manage school information like a marketplace.",
            image: Center(
              child: Lottie.asset(
                "assets/lotties/onboard2.json",
                width: 250,
                height: 250,
              ),
            ),
            decoration: pageDecoration(),
          ),
          PageViewModel(
            title: "Get Started!",
            body: "Click the button below to begin your journey.",
            image: Center(
              child: Lottie.asset(
                "assets/lotties/onboard3.json",
                width: 250,
                height: 250,
              ),
            ),
            decoration: pageDecoration(),
          ),
        ],
        onDone: () => Get.offNamed(Routes.LOGIN),
        showSkipButton: true,
        skip: Text(
          "Skip",
          style: TextStyle(
              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        next: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade700]),
            borderRadius: BorderRadius.circular(10),
          ),
          child:
              Text("Next", style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
        done: Text(
          "Done",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        dotsDecorator: DotsDecorator(
          size: Size(10.0, 10.0),
          color: Colors.white.withOpacity(0.5),
          activeSize: Size(22.0, 10.0),
          activeColor: Colors.white,
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
      ),
    );
  }

  PageDecoration pageDecoration() {
    return PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      bodyTextStyle: TextStyle(fontSize: 16.0, color: Colors.white),
      imagePadding: EdgeInsets.all(20),
      pageColor: mainColor,
      imageFlex: 3, // Adjust image proportion
      bodyFlex: 3, // Adjust text proportion
    );
  }
}
