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
        final List<dynamic> list = response['results'];
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
      // // 알림 확인 API 호출 및 UI에서 즉각 제거
      // await markNotificationAsChecked(notificationId);
      await deleteNotification(notificationId); // 알림 확인 API 대신 알림 제거 API 호출

      Get.toNamed(targetRoute, arguments: postId);
    } else {
      Get.snackbar("오류", "해당 게시글을 찾을 수 없습니다.",
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  /// postId가 게시글 목록(`api/v1/post`)인지 경제톡톡(`api/v1/post/toktok`)인지 판별
  Future<String?> checkPostLocation(int postId) async {
    try {
      // 두 API를 병렬 호출
      final results = await Future.wait([
        remoteDataSource.fetchCategoryPosts(
          page: 0,
          sort: "RECENT",
          type: "ALL",
        ),
        remoteDataSource.fetchTokLists(
          page: 0,
          sort: "RECENT",
        ),
      ]);

      // Map 타입으로 받아와서 리스트 추출
      final categoryPosts = results[0]["postPreviewList"] ?? [];
      final tokPosts = results[1]["postPreviewList"] ?? [];

      // 게시글 ID가 어디에 포함되어 있는지 확인
      if (categoryPosts.any((post) => post["id"] == postId)) {
        return "/community/detail";
      }

      if (tokPosts.any((post) => post["id"] == postId)) {
        return "/community/talk_detail";
      }

      return null;
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
