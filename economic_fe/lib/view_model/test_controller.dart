import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TextController extends GetxController {
  late BuildContext context;
  static TextController get to => Get.find();

  // void clickedStartBtn() {
  //   Get.offAllNamed('/onboarding');
  // }

  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  // void clickedStartBtn() {
  //   Get.offAllNamed('/onboarding');
  // }

  // void clickedTestBtn(BuildContext context) {
  //   context.go('/test');
  // }
}
