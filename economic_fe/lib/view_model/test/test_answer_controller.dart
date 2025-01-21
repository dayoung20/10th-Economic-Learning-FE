import 'package:get/get.dart';

class TestAnswerController extends GetxController {
  // 현재 선택된 문제 번호
  var currentQuestionIndex = 0.obs;

  // 각 문제의 정답 여부 (true: 정답, false: 오답)
  var answers = [true, false, true, true, false, false, true, true, false].obs;

  // 모달창 상태 관리
  var isModalVisible = false.obs;

  // 모달창 열기
  void showModal() {
    isModalVisible.value = true;
  }

  // 모달창 닫기
  void hideModal() {
    isModalVisible.value = false;
  }

  // 특정 문제 선택
  void selectQuestion(int index) {
    currentQuestionIndex.value = index;
    hideModal();
  }

  // 닫기 버튼
  void close() {
    Get.back();
  }
}
