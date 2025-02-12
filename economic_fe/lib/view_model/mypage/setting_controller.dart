import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  // 알림 토글 관리
  var isToggled = true.obs;
  var isLoading = false.obs; // API 요청 상태

  // // 초기 알림 상태 가져오기
  // Future<void> fetchInitialAlarmSetting() async {
  //   try {
  //     var response = await remoteDataSource.fetchUserInfo();
  //     if (response.isNotEmpty) {
  //       UserProfile user = UserProfile.fromJson(response);
  //       isToggled.value = user.isCommunityAlarmAllowed ?? true; // 기본값 true
  //       debugPrint("기존 알림 설정 상태: ${user.isCommunityAlarmAllowed}");
  //     }
  //   } catch (e) {
  //     debugPrint("알림 설정 조회 오류: $e");
  //   }
  // }

  // 알림 토글 및 서버에 업데이트
  Future<void> toggle() async {
    if (isLoading.value) return; // 이미 요청 중이면 실행 안 함
    isLoading.value = true; // 로딩 시작

    bool newStatus = !isToggled.value;
    bool success = await remoteDataSource.setAlarm(newStatus);

    if (success) {
      isToggled.value = newStatus; // 성공 시 UI 업데이트
    } else {
      debugPrint("알림 설정 업데이트 실패");
    }

    isLoading.value = false; // 로딩 종료
  }
}
