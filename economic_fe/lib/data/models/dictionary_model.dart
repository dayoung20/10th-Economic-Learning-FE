// 뉴스 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DictionaryModel with ChangeNotifier {
  int? termId;
  String? termName;
  String? termDescription;

  DictionaryModel({
    this.termId,
    this.termName,
    this.termDescription,
  });

  factory DictionaryModel.fromJson(Map<String, dynamic> json) {
    return DictionaryModel(
      termId: json['termId'],
      termName: json['termName'],
      termDescription: json['termDescription'],
    );
  }
}
