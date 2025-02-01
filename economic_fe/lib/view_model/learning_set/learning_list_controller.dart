import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/models/learning_list_model.dart';
import 'package:economic_fe/data/models/learning_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class LearningListController extends GetxController {
  //각 아이템의 퀴즈, 개념학습 수행 여부
  var learningState = {
    0: [false, false],
    1: [false, false],
    2: [false, false],
    3: [false, false],
    4: [false, false],
    5: [false, false],
    6: [false, false],
    7: [false, false],
    8: [false, false],
    9: [false, false],
    10: [false, false],
  }.obs;
  // 각 아이템의 클릭 여부를 저장할 상태 변수
  var selectedItemIndex = (-1).obs; // 초기값으로 -1을 설정하여 아무 것도 선택되지 않음을 나타냄

  // 아이템 클릭 시 선택된 아이템의 인덱스를 업데이트
  void toggleItemSelection(int index) {
    if (selectedItemIndex.value == index) {
      selectedItemIndex.value = -1; // 다시 선택을 취소하면 -1로 초기화
    } else {
      selectedItemIndex.value = index; // 선택된 아이템의 인덱스를 저장
    }
  }

  // 홈화면으로 전환
  void navigateToHome(BuildContext context) {
    Get.offNamed('/home');
  }

  void clickedLearningConcept(BuildContext context) {
    Get.offNamed('/learning_list/learning_concept');
  }

  // 챗봇 화면으로 전환
  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  Future<List<LearningModel>> getLearningConcept(
      int learningSetId, String level) async {
    try {
      print("start");

      dynamic response;

      response =
          await RemoteDataSource.getLearningConcept(learningSetId, level);

      print("response :: $response");

      final data = response as Map<String, dynamic>;
      final conceptList = data['results']['conceptList'] as List;

      print("conceptList ::: $conceptList");

      return conceptList
          .map((concept) => LearningModel.fromJson(concept))
          .toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  Future<List<LearningListModel>> postLearningSet() async {
    try {
      print("start");

      dynamic response;
      response = await RemoteDataSource.postLearningSet();

      print("learning set : $response");

      final data = response as Map<String, dynamic>;
      final learningList = data['results']['learningSetPreviewList'] as List;

      // print(learningList);
      return learningList
          .map((learningSet) => LearningListModel.fromJson(learningSet))
          .toList();
    } catch (e) {
      debugPrint("Error : $e");
      return [];
    }
  }
}
