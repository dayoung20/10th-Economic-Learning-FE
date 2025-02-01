// 뉴스 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LearningListModel with ChangeNotifier {
  int? termId;
  String? termName;
  String? termDescription;
  bool? isScraped;

  LearningListModel({
    this.termId,
    this.termName,
    this.termDescription,
    this.isScraped,
  });

  factory LearningListModel.fromJson(Map<String, dynamic> json) {
    return LearningListModel(
      termId: json['termId'],
      termName: json['termName'],
      termDescription: json['termDescription'],
      isScraped: json['isScraped'],
    );
  }
}
