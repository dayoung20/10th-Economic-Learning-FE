// 퀴즈 테스트 모델
class QuizTestModel {
  int quizId;
  String learningSetName;
  String name;
  String type;
  String question;
  List<QuizChoice> choiceList;

  QuizTestModel({
    required this.quizId,
    required this.learningSetName,
    required this.name,
    required this.type,
    required this.question,
    required this.choiceList,
  });

  factory QuizTestModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> rawChoices = json['choices'];

    return QuizTestModel(
      quizId: json['quizId'],
      learningSetName: json['learningSetName'],
      name: json['name'],
      type: json['type'],
      question: json['question'],
      choiceList: rawChoices.asMap().entries.map((entry) {
        int index = entry.key;
        Map<String, dynamic> choiceJson =
            Map<String, dynamic>.from(entry.value);
        return QuizChoice.fromJson(choiceJson, index);
      }).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'learningSetName': learningSetName,
      'name': name,
      'type': type,
      'question': question,
      'choices': choiceList.map((choice) => choice.toJson()).toList(),
    };
  }
}

// 선택지 모델
class QuizChoice {
  int choiceId;
  String content;

  QuizChoice({
    required this.choiceId,
    required this.content,
  });

  factory QuizChoice.fromJson(Map<String, dynamic> json, int index) {
    return QuizChoice(
      choiceId: index,
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'choiceId': choiceId,
      'content': content,
    };
  }
}
