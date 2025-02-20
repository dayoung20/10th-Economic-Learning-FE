import 'dart:io';

import 'package:economic_fe/data/services/date_picker_service.dart';
import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BasicController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // ImagePickerService 인스턴스
  final ImagePickerService _imagePickerService = ImagePickerService();

  var selectedProfileImage = Rx<String?>(null); // 로컬 이미지 파일 경로
  var profileImageURL = Rx<String?>(null); // 서버에서 받은 프로필 이미지 URL
  var imageId = Rxn<int>(); // 업로드된 이미지 ID (API 전송용)

  // 닉네임 입력값과 유효성 상태 관리
  var isDeleteMode = false.obs; // 삭제 모드 활성화 여부
  var nickname = ''.obs;
  var isValid = false.obs;
  var errorMessage = ''.obs;

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

  @override
  void onInit() {
    super.onInit();

    final profileController = Get.find<ProfileSettingController>();

    if (profileController.isEditMode) {
      // 기존 프로필 데이터 불러오기
      final user = profileController.userProfile.value;

      nicknameController.text = user.nickname;
      selectedGender.value = user.gender;
      selectedBirthday.value = user.birthDate;
      userInputController.text = user.profileIntro;

      profileImageURL.value = user.profileImageURL; // 서버에서 받은 프로필 이미지 사용
      imageId.value = user.imageId; // 기존 업로드된 이미지 ID

      // 닉네임이 유효한 상태로 설정
      isValid.value = user.nickname.length >= 2 && user.nickname.length <= 10;

      _updateSaveButtonState();
    }
  }

  /// 프로필 설정 페이지로 이동
  void navigateToProfileSetting() {
    Get.toNamed('/profile_setting');
  }

  /// 프로필 사진 선택
  Future<void> selectProfileImage(BuildContext context) async {
    final image = await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      selectedProfileImage.value = image.path;
      profileImageURL.value = null; // 기존 URL 제거

      // 이미지 업로드 후 imageId 받아오기
      int? uploadedImageId =
          await remoteDataSource.uploadProfileImage(File(image.path));

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
      bool isDeleted = await remoteDataSource.deleteImage(imageId.value!);

      if (isDeleted) {
        // 프로필 이미지 초기화
        imageId.value = null; // imageId를 null로 설정
        selectedProfileImage.value = null;
        profileImageURL.value = null; // 기본 이미지로 설정

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
    final profileController = Get.find<ProfileSettingController>();

    // 닉네임이 기존과 동일한 경우, 유효하다고 간주하여 체크 표시 유지
    if (profileController.isEditMode &&
        value == profileController.userProfile.value.nickname) {
      isValid.value = true;
      return;
    }

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
    _updateSaveButtonState();
  }

  /// 성별 선택 (서버 전송 값 `MALE` / `FEMALE`)
  void selectGender(String gender) {
    // if (gender == selectedGender.value) return; // 변경 없음
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
      String newDate =
          '${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}';
      // if (newDate == selectedBirthday.value) return; // 변경 없음
      selectedBirthday.value = newDate;
      _updateProfileField('birthDate', newDate);

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
