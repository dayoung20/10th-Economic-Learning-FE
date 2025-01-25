import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LevelSelectController extends GetxController {
  late BuildContext context;
  static LevelSelectController get to => Get.find();
  var selectedLevel = '';
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    Get.toNamed('/test');
  }

  void clickedQuizBtn(BuildContext context) {
    Get.toNamed('/learning_list/quiz_level/quiz');
  }
}
