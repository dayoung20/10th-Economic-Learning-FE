import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPageController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;
  var quizData = {}.obs;
  var isCorrect = true.obs;
  var explanation = "".obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }

  void stopBtn() {
    Get.back();
  }

  // 퀴즈 데이터 가져오기
  Future<void> fetchQuizById(int quizId) async {
    try {
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

  // 퀴즈 제출
  Future<void> postSubmitQuiz(int quizId, int answerIndex) async {
    try {
      print("start quizId : $quizId");
      dynamic response =
          await remoteDataSource.postSubmitQuiz(quizId, answerIndex);

      final data = response as Map<String, dynamic>;

      isCorrect.value = data['results']['isCorrect'];
      explanation.value = data['results']['explanation'];

      print("result : ${isCorrect.value}, $explanation");
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
