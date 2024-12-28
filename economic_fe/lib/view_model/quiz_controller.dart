import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizController extends GetxController {
  late BuildContext context;
  static QuizController get to => Get.find();
  var selectedNumber = (-1).obs;
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    context.go('/test');
  }

  // void clickedTestMultiBtn(BuildContext context) {
  //   context.go('/test/multi');
  // }
  void clickedTestMultiBtn(BuildContext context) {
    context.go('/test/ox');
    // context.go('/test/multi');
  }

  void clickedAfterBtn(BuildContext context) {
    context.go('/login');
  }
}
