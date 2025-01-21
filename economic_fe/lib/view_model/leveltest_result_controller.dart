import 'package:get/get.dart';

class LevelTestResultController extends GetxController {
  // 카카오로 시작하기 화면으로 전환
  void navigateToLogin() {
    // context.go('/profile_setting');
    Get.toNamed('/login');
  }

  // 홈 화면으로 이동
  void toHome() {
    Get.toNamed('/home');
  }

  // 모달창의 상태를 관리하는 변수
  var isModalVisible = false.obs;

  // 모달창 열기
  void showModal() {
    isModalVisible.value = true;
  }

  // 모달창 닫기
  void hideModal() {
    isModalVisible.value = false;
  }
}
