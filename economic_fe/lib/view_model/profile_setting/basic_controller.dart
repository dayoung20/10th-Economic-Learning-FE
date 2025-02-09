import 'dart:io';

import 'package:economic_fe/data/services/date_picker_service.dart';
import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicController extends GetxController {
  // ImagePickerService 인스턴스
  final ImagePickerService _imagePickerService = ImagePickerService();
  var selectedProfileImage = Rx<String?>(null);

  // 닉네임 입력값과 유효성 상태 관리
  var nickname = ''.obs;
  var isValid = false.obs;
  var errorMessage = ''.obs;

  // 프로필 이미지
  var imageId = Rxn<int>();

  // 삭제 모드 활성화 여부
  var isDeleteMode = false.obs;

  // 닉네임 입력 컨트롤러 (키보드 입력 문제 해결)
  final TextEditingController nicknameController = TextEditingController();

  // 성별 선택 상태 (서버 전송 값 `MALE` / `FEMALE` 로 저장)
  var selectedGender = Rxn<String>();

  // 생년월일 선택 상태
  final DatePickerService _datePickerService = DatePickerService();
  var selectedBirthday = Rx<String?>(null);

  // 한 줄 소개
  var userInput = ''.obs;
  var currentLength = 0.obs;
  final int maxLength = 70;

  // 한 줄 소개 입력 컨트롤러 (키보드 입력 문제 해결)
  final TextEditingController userInputController = TextEditingController();

  // 저장 버튼 클릭 여부
  var saveButtonClicked = false.obs;

  /// 프로필 설정 페이지로 이동
  void navigateToProfileSetting() {
    Get.toNamed('/profile_setting');
  }

  /// 프로필 사진 선택
  Future<void> selectProfileImage(BuildContext context) async {
    final image = await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      selectedProfileImage.value = image.path;

      // 이미지 업로드 후 imageId 받아오기
      int? uploadedImageId =
          await RemoteDataSource.uploadProfileImage(File(image.path));

      if (uploadedImageId != null) {
        imageId.value = uploadedImageId; // Rxn<int>로 변경
        imageId.refresh(); // UI에 반영

        // ProfileSettingController에 imageId 업데이트
        Get.find<ProfileSettingController>()
            .updateProfileField('imageId', imageId.value);
        Get.snackbar('성공', '프로필 이미지가 업데이트되었습니다.');
      } else {
        Get.snackbar('실패', '프로필 이미지 등록에 실패하였습니다.');
      }
    }
  }

  /// 프로필 이미지 삭제 메서드
  Future<void> deleteProfileImage() async {
    final ProfileSettingController profileController =
        Get.find<ProfileSettingController>();

    if (imageId.value != null) {
      bool isDeleted = await RemoteDataSource.deleteImage(imageId.value!);

      if (isDeleted) {
        // 프로필 이미지 초기화
        imageId.value = null; // imageId를 null로 설정
        selectedProfileImage.value = null;
        imageId.refresh(); // UI 반영
        profileController.updateProfileField('imageId', null);

        Get.snackbar('성공', '프로필 이미지가 삭제되었습니다.');
      } else {
        Get.snackbar('오류', '이미지 삭제에 실패했습니다.');
      }
    }
  }

  /// 닉네임 유효성 검사
  void validateNickname(String value) {
    nickname.value = value;

    if (value.length < 2) {
      isValid.value = false;
      errorMessage.value = '2자 이상 입력하세요';
    } else if (value.length > 10) {
      isValid.value = false;
      errorMessage.value = '10자 이하로 입력하세요';
    } else {
      isValid.value = true;
      errorMessage.value = '';
    }

    _updateProfileField('nickname', value);

    // 저장 버튼 상태 업데이트
    _updateSaveButtonState();
  }

  /// 성별 선택 (서버 전송 값 `MALE` / `FEMALE`)
  void selectGender(String gender) {
    selectedGender.value = gender;

    // ProfileSettingController에 업데이트 반영
    Get.find<ProfileSettingController>()
        .updateProfileField('gender', selectedGender.value);

    // UI 강제 업데이트
    selectedGender.refresh();

    // 저장 버튼 상태 업데이트
    _updateSaveButtonState();
  }

  /// 생년월일 선택
  Future<void> selectBirthday(BuildContext context) async {
    DateTime? pickedDate = await _datePickerService.pickDate(context);
    if (pickedDate != null) {
      selectedBirthday.value =
          '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      _updateProfileField('birthDate', selectedBirthday.value);

      // 저장 버튼 상태 업데이트
      _updateSaveButtonState();
    }
  }

  /// 한 줄 소개 입력 처리
  void onTextChanged(String value) {
    userInput.value = value;
    currentLength.value = value.length;
    _updateProfileField('profileIntro', value);
  }

  /// 프로필 필드 업데이트 → ProfileSettingController에 반영
  void _updateProfileField(String key, dynamic value) {
    Get.find<ProfileSettingController>().updateProfileField(key, value);
    _updateSaveButtonState();
  }

  /// 저장 버튼 상태 업데이트
  void _updateSaveButtonState() {
    saveButtonClicked.value = isValid.value &&
        selectedGender.value != null &&
        selectedBirthday.value != null;
  }

  /// 저장 버튼 클릭 → ProfileSettingController에 상태 반영
  void onSaveButtonClicked() {
    saveButtonClicked.value = true;
    Get.find<ProfileSettingController>().updateBasicSaveButtonClicked();
    navigateToProfileSetting();
  }
}
