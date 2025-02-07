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
}
