import 'dart:developer';

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
}
