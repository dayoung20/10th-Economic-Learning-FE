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

  /// 회원 탈퇴 기능
  Future<void> deleteAccount() async {
    isLoading.value = true;

    try {
      bool success = await remoteDataSource.deleteUser();

      if (success) {
        // SharedPreferences에서 사용자 정보 제거
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();

        // 온보딩 또는 로그인 화면으로 이동
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed("/");
        });

        Get.snackbar("탈퇴 완료", "회원탈퇴가 정상적으로 처리되었습니다.",
            snackPosition: SnackPosition.BOTTOM);
      } else {
        Get.snackbar("탈퇴 실패", "회원탈퇴에 실패했습니다.",
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar("오류", "회원탈퇴 중 문제가 발생했습니다.",
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }
}
