import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapQuizController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  var isModalVisible = false.obs;
  var quizData = {}.obs;
  var isCorrect = false.obs;
  var explanation = "".obs;
  var selectedIndex = (-1).obs;
  var clickCheckBtn = false.obs;
  var isNextButtonEnabled = false.obs;
  var viewDescription = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }

  void stopBtn() {
    Get.back();
  }

  /// 퀴즈 상태 초기화
  void resetQuizState() {
    print("퀴즈 상태 초기화...");
    selectedIndex.value = -1;
    clickCheckBtn.value = false;
    isCorrect.value = false;
    explanation.value = "";
    isNextButtonEnabled.value = false;
    viewDescription.value = false;
  }

  Future<void> fetchQuizById(int quizId) async {
    try {
      resetQuizState();
      final response = await remoteDataSource.fetchQuizById(quizId);
      if (response != null && response['isSuccess'] == true) {
        quizData.value = response['results'];
      } else {
        print('퀴즈 데이터 로드 실패: ${response?['message']}');
      }
    } catch (e) {
      print('fetchQuizById 에러: $e');
    }
  }

  Future<void> postSubmitQuiz(int quizId, int answerIndex) async {
    try {
      clickCheckBtn.value = true;
      selectedIndex.value = answerIndex;
      dynamic response =
          await remoteDataSource.postSubmitQuiz(quizId, answerIndex);
      final data = response as Map<String, dynamic>;

      isCorrect.value = data['results']['isCorrect'];
      explanation.value = data['results']['explanation'];
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void finishQuiz() {
    Get.back(); // 이전 화면으로 돌아가기
  }
}
