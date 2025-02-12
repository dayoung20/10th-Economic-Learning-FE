import 'package:get/get.dart';

class TestAnswerController extends GetxController {
  // 현재 선택된 문제 번호
  var currentQuestionIndex = 0.obs;

  // 특정 문제 선택
  void selectQuestion(int index) {
    currentQuestionIndex.value = index;
    // hideModal();
  }

  // 닫기 버튼
  void close() {
    Get.back();
  }
}
