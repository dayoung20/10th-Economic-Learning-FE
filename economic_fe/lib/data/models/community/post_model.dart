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

  // 한국어 변환된 카테고리를 반환하는 getter
  String get translatedType {
    switch (type) {
      case 'ECONOMY_TALK':
        return '경제 톡톡';
      case 'FREE':
        return '자유';
      case 'QUESTION':
        return '질문';
      case 'INFORMATION':
        return '정보 공유';
      case 'BOOK_RECOMMENDATION':
        return '책추천';
      default:
        return '기타'; // 기본값
    }
  }
}
