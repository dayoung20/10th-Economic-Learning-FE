import 'dart:developer';

import 'package:economic_fe/data/services/date_picker_service.dart';
import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class BasicController extends GetxController {
  late BuildContext context;

  // ImagePickerService 인스턴스
  final ImagePickerService _imagePickerService = ImagePickerService();
  var selectedProfileImage = Rx<String?>(null); // 선택된 프로필 이미지 경로를 저장

  // 닉네임 입력값과 그 유효성 상태 관리
  var nickname = ''.obs;
  var isValid = false.obs;
  var errorMessage = ''.obs;

  // 성별 선택 상태
  var selectedGender = Rx<String?>(null);

  // 날짜 선택 서비스 인스턴스 생성
  final DatePickerService _datePickerService = DatePickerService();
  // 생년월일
  var selectedBirthday = Rx<String?>(null);

  // 한 줄 소개
  var userInput = ''.obs; // 사용자 입력 값
  var currentLength = 0.obs; // 현재 글자 수
  final int maxLength = 70; // 최대 글자 수

  // 저장하기 버튼 클릭 여부 추적
  var saveButtonClicked = false.obs; // 이 값을 통해 저장 버튼 클릭 여부를 추적

  // 프로필 설정 화면으로 전환
  void navigateToProfileSetting(BuildContext context) {
    // context.go('/profile_setting');
    Get.toNamed('/profile_setting');
  }

  // 프로필 사진 선택 함수 (갤러리 또는 카메라)
  Future<void> selectProfileImage(BuildContext context) async {
    // 이미지 선택 다이얼로그
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('프로필 사진 선택'),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                var image = await _imagePickerService.pickImageFromGallery();
                if (image != null) {
                  selectedProfileImage.value = image.path; // 이미지 경로 저장
                  print('Selected image path: ${image.path}');
                }
              },
              child: const Text('갤러리'),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                var image = await _imagePickerService.pickImageFromCamera();
                if (image != null) {
                  selectedProfileImage.value = image.path; // 이미지 경로 저장
                  print('Captured image path: ${image.path}');
                }
              },
              child: const Text('카메라'),
            ),
          ],
        );
      },
    );
  }

  // 닉네임 유효성 검사
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

    // 실시간으로 saveButton 상태 업데이트
    _updateSaveButtonState();
  }

  // 성별 선택 상태 관리
  void selectGender(String gender) {
    // 성별을 선택하면 해당 성별로 상태 업데이트
    if (selectedGender.value == gender) {
      selectedGender.value = null; // 이미 선택된 성별을 다시 클릭하면 선택 해제
    } else {
      selectedGender.value = gender;
    }
  }

  // 생년월일 선택 함수
  Future<void> selectBirthday(BuildContext context) async {
    DateTime? pickedDate = await _datePickerService.pickDate(context);
    if (pickedDate != null) {
      selectedBirthday.value =
          '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
    }

    // 실시간으로 saveButton 상태 업데이트
    _updateSaveButtonState();
  }

  // 텍스트 길이와 상태 업데이트
  void onTextChanged(String value) {
    userInput.value = value;
    currentLength.value = value.length;
  }

  // 저장하기 버튼 활성화 여부를 실시간으로 업데이트
  void _updateSaveButtonState() {
    // 닉네임이 유효하고, 연령대가 선택되었을 때만 버튼을 활성화
    if (isValid.value && selectedBirthday.value != null) {
      saveButtonClicked.value = true;
    } else {
      saveButtonClicked.value = false;
    }
  }

  // 저장하기 버튼 클릭 상태 업데이트
  void onSaveButtonClicked() async {
    Get.find<ProfileSettingController>().updateBasicInfo(
      ageRange: selectedBirthday.value!,
      gender: selectedGender.value!,
      profileIntro: userInput.value,
    );
    Get.find<ProfileSettingController>().updateNickname(nickname.value);
    saveButtonClicked.value = true; // 상태 변경
    Get.find<ProfileSettingController>().updateBasicSaveButtonClicked();
  }
}
