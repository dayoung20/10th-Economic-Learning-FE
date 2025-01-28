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

  /// 틀린 문제 데이터 요청 후 상태 업데이트
  Future<void> fetchIncorrectQuestions() async {
    try {
      final List<dynamic>? response =
          await RemoteDataSource.fetchIncorrectQuestions(selectedLevel.value);

      if (response != null) {
        incorrectQuestions.assignAll(
          response.map((item) => Map<String, dynamic>.from(item)).toList(),
        );
        debugPrint('틀린 문제 데이터를 성공적으로 불러왔습니다.');
      } else {
        incorrectQuestions.clear();
        debugPrint('틀린 문제 데이터가 비어 있습니다.');
      }
    } catch (e) {
      incorrectQuestions.clear();
      debugPrint('틀린 문제 데이터 요청 중 예외 발생: $e');
    }
  }

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
