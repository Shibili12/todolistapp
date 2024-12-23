import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todolistapp/controllers/authcontroller.dart';

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      Get.offNamed('/login');
    });

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Color(0xFF121212)
          : Colors.white,
      body: Center(
        child: Image.asset(
          Theme.of(context).brightness == Brightness.dark
              ? "assets/images/mimodark.jpg" // Image for dark mode
              : "assets/images/IMG_7655.jpg", // Image for light mode
        ),
      ),
    );
  }
}
