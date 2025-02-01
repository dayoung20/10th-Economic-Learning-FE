import 'package:economic_fe/data/models/chatbot/chatbot_model.dart';
import 'package:economic_fe/data/models/chatbot/message.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotController extends GetxController {
  // 메시지 리스트
  var messages = <Message>[].obs;

  // 텍스트 입력 컨트롤러
  final TextEditingController messageController = TextEditingController();

  // 날짜 관리
  RxString currentDate = ''.obs;

  // 메시지 입력 상태 관리
  var messageText = ''.obs;

  // 챗봇 이용 꿀팁 보이기 여부
  var isHelpTipVisible = false.obs;

  // 슬라이드 창 확장 상태 관리
  var isExpanded = false.obs;

  @override
  void onInit() {
    super.onInit();
    // 앱 초기화 시 날짜 변경 체크
    checkAndAddNewDateMessage();
  }

  // 날짜가 바뀌었을 때 메시지 리스트에 날짜 위젯 추가
  void checkAndAddNewDateMessage() {
    String formattedDate = _getFormattedDate();
    if (formattedDate != currentDate.value) {
      // 날짜가 바뀌었을 때만 메시지 추가
      currentDate.value = formattedDate;

      // 날짜 메시지 추가
      messages.add(Message(
        text: formattedDate,
        isUserMessage: false,
        time: '',
        isSystemMessage: true,
        isDateMessage: true, // 날짜 메시지 플래그 추가
      ));
      update(); // 화면을 업데이트 하여 날짜 위젯이 추가되도록
    }
  }

  // 메시지 전송 함수
  void sendMessage() async {
    final messageText = messageController.text;
    if (messageText.isNotEmpty) {
      // 현재 시간 포맷
      String currentTime = _getFormattedTime();

      // 사용자 메시지 추가 (시간 포함)
      messages.add(Message(
        text: messageText,
        isUserMessage: true,
        time: currentTime,
        isSystemMessage: false,
      ));

      // 챗봇 응답 추가 (시간 포함)
      _addBotResponse(messageText, currentTime);

      // 메시지 전송 후 텍스트 필드 초기화
      messageController.clear();
    }
  }

  // 챗봇의 응답을 추가하는 함수 (시간 포함)
  void _addBotResponse(String userMessage, String currentTime) {
    String botResponse = '챗봇: $userMessage';
    messages.add(Message(
      text: botResponse,
      isUserMessage: false,
      time: currentTime,
      isSystemMessage: true,
    ));
  }

  // 챗봇 기본 메시지 (날짜가 바뀔 때마다 전송)
  void sendInitialMessages() {
    String initialMessage = '무엇을 도와드릴까요?';
    String currentTime = _getFormattedTime();
    messages.add(Message(
      text: initialMessage,
      isUserMessage: false,
      time: currentTime,
      isSystemMessage: true,
    ));
  }

  // 챗봇 이용 꿀팁 메시지
  void sendTipMessages() {
    String tipMessage =
        '✨ 리플의 AI 챗봇을 200% 활용하는\n무엇을 도와드릴까요?\n \n1. 명확하고 구체적으로 작성하기 \n- 무엇을 원하는지 구체적으로 설명해 보세요! \n- 예시 : "복리를 이해하기 위해, 연 5% 이자율로 3년 동안 100만 원이 어떻게 증가하는지 구체적으로 계산해줘." \n\n2. 배경 정보 제공하기 \n- 질문이나 질문자의 배경 정보를 알려주세요! \n- 예시 : "경제를 공부하는 대학생인데, \n단리와 복리의 차이를 쉽게 이해할 수 있도록 설명해줘." \n\n3. 결과물 형식 명시하기 \n- 결과물을 어떤 형태로 제공받고 싶은지 알려주세요! \n- 예시 : “단리와 복리의 차이를 표로 정리하고, 간단한 계산 예를 포함해 설명해줘."';
    String currentTime = _getFormattedTime();
    messages.add(Message(
      text: tipMessage,
      isUserMessage: false,
      time: currentTime,
      isSystemMessage: true,
    ));
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
    String time = DateFormat('a h:mm').format(DateTime.now());
    time = time.replaceFirst('AM', '오전').replaceFirst('PM', '오후');
    return time;
  }

  // 메시지 입력 중일 때 호출되는 함수
  void updateMessage(String value) {
    messageText.value = value;
  }

  // 이전 화면으로
  void goBack() {
    Get.back();
  }

  // 챗봇 대화 내역 조회
  Future<List<ChatbotModel>> getChatbotList(int page) async {
    try {
      print("start");
      dynamic response = await RemoteDataSource.getMessageList(page);

      print("response :: $response");
      final data = response as Map<String, dynamic>;
      final chatResponses = data['results']['chatResponses'] as List;
      return chatResponses.map((chat) => ChatbotModel.fromJson(chat)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  // 챗봇에 메시지 전송
  Future<void> postChatbotMessage() async {
    String message = messageController.text;
    try {
      print("start");

      dynamic response = await RemoteDataSource.postChatbotMessage(message);
      print("메시지 전송 : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }
}
