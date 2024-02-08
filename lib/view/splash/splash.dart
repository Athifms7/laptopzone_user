import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/view/auth_screen/login.dart';
import 'package:laptopzone_user/view/navigation/navigation_bar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   Future.delayed(
  //     Duration(seconds: 3),
  //     () {
  //       // Navigator.pushAndRemoveUntil(
  //       //     context,
  //       //     MaterialPageRoute(
  //       //       builder: (context) => LoginScreen(),
  //       //     ),
  //       //     (route) => false);

  //     },
  //   );
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 1));
      final userLogin = FirebaseAuth.instance.currentUser;
      if (userLogin == null) {
        Get.off(const LoginScreen());
      } else {
        Get.off(const NavBar());
      }
    });
    // final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Image.asset(
          'assets/images/laptopzone-high-resolution-logo-transparent.png',
          width: width * 0.90,
        ),
      ),
    );
  }
}
