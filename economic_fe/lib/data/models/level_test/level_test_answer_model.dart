class AnswerModel {
  final int quizId;
  final String answer;

  AnswerModel({required this.quizId, required this.answer});

  // JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      "quizId": quizId,
      "answer": answer,
    };
  }
}
