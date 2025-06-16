class QuizModel {
  final int id;
  final String level;
  final String type;
  final String question;
  final List<Choice> choiceList;

  QuizModel({
    required this.id,
    required this.level,
    required this.type,
    required this.question,
    required this.choiceList,
  });

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      level: json['level'],
      type: json['type'],
      question: json['question'],
      choiceList: (json['choiceList'] as List)
          .map((choice) => Choice.fromJson(choice))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': level,
      'type': type,
      'question': question,
      'choiceList': choiceList.map((choice) => choice.toJson()).toList(),
    };
  }
}

class Choice {
  final String content;

  Choice({required this.content});

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(content: json['content']);
  }

  Map<String, dynamic> toJson() => {'content': content};
}
