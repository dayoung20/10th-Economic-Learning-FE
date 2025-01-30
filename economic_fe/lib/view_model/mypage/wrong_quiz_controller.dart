import 'package:get/get.dart';

class WrongQuizController extends GetxController {
  // 현재 선택된 레벨
  RxString selectedLevel = '초급'.obs;

  void updateSelectedLevel(String level) {
    selectedLevel.value = level;
  }

  final List<Map<String, dynamic>> incorrectQuestions = [
    {'category': '금융', 'title': '복리 계산'},
    {'category': '경제', 'title': 'GDP와 GNI'},
  ];
}
