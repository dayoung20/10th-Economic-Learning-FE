import 'package:economic_fe/data/models/notification_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  var notifications = <NotificationModel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    isLoading(true);
    try {
      final response = await remoteDataSource.getNotification();
      if (response != null && response['isSuccess']) {
        final List<dynamic> list =
            response['results']['notificationResponseList'];
        notifications.assignAll(
            list.map((json) => NotificationModel.fromJson(json)).toList());
      }
    } catch (e) {
      debugPrint('Error fetching notifications: $e');
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteNotification(int id) async {
    bool success = await remoteDataSource.deleteNotification(id);
    if (success) {
      notifications.removeWhere((notification) => notification.id == id);
      debugPrint("알림 삭제 완료: $id");
    } else {
      Get.snackbar("삭제 실패", "알림을 삭제하는 데 실패했습니다.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void markAsRead(int id) {
    notifications.value = notifications.map((notification) {
      if (notification.id == id) {
        return NotificationModel(
          id: notification.id,
          postTitle: notification.postTitle,
          content: notification.content,
          isRead: true,
          type: notification.type,
          postId: notification.postId,
          createdDate: notification.createdDate,
        );
      }
      return notification;
    }).toList();
  }

  /// 알림 클릭 시 postId가 어디에 속하는지 확인 후 해당 페이지로 이동
  Future<void> onNotificationClick(int notificationId, int postId) async {
    String? targetRoute = await checkPostLocation(postId);

    if (targetRoute != null) {
      // 알림 확인 API 호출 및 UI에서 즉각 제거
      await markNotificationAsChecked(notificationId);

      Get.toNamed(targetRoute, arguments: postId);
    } else {
      Get.snackbar("오류", "해당 게시글을 찾을 수 없습니다.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// postId가 게시글 목록(`api/v1/post`)인지 경제톡톡(`api/v1/post/toktok`)인지 판별
  Future<String?> checkPostLocation(int postId) async {
    try {
      // 두 개의 API 요청을 병렬 실행하여 속도 향상
      final results = await Future.wait([
        remoteDataSource.fetchCategoryPosts("RECENT", "ALL"), // 전체 게시글 조회
        remoteDataSource.fetchTokLists("RECENT"), // 경제톡톡 조회
      ]);

      List<dynamic> categoryPosts = results[0];
      List<dynamic> tokPosts = results[1];

      // postId가 게시글 목록에 존재하면 `/community/detail` 페이지로 이동
      if (categoryPosts.any((post) => post["id"] == postId)) {
        return "/community/detail";
      }

      // postId가 경제톡톡 목록에 존재하면 `/community/talk_detail` 페이지로 이동
      if (tokPosts.any((post) => post["id"] == postId)) {
        return "/community/talk_detail";
      }

      return null; // 해당 postId가 어떤 목록에도 없을 경우
    } catch (e) {
      debugPrint("게시글 확인 중 오류 발생: $e");
      return null;
    }
  }

  /// 알림 확인 API 호출 후 목록에서 즉시 제거
  Future<void> markNotificationAsChecked(int notificationId) async {
    bool success = await remoteDataSource.checkNotification(notificationId);

    if (success) {
      // UI에서 해당 알림 즉시 제거
      notifications
          .removeWhere((notification) => notification.id == notificationId);
      debugPrint("알림 확인 완료: $notificationId");
    } else {
      debugPrint("알림 확인 실패: $notificationId");
    }
  }
}
