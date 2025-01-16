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

  void clickedFinishBtn(BuildContext context) {
    Get.to(() => const LearningListPage());
  }

  void clickedCloseBtn(BuildContext context) {
    Get.offNamed('/learning_list');
  }
}
