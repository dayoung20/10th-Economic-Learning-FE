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

  // // 현재 날짜를 '2024년 11월 17일 금요일' 형식으로 반환하는 함수
  // String getFormattedDate(String createdAt) {
  //   String date = DateFormat('yyyy년 MM월 dd일 EEEE', 'ko')
  //       .format(DateTime.parse(createdAt));
  //   // String date = DateFormat('yyyy년 MM월 dd일 EEEE').format(DateTime.now());
  //   date = date
  //       .replaceFirst('Monday', '월요일')
  //       .replaceFirst('Tuesday', '화요일')
  //       .replaceFirst('Wednesday', '수요일')
  //       .replaceFirst('Thursday', '목요일')
  //       .replaceFirst('Friday', '금요일')
  //       .replaceFirst('Saturday', '토요일')
  //       .replaceFirst('Sunday', '일요일');
  //   return date;
  // }

  // 서버에서 받아오는 날짜 형식 변환
  String formatCreatedAt(String createdAt) {
    try {
      DateTime parsedDate = DateTime.parse(createdAt);
      return DateFormat('yyyy년 MM월 dd일', 'ko').format(parsedDate);
    } catch (e) {
      print('날짜 변환 오류: $e');
      return createdAt; // 변환 실패 시 원래 문자열 반환
    }
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

// import 'package:economic_fe/data/models/chatbot/chatbot_model.dart';
// import 'package:economic_fe/data/services/remote_data_source.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';

// class ChatbotController extends GetxController {
//   var messages = <ChatbotModel>[].obs;
//   var currentPage = 0.obs;
//   var totalPage = 1.obs; // 전체 페이지 수 저장
//   var isLoading = false.obs;
//   var isFetching = false.obs;

//   final messageController = TextEditingController();
//   var messageText = ''.obs;

//   // 대화 내역 불러오기
//   Future<void> fetchChatbotMessages() async {
//     // 현재 페이지가 totalPage 이상이면 더 이상 요청하지 않음
//     if (currentPage.value >= totalPage.value) {
//       print("🛑 [INFO] All pages loaded. No more requests needed.");
//       return;
//     }

//     try {
//       isLoading.value = true;
//       print(
//           "📡 [INFO] Fetching messages from server, page: ${currentPage.value}");

//       var response = await RemoteDataSource().getMessageList(currentPage.value);

//       if (response is Map<String, dynamic>) {
//         var results = response['results'];
//         if (results != null && results['chatResponses'] != null) {
//           List<dynamic> chatData = results['chatResponses'];
//           List<ChatbotModel> fetchedMessages =
//               chatData.map((chat) => ChatbotModel.fromJson(chat)).toList();

//           // totalPage 값 업데이트
//           totalPage.value = results['totalPage'] ?? 1;

//           // 기존 메시지에 추가
//           messages.addAll(fetchedMessages.reversed);

//           print(
//               "✅ [SUCCESS] Messages successfully fetched. Total messages: ${messages.length}");
//           print(
//               "📄 [INFO] Total pages: ${totalPage.value}, Current page: ${currentPage.value}");
//         } else {
//           print("❌ [ERROR] Missing 'chatResponses' in response");
//         }
//       } else {
//         print("❌ [ERROR] Unexpected response format: ${response.runtimeType}");
//       }
//     } catch (e) {
//       print("❌ [ERROR] Failed to fetch messages: $e");
//     } finally {
//       isLoading.value = false;
//     }
//   }

//   // 메시지 전송
//   Future<void> postChatbotMessage() async {
//     String message = messageController.text;
//     if (message.isEmpty) return;

//     try {
//       isFetching.value = true;
//       print("📤 [INFO] Sending message: $message");

//       var response = await RemoteDataSource().postChatbotMessage(message);

//       if (response['isSuccess'] == true) {
//         var result = response['results'];
//         if (result != null && result is Map<String, dynamic>) {
//           // 서버 응답 데이터를 정확히 파싱
//           ChatbotModel chatbotResponse = ChatbotModel(
//             message: result['message'],
//             sender: result['sender'],
//             createdAt: result['createdAt'],
//           );

//           // 새 메시지를 기존 메시지 목록의 맨 앞에 추가
//           messages.insert(0, chatbotResponse);

//           print("✅ [SUCCESS] New message received and displayed.");
//         } else {
//           print("❌ [ERROR] Invalid result format: $result");
//         }
//       } else {
//         print("❌ [ERROR] Server responded with failure status.");
//       }

//       messageController.clear();
//     } catch (e) {
//       print("❌ [ERROR] Failed to send message: $e");
//     } finally {
//       isFetching.value = false;
//     }
//   }

//   // 날짜 포맷
//   String formatDate(String createdAt) {
//     try {
//       DateTime parsedDate = DateTime.parse(createdAt);
//       return DateFormat('yyyy년 MM월 dd일').format(parsedDate);
//     } catch (e) {
//       print("❌ [ERROR] Date formatting failed: $e");
//       return createdAt;
//     }
//   }

//   // 시간 포맷
//   String formatTime(String createdAt) {
//     try {
//       DateTime parsedTime = DateTime.parse(createdAt);
//       return DateFormat('HH:mm').format(parsedTime);
//     } catch (e) {
//       print("❌ [ERROR] Time formatting failed: $e");
//       return createdAt;
//     }
//   }

//   // 메시지 텍스트 업데이트
//   void updateMessage(String value) {
//     messageText.value = value;
//   }
// }
