import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingCardController extends GetxController {
  late BuildContext context;
  static OnboardingCardController get to => Get.find();

  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    //context.go('/test');
    Get.toNamed('/test');
  }

  // void clickedTestMultiBtn(BuildContext context) {
  //   context.go('/test/ox');
  // }
  void clickedTestMultiBtn(BuildContext context) {
    // context.go('/test/multi');
    Get.toNamed('/test/multi');
  }

  void clickedLoginBtn(BuildContext context) {
    // context.go('/login');
    Get.toNamed('/login');
  }

  // 계정이 이미 있어요 -> 카카오 로그인
  void clickedExistBtn() {
    Get.toNamed('/login_exist');
  }
}
