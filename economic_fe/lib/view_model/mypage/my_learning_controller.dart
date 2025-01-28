import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // 탭별 데이터
  final List<Map<String, dynamic>> quizzes = [
    {'category': '금융', 'title': '저축과 이자'},
    {'category': '경제', 'title': '수요와 공급'},
  ];

  final List<Map<String, dynamic>> learningMaterials = [
    {'category': '금융', 'title': '주식의 기초'},
    {'category': '경제', 'title': '물가와 환율'},
  ];

  final List<Map<String, dynamic>> incorrectQuestions = [
    {'category': '금융', 'title': '복리 계산'},
    {'category': '경제', 'title': 'GDP와 GNI'},
  ];

  // 현재 선택된 탭 데이터
  RxList<Map<String, dynamic>> currentData = <Map<String, dynamic>>[].obs;

  // 현재 선택된 레벨
  RxString selectedLevel = '초급'.obs;

  // 버튼 텍스트
  RxString buttonText = '스크랩 한 모든 퀴즈 다시 풀기'.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    // 초기 데이터 설정
    updateCurrentData(0);

    // 탭 변경 시 데이터와 버튼 텍스트 업데이트
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        updateCurrentData(tabController.index);
      }
    });
  }

  void updateCurrentData(int index) {
    switch (index) {
      case 0:
        currentData.assignAll(quizzes);
        buttonText.value = '스크랩 한 모든 퀴즈 다시 풀기';
        break;
      case 1:
        currentData.assignAll(learningMaterials);
        buttonText.value = '스크랩 한 모든 학습 다시 보기';
        break;
      case 2:
        currentData.assignAll(incorrectQuestions);
        buttonText.value = '틀린 모든 문제 다시 풀기';
        break;
    }
  }

  void updateSelectedLevel(String level) {
    selectedLevel.value = level;
  }
}
