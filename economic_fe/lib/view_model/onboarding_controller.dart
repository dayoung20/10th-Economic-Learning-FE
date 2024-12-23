import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingController extends GetxController {
  late BuildContext context;
  static OnboardingController get to => Get.find();

  // void clickedStartBtn() {
  //   Get.offAllNamed('/onboarding');
  // }
  void clickedStartBtn(BuildContext context) {
    // GoRouter로 네비게이션
    context.go('/onboarding'); // '/onboarding' 경로로 이동
  }

  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    context.go('/test');
  }
}
