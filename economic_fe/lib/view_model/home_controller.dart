import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // GoRouter import

class HomeController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // 진도율 가시성 관리 (레벨테스트 진행 여부에 따른 로직으로 수정 필요)
  var isProgressContainerVisible = true.obs;

  // 레벨테스트 시작 화면으로
  void toLevelTest() {
    Get.toNamed('/test');
  }

  // 전체 학습 세트 목록 화면으로 전환
  void navigateToLearningList() {
    Get.offNamed('/learning_list');
  }

  // 목표 선택 다이얼로그 표시 상태 관리
  var isDialogVisible = false.obs;

  void showGoalDialog() {
    isDialogVisible.value = true;
  }

  void hideGoalDialog() {
    isDialogVisible.value = false;
  }

  // 오늘의 퀘스트 목표 세트 수 (임시)
  var goalSets = [0, 3, 1].obs;
  final maxGoalSets = 3;
  final minGoalSets = 0;

  void minusGoalSets(int index) {
    if (goalSets[index] > minGoalSets) {
      goalSets[index]--;
    }
  }

  void plusGoalSets(int index) {
    if (goalSets[index] < maxGoalSets) {
      goalSets[index]++;
    }
  }

  // 진도율 (초기값은 0)
  RxDouble beginnerProgress = 0.0.obs;
  RxDouble intermediateProgress = 0.0.obs;
  RxDouble advancedProgress = 0.0.obs;

  // 최대 그래프 높이
  final double maxHeight = 120.0;

  @override
  void onInit() {
    super.onInit();
    fetchProgress();
  }

  /// 레벨별 학습 진도율 조회
  Future<void> fetchProgress() async {
    try {
      final response = await remoteDataSource.getProgress();

      if (response != null && response['isSuccess'] == true) {
        final progressData = response['results']['progress'] ?? {};

        // 서버 응답 값이 존재하면 업데이트
        beginnerProgress.value = (progressData['BEGINNER'] ?? 0.0).toDouble();
        intermediateProgress.value =
            (progressData['INTERMEDIATE'] ?? 0.0).toDouble();
        advancedProgress.value = (progressData['ADVANCED'] ?? 0.0).toDouble();

        debugPrint('학습 진도율 데이터 업데이트 완료');
      } else {
        debugPrint('fetchProgress 실패: 응답이 null이거나 isSuccess가 false');
      }
    } catch (e) {
      debugPrint('fetchProgress Error: $e');
    }
  }
}
