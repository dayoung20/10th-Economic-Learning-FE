// 개념 학습 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LearningModel with ChangeNotifier {
  int? conceptId;
  String? name;
  String? explanation;

  LearningModel({
    this.conceptId,
    this.name,
    this.explanation,
  });

  factory LearningModel.fromJson(Map<String, dynamic> json) {
    return LearningModel(
      conceptId: json['conceptId'],
      name: json['name'],
      explanation: json['explanation'],
    );
  }
}
