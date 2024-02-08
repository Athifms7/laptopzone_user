import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laptopzone_user/constants/constants.dart';
import 'package:laptopzone_user/view/navigation/navigation_bar.dart';
import 'package:lottie/lottie.dart';

class Success extends StatelessWidget {
  const Success({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await Future.delayed(const Duration(seconds: 2));
      Get.offAll(const NavBar());
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: kwhite,
        appBar: AppBar(
          backgroundColor: kwhite,
          elevation: 0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    width: 200,
                    child:
                        Lottie.asset('assets/images/animation_lkl1lfzx.json'),
                  ),
                  const Text(
                    'Order Successful',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
