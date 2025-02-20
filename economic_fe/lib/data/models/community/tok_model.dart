import 'package:flutter/material.dart';

class TokModel with ChangeNotifier {
  int? id;
  String? title;
  int? participantCount;
  int? likeCount;
  String? imageUrl;
  bool? isScraped;
  String? createdDate;
  int? commentCount;

  TokModel({
    this.id,
    this.title,
    this.participantCount,
    this.likeCount,
    this.imageUrl,
    this.isScraped,
    this.createdDate,
    this.commentCount,
  });

  factory TokModel.fromJson(Map<String, dynamic> json) {
    return TokModel(
      id: json['id'],
      title: json['title'],
      participantCount: json['participantCount'],
      likeCount: json['likeCount'],
      imageUrl: json['imageUrl'],
      isScraped: json['isScraped'],
      createdDate: json['createdDate'],
      commentCount: json['commentCount'],
    );
  }
}
