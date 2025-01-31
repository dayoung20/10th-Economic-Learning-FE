import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSelectController extends GetxController {
  late BuildContext context;

  // 업종 선택 상태
  var selectedJob = Rx<String?>(null);

  // 저장하기 버튼 클릭 여부
  var saveButtonClicked = false.obs;

  /// 프로필 설정 페이지로 이동
  void navigateToProfileSetting() {
    Get.toNamed('/profile_setting');
  }

  /// 업종 선택 (선택/해제 가능)
  void selectJob(String job) {
    selectedJob.value = (selectedJob.value == job) ? null : job;
    _updateProfileField('businessType', selectedJob.value);
  }

  /// `ProfileSettingController`의 `updateProfileField()`를 활용하여 업종 자동 저장
  void _updateProfileField(String key, dynamic value) {
    Get.find<ProfileSettingController>().updateProfileField(key, value);
    _updateSaveButtonState();
  }

  /// 저장 버튼 상태 업데이트
  void _updateSaveButtonState() {
    saveButtonClicked.value = selectedJob.value != null;
  }

  /// 저장 버튼 클릭 → ProfileSettingController에 상태 반영
  void onSaveButtonClicked() {
    saveButtonClicked.value = true;
    Get.find<ProfileSettingController>().updateJobSaveButtonClicked();
    navigateToProfileSetting();
  }
}
