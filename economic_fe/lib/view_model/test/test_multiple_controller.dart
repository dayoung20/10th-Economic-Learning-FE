import 'package:get/get.dart';

class TestMultipleController extends GetxController {
  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }

  void stopLevelTestBtn() {
    Get.toNamed('/test');
  }
}
