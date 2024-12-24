import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// class TestController extends GetxController {
//   late BuildContext context;
//   static TestController get to => Get.find();

//   void getStats() {
//     // 통계 데이터 로드 또는 초기화 작업
//     print("Stats initialized!");
//   }

//   void clickedtestBtn(BuildContext context) {
//     Get.offAllNamed('/onboarding');
//   }

//   // void clickedTestBtn(BuildContext context) {
//   //   context.go('/test');
//   // }
// }
class TestController extends GetxController {
  late BuildContext context;
  static TestController get to => Get.find();
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    context.go('/test');
  }

  void clickedTestMultiBtn(BuildContext context) {
    context.go('/test/multi');
  }

  void clickedAfterBtn(BuildContext context) {
    context.go('/login');
  }
}
