import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initLocalNotifications() async {
  const AndroidInitializationSettings androidInitSettings =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  // iOS 알림 초기화 설정 추가
  const DarwinInitializationSettings iosInitSettings =
      DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const InitializationSettings initSettings = InitializationSettings(
    android: androidInitSettings,
    iOS: iosInitSettings,
  );

  await flutterLocalNotificationsPlugin.initialize(initSettings);
}

Future<void> showLocalNotification(String title, String body) async {
  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'ripple_channel_id',
    'Ripple 알림',
    channelDescription: '실시간 알림을 제공합니다',
    importance: Importance.max,
    priority: Priority.high,
    playSound: true,
  );

  const NotificationDetails platformDetails =
      NotificationDetails(android: androidDetails);

  await flutterLocalNotificationsPlugin.show(
    0,
    title,
    body,
    platformDetails,
  );
}

Future<void> checkAndRequestNotificationPermissionOnce() async {
  final box = GetStorage();
  final hasRequested = box.read('isNotificationRequested') ?? false;

  if (!hasRequested) {
    final status = await Permission.notification.request();
    final isGranted = status.isGranted;

    final remoteDataSource = RemoteDataSource();
    final success = await remoteDataSource.setAlarm(isGranted);

    if (success) {
      print("푸시 알림 설정 서버 전송 성공");
    } else {
      print("푸시 알림 서버 전송 실패");
    }

    // 요청 여부 저장
    box.write('isNotificationRequested', true);
  }
}
