import 'dart:async';
import 'dart:convert';

import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/utils/notification_utils.dart';
import 'package:flutter/material.dart';

class SSEManager with WidgetsBindingObserver {
  final remoteDataSource = RemoteDataSource();
  static final SSEManager _instance = SSEManager._internal();

  factory SSEManager() => _instance;

  SSEManager._internal();

  bool _isConnected = false;
  StreamSubscription? _subscription;

  Future<void> init() async {
    WidgetsBinding.instance.addObserver(this);
    await _connect();
  }

  Future<void> dispose() async {
    WidgetsBinding.instance.removeObserver(this);
    await _disconnect();
  }

  Future<void> _connect() async {
    if (_isConnected) return;

    print("SSE 연결 시도...");
    _isConnected = true;

    _subscription = await remoteDataSource.subscribeToNotifications(
      onNotificationReceived: (data) {
        final parsed = jsonDecode(data);
        showLocalNotification(parsed['title'], parsed['body']);
      },
    ).then((stream) => stream?.listen((_) {}, onError: (_) {
          print("SSE 오류 발생");
        }));
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
