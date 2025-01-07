import 'package:economic_fe/data/models/chatbot/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotController extends GetxController {
  // 메시지 리스트
  var messages = <Message>[].obs;

  // 텍스트 입력 컨트롤러
  final TextEditingController messageController = TextEditingController();

  // 메시지 전송 함수
  void sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      // 사용자 메시지 추가
      messages.add(Message(text: messageText, isUserMessage: true));

      // 챗봇 응답 추가
      _addBotResponse(messageText);

      // 메시지 전송 후 텍스트 필드 초기화
      messageController.clear();
    }
  }

  // 슬라이드 창
  var isExpanded = false.obs; // 슬라이드 창 확장 상태를 관리하는 변수

  // 날짜
  RxString currentDate = ''.obs;

  // 현재 시간을 관리하는 Rx 변수
  RxString currentTime = ''.obs;

  // 메시지 입력 중 상태 관리
  var messageText = ''.obs; // 입력된 메시지 상태 관리

  // 챗봇 이용 꿀팁 부분을 보이도록 하는 상태 관리
  var isHelpTipVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 초기화 시 현재 날짜와 시간을 설정
    currentDate.value = _getFormattedDate();
    currentTime.value = _getFormattedTime();

    // 메시지 입력 상태 추적
    ever(messageText, (_) {
      // 이곳에 메시지 입력 중인 상태를 반영할 수 있습니다.
      // 예를 들어, 입력 중일 때 다른 UI 반영 등.
    });
  }

  // 현재 날짜를 '2024년 11월 17일 금요일' 형식으로 반환하는 함수
  String _getFormattedDate() {
    String date = DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now());
    date = date
        .replaceFirst('Monday', '월요일')
        .replaceFirst('Tuesday', '화요일')
        .replaceFirst('Wednesday', '수요일')
        .replaceFirst('Thursday', '목요일')
        .replaceFirst('Friday', '금요일')
        .replaceFirst('Saturday', '토요일')
        .replaceFirst('Sunday', '일요일');
    return date;
  }

  // 현재 시간을 오전/오후 형식으로 포맷하는 함수
  String _getFormattedTime() {
    // 'a' 부분을 오전/오후로 변환
    String time = DateFormat('a h:mm').format(DateTime.now());
    time = time.replaceFirst('AM', '오전').replaceFirst('PM', '오후');
    return time;
  }

  // 챗봇의 응답을 추가하는 함수 (예시로 단순히 echo 기능)
  void _addBotResponse(String userMessage) {
    String botResponse = '챗봇: $userMessage';
    messages.add(Message(text: botResponse, isUserMessage: false));
  }

  // 슬라이드 창 상태를 토글하는 함수
  void toggleSlide() {
    isExpanded.value = !isExpanded.value;
  }

  // 메시지 입력 중일 때 호출되는 함수
  void updateMessage(String value) {
    messageText.value = value;
  }

  // 챗봇 이용 꿀팁 메시지 보이게/숨기기
  void toggleHelpTip() {
    isHelpTipVisible.value = !isHelpTipVisible.value;
  }
}
