import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
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

  // 해설 화면으로 이동
  void toAnswer(Map<String, dynamic> response,
      List<LevelTestAnswerModel> answers, List<QuizModel> quizList) {
    print("널 아님");
    Get.toNamed(
      '/leveltest_result/answer',
      arguments: {
        'response': response,
        'answer': answers,
        'quizList': quizList,
      },
    );
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
