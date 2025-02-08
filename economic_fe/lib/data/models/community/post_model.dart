import 'package:flutter/material.dart';

class PostModel with ChangeNotifier {
  int? id;
  String? title;
  String? content;
  String? type;
  int? likeCount;
  int? commentCount;
  String? imageUrl;
  bool? isScraped;
  String? createdDate;

  PostModel({
    this.id,
    this.title,
    this.content,
    this.type,
    this.likeCount,
    this.commentCount,
    this.imageUrl,
    this.isScraped,
    this.createdDate,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) {
    return PostModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      type: json['type'],
      likeCount: json['likeCount'],
      commentCount: json['commentCount'],
      imageUrl: json['imageUrl'],
      isScraped: json['isScraped'],
      createdDate: json['createdDate'],
    );
  }
}
