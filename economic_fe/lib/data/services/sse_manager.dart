import 'dart:async';
import 'dart:convert';

import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/utils/notification_utils.dart';
import 'package:economic_fe/utils/scaffold_messenger_key.dart';
import 'package:flutter/material.dart';

class SSEManager with WidgetsBindingObserver {
  final remoteDataSource = RemoteDataSource();
  static final SSEManager _instance = SSEManager._internal();

  factory SSEManager() => _instance;

  SSEManager._internal();

  bool _isConnected = false;
  StreamSubscription? _subscription;

  BuildContext? _context; // 스낵바 표시용 context 저장

  /// 앱 시작 시 호출 (context는 스낵바 표시용)
  Future<void> init({BuildContext? context}) async {
    _context = context;
    WidgetsBinding.instance.addObserver(this);
    await _connect();
  }

  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _disconnect();
  }

  Future<void> _connect() async {
    if (_subscription != null && _isConnected) {
      print("[SSEManager] 이미 연결되어 있음, 재연결 생략");
      return;
    }

    print("[SSEManager] SSE 연결 시도...");
    _isConnected = true;

    _subscription = await remoteDataSource.subscribeToNotifications(
      onNotificationReceived: (data) {
        print("[SSEManager] 알림 수신됨: $data");

        final parsed = jsonDecode(data);
        final title = parsed['title'] ?? '알림';
        final body = parsed['body'] ?? '';

        print("[SSEManager] 알림 내용: $title - $body");

        if (rootScaffoldMessengerKey.currentState != null) {
          print("[SSEManager] ScaffoldMessenger 존재함, 스낵바 띄우기 시도");
          rootScaffoldMessengerKey.currentState!
            ..clearSnackBars()
            ..showSnackBar(SnackBar(
              content: Text('$title: $body'),
              duration: const Duration(seconds: 3),
            ));
        } else {
          print("[SSEManager] ScaffoldMessenger가 null임, 스낵바 실패");
        }

        showLocalNotification(title, body);
      },
    );
  }

  Future<void> connectIfNeeded({BuildContext? context}) async {
    _context = context ?? _context;

    if (_isConnected) {
      print("[SSEManager] 이미 연결되어 있음");
      return;
    }

    await _connect();
  }

  Future<void> _disconnect() async {
    if (_subscription != null) {
      print("SSE 연결 해제");
      await _subscription?.cancel();
      _subscription = null;
    }
    _isConnected = false;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _connect();
    } else if (state == AppLifecycleState.paused) {
      _disconnect();
    }
  }
}
