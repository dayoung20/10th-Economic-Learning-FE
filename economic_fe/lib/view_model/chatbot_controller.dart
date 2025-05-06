import 'package:economic_fe/data/models/chatbot/message.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  var messages = <Message>[].obs;

  final TextEditingController messageController = TextEditingController();
  var messageText = ''.obs;

  var isExpanded = false.obs;
  var chatbotTipText = ''.obs;
  var currentPage = 0.obs;
  RxString lastMessageDate = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _addInitialMessage();
  }

  String getCurrentFormattedTime() {
    return DateFormat('a h:mm', 'ko_KR')
        .format(DateTime.now())
        .replaceAll('AM', '오전')
        .replaceAll('PM', '오후');
  }

  String getFormattedDate(DateTime date) {
    return DateFormat('yyyy년 MM월 dd일 EEEE', 'ko').format(date);
  }

  void _addInitialMessage() {
    String today = getFormattedDate(DateTime.now());
    lastMessageDate.value = today;

    messages.addAll([
      Message(
        text: today,
        isSystemMessage: true,
        isDateMessage: true,
        time: '',
        isUserMessage: false,
      ),
      Message(
        text: '무엇을 도와드릴까요?',
        isUserMessage: false,
        isSystemMessage: false,
        time: getCurrentFormattedTime(),
      ),
    ]);
  }

  void updateMessage(String value) {
    messageText.value = value;
  }

  void _checkAndInsertDateHeader() {
    String today = getFormattedDate(DateTime.now());
    if (lastMessageDate.value != today) {
      lastMessageDate.value = today;
      messages.addAll([
        Message(
          text: today,
          isSystemMessage: true,
          isDateMessage: true,
          time: '',
          isUserMessage: false,
        ),
        Message(
          text: '무엇을 도와드릴까요?',
          isUserMessage: false,
          isSystemMessage: false,
          time: getCurrentFormattedTime(),
        ),
      ]);
    }
  }

  Future<void> postChatbotMessage() async {
    final input = messageController.text.trim();
    if (input.isEmpty) return;

    _checkAndInsertDateHeader();

    messages.add(
      Message(
        text: input,
        isUserMessage: true,
        time: getCurrentFormattedTime(),
      ),
    );

    messageController.clear();
    messageText.value = '';

    try {
      final response = await remoteDataSource.postChatbotMessage(input);
      final botMessage = response['results']?.toString() ?? '답변이 없습니다.';
      messages.add(
        Message(
          text: botMessage,
          isUserMessage: false,
          time: getCurrentFormattedTime(),
        ),
      );
    } catch (e) {
      debugPrint('챗봇 응답 실패: $e');
      messages.add(
        Message(
          text: '오류가 발생했습니다. 다시 시도해주세요.',
          isUserMessage: false,
          isSystemMessage: true,
          time: getCurrentFormattedTime(),
        ),
      );
    }
  }

  Future<void> getChatbotTips() async {
    try {
      final response = await remoteDataSource.getChatbotTips();
      final tip = response['results']?.toString() ?? '유효한 꿀팁이 없습니다.';
      chatbotTipText.value = tip;

      messages.add(
        Message(
          text: tip,
          isUserMessage: false,
          isSystemMessage: true,
          time: getCurrentFormattedTime(),
        ),
      );
    } catch (e) {
      chatbotTipText.value = '챗봇 꿀팁을 불러오지 못했습니다.';
      messages.add(
        Message(
          text: chatbotTipText.value,
          isUserMessage: false,
          isSystemMessage: true,
          time: getCurrentFormattedTime(),
        ),
      );
    }
  }

  Future<void> deleteMessage() async {
    try {
      final result = await remoteDataSource.deleteMessage();
      if (result == true) {
        messages.clear();
        _addInitialMessage();
      }
    } catch (e) {
      debugPrint('삭제 실패: $e');
    }
  }

  Future<void> getChatbotList(int page) async {
    try {
      final response = await remoteDataSource.getMessageList(page);
      final dataList = response['results']['chatResponses'] as List<dynamic>;
      final List<Message> loadedMessages = dataList.map((item) {
        return Message(
          text: item['message'] ?? '',
          isUserMessage: item['sender'] == 'USER',
          time: getCurrentFormattedTime(),
        );
      }).toList();

      messages.addAll(loadedMessages);
    } catch (e) {
      debugPrint('메시지 불러오기 실패: $e');
    }
  }
}
