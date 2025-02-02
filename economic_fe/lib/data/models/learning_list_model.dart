// 전체 학습세트 모델
// learning_list_page에서 활용

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LearningListModel with ChangeNotifier {
  int? id;
  String? name;
  bool? isLearningSetCompleted;
  bool? isConceptCompleted;
  bool? isQuizCompleted;

  LearningListModel({
    this.id,
    this.name,
    this.isLearningSetCompleted,
    this.isConceptCompleted,
    this.isQuizCompleted,
  });

  factory LearningListModel.fromJson(Map<String, dynamic> json) {
    return LearningListModel(
      id: json['id'],
      name: json['name'],
      isLearningSetCompleted: json['isLearningSetCompleted'],
      isConceptCompleted: json['isConceptCompleted'],
      isQuizCompleted: json['isQuizCompleted'],
    );
  }
}
