import 'package:economic_fe/data/models/quiz_test_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/finish_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class QuizTestController extends GetxController {
  late BuildContext context;
  final remoteDataSource = RemoteDataSource();
  QuizTestController get to => Get.find();

  var learningSetId = 0.obs; // 학습 세트 ID
  var conceptName = "개념 학습".obs;
  var level = "BEGINNER".obs;
  // late final List<QuizTestModel> quizList;
  var quizList = <QuizTestModel>[].obs;
  var currentQuizIdx = 0.obs;
  var isCorrect = true.obs;
  var explanation = "".obs;

  // void getStats() {
  //   print("Stats initialized!");
  // }

  @override
  void onInit() async {
    super.onInit();
    if (Get.arguments != null) {
      learningSetId.value = Get.arguments?["learningSetId"] ?? 0;
      conceptName.value = Get.arguments?["name"] ?? "개념 학습";
      level.value = Get.arguments?["level"] ?? "BEGINNER";
    } else {
      learningSetId.value = 0;
      conceptName.value = "개념 학습";
      level.value = "BEGINNER";
    }
    // quizList = await getQuizTest(learningSetId.value, level.value);
    fetchQuizList();
    // print("quiz list : $quizList");
  }

  // 퀴즈 시작 api
  void fetchQuizList() async {
    quizList.value = await getQuizTest(learningSetId.value, level.value);
  }

  Future<List<QuizTestModel>> getQuizTest(
      int learningSetId, String level) async {
    try {
      print("start");
      dynamic response =
          await remoteDataSource.getQuizList(learningSetId, level);
      print("getQuizTest response ::: $response");

      final data = response as Map<String, dynamic>;
      final quizList = data['results']['quizList'] as List;
      return quizList.map((quiz) => QuizTestModel.fromJson(quiz)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  Future<void> postSubmitQuiz(int quizId, int answerIndex) async {
    try {
      print("start quizId : $quizId");
      dynamic response =
          await remoteDataSource.postSubmitQuiz(quizId, answerIndex);

      final data = response as Map<String, dynamic>;

      isCorrect.value = data['results']['isCorrect'];
      explanation.value = data['results']['explanation'];

      print("result : ${isCorrect.value}, $explanation");
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // 퀴즈 완료 (한 세트 다 풀고 끝)
  Future<void> postQuizFinish(int learningSetId, String level) async {
    try {
      print("start");

      dynamic response =
          await remoteDataSource.postQuizFinish(learningSetId, level);

      print("response quizFinish isSuccess : ${response['isSuccess']}");
      // Get.offNamed('/learning_list/quiz_level');
    } catch (e) {
      debugPrint('post quizFinish Error: $e');
    }
  }

  void finishQuiz() {
    Get.off(() => const FinishPage(), arguments: {
      'contents': conceptName.value,
      'number': 1,
      'category': 1,
      'level': level.value,
      'isQuiz': true,
    });
  }
}
