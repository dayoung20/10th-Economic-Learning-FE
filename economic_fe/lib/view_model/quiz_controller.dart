import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizController extends GetxController {
  late BuildContext context;
  static QuizController get to => Get.find();
  var selectedNumber = (-1).obs;
  var isCorrectAnswer = 0; // 정답인지 아닌지 0 : 선택X, 1: 정답, 2: 오답
  var clickCheckBtn = false; // 확인 버튼이 클릭되었는지
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    context.go('/home/learning_list/quiz_level/quiz');
  }

  void clickedTestMultiBtn(BuildContext context) {
    context.go('/test/ox');
    // context.go('/test/multi');
  }

  void clickedAfterBtn(BuildContext context) {
    context.go('/login');
  }
}
