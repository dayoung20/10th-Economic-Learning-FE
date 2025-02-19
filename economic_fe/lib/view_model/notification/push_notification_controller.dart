// import 'package:economic_fe/data/services/remote_data_source.dart';
// import 'package:flutter_client_sse/flutter_client_sse.dart';
// import 'package:get/get.dart';

// class PushNotificationController extends GetxController {
//   final RemoteDataSource remoteDataSource = RemoteDataSource();
//   RxString latestNotificationTitle = "".obs;
//   RxString latestNotificationContent = "".obs;
//   RxInt latestPostId = (-1).obs; // 게시글 ID 저장

//   /// 앱 실행 시 자동으로 SSE 연결
//   @override
//   void onInit() {
//     super.onInit();
//     connectToSse();
//   }

//   /// SSE 연결 및 이벤트 수신
//   void connectToSse() {
//     remoteDataSource.subscribeToNotifications(
//       onNotificationReceived: (String data) {
//         handleNotification(data);
//       },
//     );
//   }

//   /// 알림 데이터 처리
//   void handleNotification(String data) {
//     print("서버에서 받은 원본 SSE 데이터: $data");

//     try {
//       final notification = remoteDataSource.parseNotificationData(data);

//       // 데이터가 올바른 형식인지 확인
//       if (notification.isEmpty || !notification.containsKey("title")) {
//         print("유효하지 않은 알림 데이터: $notification");
//         return;
//       }

//       String type = notification["type"] ?? "유형";
//       String title = "[$type]${notification["title"]}" ?? "새로운 알림";
//       String content = notification["content"] ?? "";
//       int postId = notification["postId"] ?? -1;

//       // 최신 알림 정보 업데이트 (GetX가 자동 감지)
//       latestNotificationTitle.value = title;
//       latestNotificationContent.value = content;
//       latestPostId.value = postId;

//       // 푸시 알림 표시
//       Get.snackbar(
//         title,
//         content,
//         snackPosition: SnackPosition.TOP,
//         duration: const Duration(seconds: 3),
//         onTap: (_) {
//           if (postId != -1) {
//             Get.toNamed("/notification");
//           }
//         },
//       );
//     } catch (e) {
//       print("알림 데이터 처리 오류: $e");
//     }
//   }

//   /// SSE 연결 해제 (로그아웃 또는 앱 종료 시)
//   void disconnectSse() {
//     SSEClient.unsubscribeFromSSE();
//     print("SSE 연결 종료");
//   }
// }
