// 레벨 테스트 결과 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LevelTestResultModel with ChangeNotifier {
  int? quizId;
  String? question;
  String? answer;
  String? explanation;
  bool? isCorrect;

  LevelTestResultModel({
    this.quizId,
    this.question,
    this.answer,
    this.isCorrect,
  });

  factory LevelTestResultModel.fromJson(Map<String, dynamic> json) {
    return LevelTestResultModel(
      quizId: json['quizId'],
      question: json['question'],
      answer: json['answer'],
      isCorrect: json['isCorrect'],
    );
  }
}
