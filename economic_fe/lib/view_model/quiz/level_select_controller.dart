import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LevelSelectController extends GetxController {
  late BuildContext context;
  static LevelSelectController get to => Get.find();
  var selectedLevel = '';
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    context.go('/test');
  }

  void clickedQuizBtn(BuildContext context) {
    context.go('/learning_list/quiz_level/quiz');
  }
}
