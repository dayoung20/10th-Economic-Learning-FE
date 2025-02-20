import 'dart:io';

import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ProfileSettingController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // 저장 버튼 상태
  var basicSaveButtonClicked = false.obs;
  var jobSaveButtonClicked = false.obs;
  var partSaveButtonClicked = false.obs;

  // 사용자 프로필 데이터
  var userProfile = UserProfile(
    nickname: '',
    birthDate: '',
    gender: '',
    profileIntro: '',
    businessType: '',
    job: '',
    imageId: null,
  ).obs;

  // 입력 완료 여부
  var isInfoCompleted = false.obs;
  var isBusinessCompleted = false.obs;
  var isJobCompleted = false.obs;

  /// 모든 필수 데이터가 입력되었는지 확인
  bool get isProfileReady {
    bool ready = isInfoCompleted.value &&
        isBusinessCompleted.value &&
        isJobCompleted.value;
    return ready;
  }

  /// 이전 화면으로 이동
  void goBack() {
    Get.back();
  }

  /// 개별 입력 필드 업데이트
  void updateProfileField(String key, dynamic value) {
    userProfile.update((profile) {
      if (profile != null) {
        switch (key) {
          case 'nickname':
            profile.nickname = value;
            break;
          case 'birthDate':
            profile.birthDate = value;
            break;
          case 'gender':
            profile.gender = value;
            break;
          case 'profileIntro':
            profile.profileIntro = value;
            break;
          case 'businessType':
            profile.businessType = value;
            isBusinessCompleted.value = value.isNotEmpty;
            break;
          case 'job':
            profile.job = value;
            isJobCompleted.value = value.isNotEmpty;
            break;
          case 'imageId':
            profile.imageId = value;
            break;
        }
      }
    });

    // 프로필 입력 상태 업데이트
    updateProfileCompletionStatus();
  }

  /// 프로필 입력 완료 여부 업데이트
  void updateProfileCompletionStatus() {
    bool infoCompleted = userProfile.value.nickname.isNotEmpty &&
        userProfile.value.birthDate.isNotEmpty &&
        userProfile.value.gender.isNotEmpty;

    isInfoCompleted.value = infoCompleted;
  }

  /// 저장 버튼 상태 업데이트 - 기본 정보
  void updateBasicSaveButtonClicked() {
    basicSaveButtonClicked.value =
        Get.find<BasicController>().saveButtonClicked.value;
    updateProfileCompletionStatus(); // 입력 상태 즉시 반영
  }

  /// 저장 버튼 상태 업데이트 - 업종
  void updateJobSaveButtonClicked() {
    jobSaveButtonClicked.value =
        Get.find<JobSelectController>().saveButtonClicked.value;
    updateProfileCompletionStatus();
  }

  /// 저장 버튼 상태 업데이트 - 직무
  void updatePartSaveButtonClicked() {
    partSaveButtonClicked.value =
        Get.find<PartSelectController>().saveButtonClicked.value;
    updateProfileCompletionStatus();
  }

  /// 사용자 프로필 저장 API 호출
  Future<void> saveUserProfile() async {
    if (!isProfileReady) {
      Get.snackbar('알림', '모든 정보를 입력해주세요.');
      return;
    }

    try {
      // // **1. 알림 권한 요청 (완료될 때까지 대기)**
      // bool isNotificationAllowed = await requestNotificationPermission();

      // // **2. 사용자의 선택값을 반영하여 userProfile 업데이트**
      // userProfile.update((profile) {
      //   if (profile != null) {
      //     profile.isLearningAlarmAllowed = isNotificationAllowed;
      //     profile.isCommunityAlarmAllowed = isNotificationAllowed;
      //   }
      // });

      // // **3. 알림을 허용한 경우, SSE 구독 API 호출 (성공 여부 확인)**
      // if (isNotificationAllowed) {
      //   debugPrint("알림 허용됨 - 알림 구독 API 호출 시작");
      //   bool sseSuccess = await remoteDataSource.subscribeToNotifications();
      //   if (!sseSuccess) {
      //     debugPrint("SSE 구독 실패");
      //     Get.snackbar('오류', '푸쉬 알림 구독에 실패했습니다. 네트워크를 확인해주세요.');
      //   } else {
      //     debugPrint("알림 구독 API 호출 완료");
      //   }
      // }

      // **4. 프로필 데이터 준비**
      Map<String, dynamic> profileData = userProfile.value.toJson();
      if (profileData['imageId'] == null) {
        profileData.remove('imageId');
      }

      print("전송 데이터: $profileData");

      // **5. 서버에 프로필 등록 요청**
      final response = await remoteDataSource.registerUserProfile(profileData);

      // **6. 응답 확인 후 처리**
      if (response['isSuccess'] == true) {
        Get.snackbar('성공', '프로필 등록이 완료되었습니다.');
        Get.offAllNamed('/home'); // 홈 화면으로 이동
      } else {
        switch (response['code']) {
          case 'DUPLICATED_NICKNAME':
            Get.snackbar('오류', '닉네임이 중복되었습니다. 다른 닉네임을 사용해주세요.');
            break;
          case 'INTERNAL_SERVER_ERROR':
            Get.snackbar('오류', '서버 내부 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
            break;
          default:
            Get.snackbar('오류', response['message'] ?? '프로필 등록에 실패했습니다.');
        }
      }
    } catch (e) {
      Get.snackbar('오류', '네트워크 오류가 발생했습니다. 다시 시도해주세요.');
      print('프로필 저장 오류: $e');
    }
  }

  // 알림 권한 요청 함수
  Future<bool> requestNotificationPermission() async {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    if (Platform.isIOS) {
      // iOS에서 푸시 알림 권한 요청
      final iosPlugin =
          flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>();

      if (iosPlugin == null) {
        debugPrint('iOS 알림 플러그인 초기화 실패');
        return false;
      }

      final result = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint('알림 권한 요청 결과 (iOS): $result');

      if (result == true) {
        debugPrint('알림 권한 허용됨 (iOS)');
        return true;
      } else {
        debugPrint('알림 권한 거부됨 (iOS)');
        return false;
      }
    } else {
      // Android에서는 permission_handler 사용
      PermissionStatus status = await Permission.notification.request();

      debugPrint('알림 권한 요청 결과 (Android): $status');

      if (status.isGranted) {
        debugPrint('알림 권한 허용됨 (Android)');
        return true;
      } else if (status.isPermanentlyDenied) {
        debugPrint('알림 권한 요청이 거부됨 - 설정 화면으로 이동 필요 (Android)');
        await openAppSettings();
        return false;
      } else {
        debugPrint('알림 권한 거부됨 (Android)');
        return false;
      }
    }
  }
}
