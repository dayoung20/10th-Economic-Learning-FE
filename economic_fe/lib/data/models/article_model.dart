// 뉴스 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ArticleModel with ChangeNotifier {
  int? id;
  String? title;
  String? content;
  String? publisher;
  int? views;
  String? url;
  String? category;
  String? createdDate;
  bool? isScraped;

  ArticleModel({
    this.id,
    this.title,
    this.content,
    this.publisher,
    this.views,
    this.url,
    this.category,
    this.createdDate,
    this.isScraped,
  });

  /// 영어 카테고리를 한국어로 변환하는 getter
  String get translatedCategory {
    const categoryMap = {
      "ECONOMIC_ANALYSIS": "경기 분석",
      "NORMAL": "경제 일반",
      "FINANCE": "금융",
      "GLOBAL": "국제경제",
      "REAL_ESTATE": "부동산",
      "INDUSTRY": "산업경제",
      "ECONOMIC_POLICY": "정부와 경제 정책",
      "INVESTMENT": "투자",
      "OTHER": "기타",
    };

    return categoryMap[category] ?? "기타"; // 없는 값일 경우 "기타" 반환
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      publisher: json['publisher'],
      views: json['views'],
      url: json['url'],
      category: json['category'],
      createdDate: json['createdDate'],
      isScraped: json['isScraped'],
    );
  }
}
