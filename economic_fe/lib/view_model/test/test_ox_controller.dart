import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestOxController extends GetxController {
  var levelTestAnswerModel = <LevelTestAnswerModel>[].obs;

  // 사용자가 선택한 선택지
  var choiceId = 0.obs;

  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }

  void stopBtn() {
    Get.toNamed('/test');
  }

  void addAnswer(int quizId, int answer) {
    levelTestAnswerModel
        .add(LevelTestAnswerModel(quizId: quizId, answer: answer));
  }

  void clickedNextBtn(
      BuildContext context, int index, List<QuizModel> quizlist) {
    if (index <= 8) {
      if (quizlist[index].choiceList.length == 2) {
        Get.toNamed('test/ox', arguments: {
          "quizList": quizlist,
          "index": index + 1,
          "answer": levelTestAnswerModel
        });
      } else {
        Get.toNamed('test/multi', arguments: {
          "quizList": quizlist,
          "index": index + 1,
          "answer": levelTestAnswerModel
        });
      }
    } else {
      Get.toNamed('/leveltest_result');
    }
  }
}
