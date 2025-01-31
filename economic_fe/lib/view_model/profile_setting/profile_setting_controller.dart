import 'dart:developer';

import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class ProfileSettingController extends GetxController {
  late BuildContext context;

  // 저장하기 버튼이 클릭되었는지 확인하는 값
  var basicSaveButtonClicked = false.obs;
  var jobSaveButtonClicked = false.obs;
  var partSaveButtonClicked = false.obs;

  // 이전 화면으로 돌아가는 메서드
  void goBack() {
    Get.back();
  }

  // 기본 정보 설정 화면으로 전환
  void navigateToBasic(BuildContext context) {
    // context.go('/profile_setting/basic');
    Get.toNamed('/profile_setting/basic');
  }

  // 업종 선택 화면으로 전환
  void navigateToJob(BuildContext context) {
    // context.go('/profile_setting/job');
    Get.toNamed('/profile_setting/job');
  }

  // 직무 선택 화면으로 전환
  void navigateToPart(BuildContext context) {
    // context.go('/profile_setting/part');
    Get.toNamed('/profile_setting/part');
  }

  // 저장하기 버튼 클릭 여부를 업데이트하는 메서드 - 기본 정보
  void updateBasicSaveButtonClicked() {
    basicSaveButtonClicked.value =
        Get.find<BasicController>().saveButtonClicked.value;
  }

  // 저장하기 버튼 클릭 여부를 업데이트하는 메서드 - 업종
  void updateJobSaveButtonClicked() {
    jobSaveButtonClicked.value =
        Get.find<JobSelectController>().saveButtonClicked.value;
  }

  // 저장하기 버튼 클릭 여부를 업데이트하는 메서드 - 직무
  void updatePartSaveButtonClicked() {
    partSaveButtonClicked.value =
        Get.find<PartSelectController>().saveButtonClicked.value;
  }

  // 홈 화면으로 연결
  void toHomePage() {
    Get.toNamed('/home');
  }

  // 사용자 프로필 정보 통합 관리
  final Rx<UserProfile> userProfile = UserProfile(
    nickname: '',
    businessType: '',
    job: '',
    ageRange: '',
    gender: '',
  ).obs;

  void updateNickname(String nickname) {
    userProfile.update((profile) {
      profile?.nickname = nickname;
    });
  }

  void updateBusinessType(String businessType) {
    userProfile.update((profile) {
      profile?.businessType = businessType;
    });
  }

  void updateJob(String job) {
    userProfile.update((profile) {
      profile?.job = job;
    });
  }

  void updateBasicInfo({
    required String ageRange,
    required String gender,
    String? profileIntro,
  }) {
    userProfile.update((profile) {
      profile?.ageRange = ageRange;
      profile?.gender = gender;
      profile?.profileIntro = profileIntro;
    });
  }

  Future<void> saveUserProfile(String authToken) async {
    // 모든 저장 버튼이 클릭되었는지 확인
    if (!basicSaveButtonClicked.value ||
        !jobSaveButtonClicked.value ||
        !partSaveButtonClicked.value) {
      Get.snackbar('오류', '모든 항목을 완료해주세요.');
      return;
    }

    final response = await RemoteDataSource.postApiWithJson(
      'api/v1/user/profile',
      userProfile.value.toJson(), // Token 전달
    );

    if (response == 200) {
      Get.snackbar('성공', '프로필이 저장되었습니다.');
      toHomePage(); // 홈 화면으로 이동
    } else {
      Get.snackbar('오류', '프로필 저장 중 문제가 발생했습니다.');
    }
  }
}
