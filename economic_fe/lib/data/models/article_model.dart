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

  ArticleModel({
    this.id,
    this.title,
    this.content,
    this.publisher,
    this.views,
    this.url,
    this.category,
    this.createdDate,
  });

  // void
}
