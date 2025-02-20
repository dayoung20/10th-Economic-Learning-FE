// 퀴즈 테스트 모델

class QuizTestModel {
  int quizId;
  String learningSetName;
  String name;
  String type;
  String question;
  // String answer;
  List<QuizChoice> choiceList;

  QuizTestModel({
    required this.quizId,
    required this.learningSetName,
    required this.name,
    required this.type,
    required this.question,
    // required this.answer,
    required this.choiceList,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory QuizTestModel.fromJson(Map<String, dynamic> json) {
    return QuizTestModel(
      quizId: json['quizId'],
      learningSetName: json['learningSetName'],
      name: json['name'],
      type: json['type'],
      question: json['question'],
      // answer: json['answer'],
      choiceList: (json['choiceList']['choiceList'] as List)
          .map((choice) => QuizChoice.fromJson(choice))
          .toList(),
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'quizId': quizId,
      'learningSetName': learningSetName,
      'name': name,
      'type': type,
      'question': question,
      // 'answer': answer,
      'choiceList': {
        'choiceList': choiceList.map((choice) => choice.toJson()).toList(),
      },
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

  factory QuizChoice.fromJson(Map<String, dynamic> json) {
    return QuizChoice(
      choiceId: json['choiceId'],
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
