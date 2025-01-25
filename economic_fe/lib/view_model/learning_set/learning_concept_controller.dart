import 'package:economic_fe/view/screens/finish_page.dart';
import 'package:economic_fe/view/screens/learning_set/learning_concept_page.dart';
import 'package:economic_fe/view/screens/learning_set/learning_list_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class LearningConceptController extends GetxController {
  List<String> level = ["초급", "중급", "고급"];
  var currentStepIdx = (0).obs;
  var selectedIndex = (-1).obs;
  void clickedBottomBtn(BuildContext context) {
    Get.to(() => LearningConceptPage(currentStep: currentStepIdx));
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  // 학습 완료 창으로 이동
  void clickedFinishBtn(BuildContext context) {
    // Get.to(() => const LearningListPage());
    Get.to(() => const FinishPage(), arguments: {
      'contents': '학습 주제',
      'number': 1,
      'category': 0,
      'level': level,
    });
  }

  void clickedCloseBtn(BuildContext context) {
    Get.offNamed('/learning_list');
  }

  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }
}
