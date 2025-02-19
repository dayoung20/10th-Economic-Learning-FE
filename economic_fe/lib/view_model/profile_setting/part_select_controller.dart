import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartSelectController extends GetxController {
  late BuildContext context;

  // 직무 선택 상태
  var selectedPart = Rx<String?>(null);

  // 저장하기 버튼 클릭 여부
  var saveButtonClicked = false.obs;

  @override
  void onInit() {
    super.onInit();

    final profileController = Get.find<ProfileSettingController>();

    if (profileController.isEditMode) {
      selectedPart.value = profileController.userProfile.value.job;
    }
  }

  /// 프로필 설정 페이지로 이동
  void navigateToProfileSetting() {
    Get.toNamed('/profile_setting');
  }

  /// 직무 선택
  void selectPart(String part) {
    if (selectedPart.value == part) {
      // 이미 선택된 직무를 다시 클릭하면 아무 동작도 수행하지 않음
      return;
    }

    // 새로운 직무 선택
    selectedPart.value = part;
    Get.find<ProfileSettingController>().updateProfileField('job', part);

    // Rx 상태 강제 업데이트
    Future.delayed(Duration.zero, () {
      selectedPart.refresh();
      _updateSaveButtonState();
    });
  }

  // /// `ProfileSettingController`의 `updateProfileField()`를 활용하여 업종 자동 저장
  // void _updateProfileField(String key, dynamic value) {
  //   Get.find<ProfileSettingController>().updateProfileField(key, value);
  //   _updateSaveButtonState();
  // }

  /// 저장 버튼 상태 업데이트
  void _updateSaveButtonState() {
    saveButtonClicked.value = selectedPart.value != null;
    saveButtonClicked.refresh(); // Rx 상태 강제 업데이트
  }

  /// 저장 버튼 클릭 → ProfileSettingController에 상태 반영
  void onSaveButtonClicked() {
    saveButtonClicked.value = true;
    Get.find<ProfileSettingController>().updatePartSaveButtonClicked();
    navigateToProfileSetting();
  }
}
