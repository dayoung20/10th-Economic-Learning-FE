import 'dart:convert';

import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LevelTestTestController extends GetxController {
  late BuildContext context;
  final remoteDataSource = RemoteDataSource();
  LevelTestTestController get to => Get.find();

  // 레벨테스트 사용자 답
  var levelTestAnswers = <LevelTestAnswerModel>[].obs;

  // 현재 학습 문제 번호
  var currentQuizIdx = 0.obs;

  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }

  void getStats() {
    print("Stats initialized!");
  }

  Future<List<QuizModel>> getLevelTest() async {
    try {
      print("start");
      dynamic response = await RemoteDataSource.getLevelTest();

      print("response ::: $response");

      final data = response as Map<String, dynamic>;
      final quizList = data['results']['quizList'] as List;
      return quizList.map((quiz) => QuizModel.fromJson(quiz)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  void clickedFinishBtn() async {
    // List<Map<String, dynamic>> answersJson =
    //     levelTestAnswers.map((answer) => answer.toJson()).toList();
    // API 요청 시 보낼 JSON 데이터 변환

    // -> jsonEncode(requestBody) 보내는 형식 맞춤
    // Map<String, dynamic> requestBody = {
    //   "answers": levelTestAnswers.map((e) => e.toJson()).toList()
    // };

    // // 변환된 데이터 출력
    // print("변환된 데이터 : ${jsonEncode(requestBody)}"); // JSON 문자열로 변환하여 확인
    // print("변환된 데이터2 : $requestBody");

    // 아래 형태로 보내면 됨
    List<Map<String, dynamic>> answersJson =
        levelTestAnswers.map((e) => e.toJson()).toList();

    try {
      print("start");
      dynamic response =
          await remoteDataSource.postLevelTestResult(answersJson);

      print("response : $response");
    } catch (e) {
      debugPrint("error : $e");
    }

    // print("response : : $response");
  }

  void clickedToKaKao() {
    // List<Map<String, dynamic>> answersJson =
    //     levelTestAnswers.map((e) => e.toJson()).toList();

    Get.toNamed('/login_exist', arguments: levelTestAnswers);
  }
}
