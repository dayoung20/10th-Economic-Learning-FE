import 'package:economic_fe/data/models/chatbot/chatbot_model.dart';
import 'package:economic_fe/data/models/chatbot/message.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // 메시지 리스트
  var messages = <Message>[].obs;
  var currentPage = 0.obs;
  var chatbotTip = false.obs;

  int totalPage = 0;

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

  // 현재 날짜를 '2024년 11월 17일 금요일' 형식으로 반환하는 함수
  String getFormattedDate(String createdAt) {
    String date = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko')
        .format(DateTime.parse(createdAt));
    // String date = DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now());
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
      dynamic response = await remoteDataSource.getMessageList(page);
      final data = response as Map<String, dynamic>;
      final chatResponses = data['results']['chatResponses'] as List;
      totalPage = data['results']['totalPage'];
      return chatResponses.map((chat) => ChatbotModel.fromJson(chat)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  //이용 꿀팁 조회
  Future<void> getChatbotTips() async {
    try {
      print("start");
      dynamic response = await remoteDataSource.getChatbotTips();
      // print("꿀팁 조회 response : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  // 챗봇에 메시지 전송
  Future<void> postChatbotMessage() async {
    String message = messageController.text;
    try {
      print("start");

      dynamic response = await remoteDataSource.postChatbotMessage(message);
      print("메시지 전송 : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  // 챗봇 메세지 초기화
  Future<void> deleteMessage() async {
    try {
      print("start");

      dynamic response = await remoteDataSource.deleteMessage();
      if (response != null) {
        print("response : $response");
      }
    } catch (e) {
      debugPrint("Error : $e");
    }
  }
}
