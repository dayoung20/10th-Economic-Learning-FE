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

  var conceptName = "개념 학습".obs;
  var learningSetId = 0.obs; // 학습 세트 ID

  @override
  void onInit() {
    super.onInit();

    print("Get.arguments: ${Get.arguments}"); // 전달된 arguments 확인
    var selectedLevelIndex = 0.obs; // 선택된 레벨 인덱스 (초급: 0, 중급: 1, 고급: 2)

    // Get.arguments가 null인지 확인 후 학습 세트 ID와 개념 이름 가져오기
    if (Get.arguments != null) {
      learningSetId.value = Get.arguments?["learningSetId"] ?? 0;
      conceptName.value = Get.arguments?["name"] ?? "";
    } else {
      learningSetId.value = 0;
      conceptName.value = ""; // 기본값 설정
    }

    // 기본 레벨은 "초급"으로 설정
    selectedLevelIndex.value = 0;
  }

  void clickedTestBtn(BuildContext context) {
    Get.toNamed('/test');
  }

  void clickedQuizBtn(BuildContext context, int learningSetId, String name) {
    Get.toNamed(
      '/learning_list/quiz_level/quiz',
      arguments: {
        "learningSetId": learningSetId,
        "name": name,
      },
    );
  }
}
