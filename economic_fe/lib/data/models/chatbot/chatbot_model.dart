// 뉴스 모델

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// class Message {
//   final String text;
//   final bool isUserMessage; // 사용자의 메시지인지 시스템의 메시지인지 구분
//   final String time; // 메시지 전송 시각
//   final bool isSystemMessage; // 시스템 메시지 여부
//   final bool? isDateMessage; // 날짜 표시 위젯 여부

//   Message({
//     this.isDateMessage = false,
//     required this.text,
//     required this.isUserMessage,
//     required this.time,
//     this.isSystemMessage = false, // 기본값은 false로 설정
//   });
// // }
// "message": "hi",
//         "sender": "USER",
//         "createdAt": "2025-02-01T16:29:21.097665"

class ChatbotModel with ChangeNotifier {
  String? message;
  String? sender;
  String? createdAt;

  ChatbotModel({
    this.message,
    this.sender,
    this.createdAt,
  });

  factory ChatbotModel.fromJson(Map<String, dynamic> json) {
    return ChatbotModel(
      message: json['message'],
      sender: json['sender'],
      createdAt: json['createdAt'],
    );
  }
}
