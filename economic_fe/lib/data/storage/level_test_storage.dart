import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';

class LevelTestStorage {
  static const _answersKey = 'levelTestAnswers';
  static const _quizListKey = 'quizList';

  // 저장
  static Future<void> saveLevelTestData(
      List<LevelTestAnswerModel> answers, List<QuizModel> quizList) async {
    final prefs = await SharedPreferences.getInstance();

    final answersJson = jsonEncode(answers.map((e) => e.toJson()).toList());
    final quizListJson = jsonEncode(quizList.map((e) => e.toJson()).toList());

    await prefs.setString(_answersKey, answersJson);
    await prefs.setString(_quizListKey, quizListJson);
  }

  // 복구
  static Future<(List<LevelTestAnswerModel>, List<QuizModel>)>
      loadLevelTestData() async {
    final prefs = await SharedPreferences.getInstance();

    final answersJson = prefs.getString(_answersKey);
    final quizListJson = prefs.getString(_quizListKey);

    final answers = answersJson != null
        ? (jsonDecode(answersJson) as List)
            .map((e) => LevelTestAnswerModel.fromJson(e))
            .toList()
        : <LevelTestAnswerModel>[];

    final quizList = quizListJson != null
        ? (jsonDecode(quizListJson) as List)
            .map((e) => QuizModel.fromJson(e))
            .toList()
        : <QuizModel>[];

    return (answers, quizList);
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_answersKey);
    await prefs.remove(_quizListKey);
  }
}
