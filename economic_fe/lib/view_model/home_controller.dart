import 'package:get/get.dart'; // GoRouter import

class HomeController extends GetxController {
  // 진도율 가시성 관리 (레벨테스트 진행 여부에 따른 로직으로 수정 필요)
  var isProgressContainerVisible = true.obs;

  // 레벨테스트 시작 화면으로
  void toLevelTest() {
    Get.toNamed('/test');
  }

  // 전체 학습 세트 목록 화면으로 전환
  void navigateToLearningList() {
    Get.offNamed('/learning_list');
  }

  // 목표 선택 다이얼로그 표시 상태 관리
  var isDialogVisible = false.obs;

  void showGoalDialog() {
    isDialogVisible.value = true;
  }

  void hideGoalDialog() {
    isDialogVisible.value = false;
  }

  // 오늘의 퀘스트 목표 세트 수 (임시)
  var goalSets = [0, 3, 1].obs;
  final maxGoalSets = 3;
  final minGoalSets = 0;

  void minusGoalSets(int index) {
    if (goalSets[index] > minGoalSets) {
      goalSets[index]--;
    }
  }

  void plusGoalSets(int index) {
    if (goalSets[index] < maxGoalSets) {
      goalSets[index]++;
    }
  }
}
