import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // 완료된 학습 및 퀴즈 갯수 저장
  var beginnerCompletedCount = 0.obs;
  var intermediateCompletedCount = 0.obs;
  var advancedCompletedCount = 0.obs;
  var totalConceptCompletedCount = 0.obs;
  var quizCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserCompleted();
  }

  /// 서버에서 유저가 완료한 학습/퀴즈 갯수 가져오기
  Future<void> fetchUserCompleted() async {
    try {
      var response = await remoteDataSource.fetchUserCompleted();

      if (response.isNotEmpty) {
        beginnerCompletedCount.value = response['beginnerCompletedCount'] ?? 0;
        intermediateCompletedCount.value =
            response['intermediateCompletedCount'] ?? 0;
        advancedCompletedCount.value = response['advancedCompletedCount'] ?? 0;
        totalConceptCompletedCount.value =
            response['totalConceptCompletedCount'] ?? 0;
        quizCount.value = response['quizCount'] ?? 0;

        debugPrint("학습 완료 데이터 불러오기 성공: $response");
      } else {
        debugPrint("학습 완료 데이터가 없습니다.");
      }
    } catch (e) {
      debugPrint("fetchUserCompleted() 오류 발생: $e");
    }
  }

  // 학습 목록으로 돌아가기
  void toLearningList() {
    Get.toNamed('/learning_list');
  }

  // 퀴즈 풀러 가기
  void toQuiz() {
    Get.toNamed('/learning_list');
  }

  // 기사 읽으러 가기
  void toArticle() {
    Get.toNamed('/article');
  }

  // 뒤로 가기
  void goBack() {
    Get.back();
  }
}
