import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WrongQuizController extends GetxController {
  var selectedLevel = 'BEGINNER'.obs; // 초기값 설정
  var incorrectQuestions = <Map<String, dynamic>>[].obs;

  /// 레벨 선택 업데이트
  void updateSelectedLevel(String level) {
    selectedLevel.value = _convertLevelToApiValue(level);
    fetchIncorrectQuestions(); // 레벨 변경 시 데이터 가져오기
  }

  // // 임시 데이터 리스트
  // final List<Map<String, dynamic>> incorrectQuestions = [
  //   {'category': '금융', 'title': '복리 계산'},
  //   {'category': '경제', 'title': 'GDP와 GNI'},
  // ];

  // 틀린 문제 가져오기
  Future<void> fetchIncorrectQuestions() async {
    final remoteDataSource = RemoteDataSource();

    try {
      final response =
          await remoteDataSource.fetchIncorrectQuestions(selectedLevel.value);

      if (response != null && response['isSuccess'] == true) {
        final failQuizList = response['results']['failQuizList'] as List;

        incorrectQuestions.value = failQuizList.map((quiz) {
          return {
            'id': int.tryParse(quiz['id'].toString()) ?? 0, // `id`를 정수로 변환
            'title': quiz['name'] ?? '', // `name` 값이 없으면 빈 문자열로 처리
            'category': quiz['learningSet'] ?? '' // `learningSet` 값 처리
          };
        }).toList();
      } else {
        debugPrint('Fetch failed: ${response?['message']}');
        incorrectQuestions.clear();
      }
    } catch (e) {
      debugPrint('fetchIncorrectQuestions Error: $e');
    }
  }

  // // 개별 퀴즈 화면으로 이동
  // Future<void> fetchQuizDetails(int quizId) async {
  //   try {
  //     final response = await RemoteDataSource.fetchQuizById(quizId);
  //     if (response != null && response['isSuccess'] == true) {
  //       final quizData = response['results'];
  //       // 퀴즈 화면으로 이동
  //       Get.toNamed('/quiz', arguments: quizData);
  //     } else {
  //       Get.snackbar('Error', '퀴즈 데이터를 불러올 수 없습니다.');
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', '퀴즈 데이터를 가져오는 중 오류가 발생했습니다.');
  //   }
  // }

  /// UI에서 사용되는 레벨을 API 값으로 변환
  String _convertLevelToApiValue(String level) {
    switch (level) {
      case '초급':
        return 'BEGINNER';
      case '중급':
        return 'INTERMEDIATE';
      case '고급':
        return 'ADVANCED';
      default:
        return 'BEGINNER';
    }
  }
}
