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
