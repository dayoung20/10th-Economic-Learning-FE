import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class JobSelectController extends GetxController {
  late BuildContext context;

  // 업종 선택 상태
  var selectedJob = Rx<String?>(null);

  // 저장하기 버튼 클릭 여부 추적
  var saveButtonClicked = false.obs; // 이 값을 통해 저장 버튼 클릭 여부를 추적

  // 프로필 설정 화면으로 전환
  void navigateToProfileSetting(BuildContext context) {
    context.go('/profile_setting');
  }

  // 업종 선택
  void selectJob(String job) {
    if (selectedJob.value == job) {
      selectedJob.value = null; // 이미 선택된 업종 클릭 시 해제
    } else {
      selectedJob.value = job;
    }
  }

  // 저장하기 버튼 클릭 상태 업데이트
  void onSaveButtonClicked() {
    saveButtonClicked.value = true; // 버튼 클릭 시 상태 변경
    // ProfileSettingController에 있는 메서드 호출
    Get.find<ProfileSettingController>().updateJobSaveButtonClicked();
  }
}
