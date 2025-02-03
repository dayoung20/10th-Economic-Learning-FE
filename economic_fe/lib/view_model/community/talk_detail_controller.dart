import 'package:economic_fe/data/models/community/comment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkDetailController extends GetxController {
  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 텍스트 입력 컨트롤러
  final TextEditingController messageController = TextEditingController();

  // 메시지 입력 상태 관리
  var messageText = ''.obs;

  // 메시지 입력 중일 때 호출되는 함수
  void updateMessage(String value) {
    messageText.value = value;
  }

  // 메시지 전송 함수
  void sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      // 메시지 전송 후 텍스트 필드 초기화
      messageController.clear();
    }
    addComment(messageText);
  }

  // 댓글 데이터 모델 (예시)
  RxList<Comment> comments = RxList<Comment>([
    Comment(
      id: -1,
      content:
          '이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다.이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다...',
      author: '닉네임1',
      date: '1일 전',
      likes: 1,
      replies: [
        Comment(
          content:
              '이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다.이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다. 이곳은 댓글 내용이 들어갑니다...',
          author: '닉네임1',
          date: '1일 전',
          likes: 1,
          isAuthor: false,
          id: -1,
          isLiked: false,
        ),
      ],
      isAuthor: false,
      isLiked: false,
    ),
  ]);

  // 댓글 추가 함수
  void addComment(String message) {
    if (message.isNotEmpty) {
      comments.add(
        Comment(
          content: message,
          author: '사용자',
          replies: [],
          date: '추가 필요',
          likes: 0,
          isAuthor: true,
          id: -1,
          isLiked: false,
        ),
      );
    }
  }

  // 챗봇 화면으로 이동
  void toChatBot() {
    Get.toNamed('/chatbot');
  }
}
