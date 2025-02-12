// 레벨 테스트 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/foundation.dart';

class QuizModel {
  int id;
  String learningSetName;
  String level;
  String type;
  String question;
  String answer;
  List<Choice> choiceList;

  QuizModel({
    required this.id,
    required this.learningSetName,
    required this.level,
    required this.type,
    required this.question,
    required this.answer,
    required this.choiceList,
  });

  // JSON 데이터를 Dart 객체로 변환
  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      id: json['id'],
      learningSetName: json['learningSetName'],
      level: json['level'],
      type: json['type'],
      question: json['question'],
      answer: json['answer'],
      choiceList: (json['choiceList']['choiceList'] as List)
          .map((choice) => Choice.fromJson(choice))
          .toList(),
    );
  }

  // Dart 객체를 JSON으로 변환
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'learningSetName': learningSetName,
      'level': level,
      'type': type,
      'question': question,
      'answer': answer,
      'choiceList': {
        'choiceList': choiceList.map((choice) => choice.toJson()).toList(),
      },
    };
  }
}

// 선택지 모델
class Choice {
  int choiceId;
  String content;

  Choice({
    required this.choiceId,
    required this.content,
  });

  factory Choice.fromJson(Map<String, dynamic> json) {
    return Choice(
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
