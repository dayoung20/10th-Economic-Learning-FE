import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnboardingController()..getStats());
  }

  @override
  Widget build(BuildContext context) {
    // 화면이 로드된 후 3초 뒤에 자동으로 이동
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed('/onboarding'); // '/onboarding'으로 이동
    });

    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 160.h,
            ),
            // 어플 로고
            Image.asset(
              "assets/icon.png",
              width: 65.34.w,
              height: 77.87.h,
            ),
            Text(
              "Ripple",
              style: TextStyle(
                color: const Color(0xFF111111),
                fontSize: 45,
                fontFamily: 'Palanquin',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.90.w,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              "처음 시작하는 경제 학습",
              style: TextStyle(
                color: const Color(0xFF404040),
                fontSize: 16,
                fontWeight: FontWeight.w500,
                height: 1.40.h,
                letterSpacing: -0.40.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
