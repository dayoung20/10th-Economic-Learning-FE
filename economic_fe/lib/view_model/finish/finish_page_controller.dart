import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishPageController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  var isLoading = true.obs;
  var learningProgress = <String, dynamic>{}.obs;
  var shouldShowFinishLayout = true.obs; // 기본적으로 FinishLayout 표시

  @override
  void onInit() {
    super.onInit();
    fetchLearningProgressStatus();
  }

  /// 학습 진행 상태 조회 및 UI 결정
  Future<void> fetchLearningProgressStatus() async {
    try {
      isLoading.value = true;

      // API 호출
      var progressData = await _remoteDataSource.fetchTodayQuestProgress();

      if (progressData.isNotEmpty) {
        learningProgress.assignAll(progressData);

        // 모든 학습 진행 상태가 100이면 FinishLayout 대신 다른 화면 표시
        bool allCompleted = progressData.values.every((value) => value == 100);
        shouldShowFinishLayout.value = !allCompleted;
      }
    } catch (e) {
      debugPrint("fetchTodayQuestProgress() 오류 발생: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
