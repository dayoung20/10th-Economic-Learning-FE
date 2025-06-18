import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  var isToggled = true.obs;
  var isLoading = false.obs;

  Future<void> toggle() async {
    if (isLoading.value) return;
    isLoading.value = true;

    bool newStatus = !isToggled.value;
    bool success = await remoteDataSource.setAlarm(newStatus);

    if (success) {
      isToggled.value = newStatus;
    } else {
      print("알림 설정 업데이트 실패");
    }

    isLoading.value = false;
  }

  /// 로그아웃 기능
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.setBool("isLoggedIn", false);

    // 추후 SSE 연결 해제 필요 시 여기에 추가
    // Get.find<PushNotificationController>().disconnectSse();

    // 온보딩 화면으로 이동
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed("/");
    });
  }
}
