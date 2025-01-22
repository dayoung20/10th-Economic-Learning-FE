import 'package:get/get.dart';

class FinishController extends GetxController {
  // 학습 목록으로 돌아가기
  void toLearningList() {
    Get.toNamed('/learning_list');
  }

  // 퀴즈 풀러 가기
  void toQuiz() {
    Get.toNamed('/learning_list/quiz_level/quiz');
  }

  // 기사 읽으러 가기
  void toArticle() {
    Get.toNamed('/article');
  }

  // 뒤로 가기
  void goBack() {
    Get.back();
  }
}
