class LevelTestAnswerModel {
  final int quizId;
  final int answer;

  LevelTestAnswerModel({required this.quizId, required this.answer});

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "quizId": quizId,
      "answer": answer,
    };
  }
}
