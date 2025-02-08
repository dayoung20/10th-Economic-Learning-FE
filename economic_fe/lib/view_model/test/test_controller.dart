import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestController extends GetxController {
  late BuildContext context;
  static TestController get to => Get.find();

  //레벨테스트 answer
  List<LevelTestAnswerModel> levelTestAnswerModel = [];

  void getStats() {
    print("Stats initialized!");
  }

  void test(BuildContext context) async {
    try {
      final List<QuizModel> quizList = await getLevelTest();
      Get.toNamed('test/test', arguments: quizList);
    } catch (e) {
      Get.snackbar("에러", "퀴즈를 불러오지 못했습니다");
      debugPrint("에러 발생: $e");
    }
  }

  void clickedTestBtn(BuildContext context) async {
    // Get.toNamed('/test');
    try {
      print("레벨 테스트 시작");

      final List<QuizModel> quizList = await getLevelTest();

      if (quizList.isEmpty) {
        Get.snackbar("오류", "퀴즈 데이터를 가져오지 못했습니다");
        return;
      }

      final int choiceCount = quizList.first.choiceList.length;

      // 선택지 개수가 3개 이상
      // 객관식 퀴즈 페이지로 이동
      if (choiceCount == 2) {
        Get.toNamed('test/ox', arguments: {
          "quizList": quizList,
          "index": 0,
          // "answer": levelTestAnswerModel
        });
      } else {
        Get.toNamed('/test/multi', arguments: {
          "quizList": quizList,
          "index": 0,
          // "answer": levelTestAnswerModel
        });
      }
    } catch (e) {
      Get.snackbar("에러", "퀴즈를 불러오지 못했습니다");
      debugPrint("에러 발생: $e");
    }
  }

  void clickedTestMultiBtn(BuildContext context) {
    Get.toNamed('/test/multi');
  }

  void clickedAfterBtn() {
    Get.toNamed('/login_exist');
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
}
