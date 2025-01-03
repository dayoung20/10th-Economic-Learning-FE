import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizController extends GetxController {
  late BuildContext context;
  static QuizController get to => Get.find();
  // var selectedNumber = (-1).obs;
  // var isCorrectAnswer = 0; // 정답인지 아닌지 0 : 선택X, 1: 정답, 2: 오답
  // var clickCheckBtn = false; // 확인 버튼이 클릭되었는지
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

  // 선택된 옵션을 관리하는 상태
  var selectedOption = Rx<int?>(null); // 선택된 옵션 (null은 선택 안 됨)

  // "다음 문제" 버튼 활성화 여부
  bool get isNextButtonEnabled => selectedOption.value != null;

  // (퀴즈의 경우) 확인 버튼 클릭 여부
  Rx<bool> clickCheckBtn = false.obs;

  // (퀴즈의 경우) 정답 여부 (1: 정답, 2: 오답)
  Rx<int> isCorrectAnswer = 0.obs;

  // (퀴즈의 경우) 북마크 상태를 관리하는 변수
  Rx<bool> isBookmarked = false.obs;

  // 선택지 변경 시 호출되는 메서드
  void selectOption(int index) {
    // 이미 선택된 옵션을 변경
    selectedOption.value = index;
  }

  // 선택된 옵션을 리셋하는 메서드 (필요 시)
  void resetOption() {
    selectedOption.value = null;
  }
}
