import 'package:get/get.dart'; // GoRouter import

class HomeController extends GetxController {
  // 전체 학습 세트 목록 화면으로 전환
  void navigateToLearningList() {
    Get.offNamed('/learning_list');
  }
}
