import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:get/get.dart';

class LevelTestResultController extends GetxController {
  // 카카오로 시작하기 화면으로 전환
  void navigateToLogin() {
    Get.toNamed('/login');
  }

  // 프로필 설정 화면으로 이동
  void toProfileSetting() {
    Get.toNamed('/profile_setting');
  }

  // 해설 화면으로 이동
  void toAnswer(Map<String, dynamic> response,
      List<LevelTestAnswerModel> answers, List<QuizModel> quizList) {
    Get.toNamed(
      '/leveltest_result/answer',
      arguments: {
        'response': response,
        'answer': answers,
        'quizList': quizList,
      },
    );
  }
}
