import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:get/get.dart';

class ProfileSettingController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  var isEditMode = Get.arguments != null; // 수정 모드 여부 확인

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
    profileImageURL: null,
  ).obs;

  late UserProfile oldProfile; // 기존 프로필 데이터 저장

  // 입력 완료 여부
  var isInfoCompleted = false.obs;
  var isBusinessCompleted = false.obs;
  var isJobCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();

    if (isEditMode) {
      // 기존 프로필 정보를 불러오기
      oldProfile = Get.arguments as UserProfile;
      userProfile.value = UserProfile(
        nickname: oldProfile.nickname,
        birthDate: oldProfile.birthDate,
        gender: oldProfile.gender,
        profileIntro: oldProfile.profileIntro,
        businessType: oldProfile.businessType,
        job: oldProfile.job,
        imageId: oldProfile.imageId,
        profileImageURL: oldProfile.profileImageURL,
      );

      // 기존 데이터 기반으로 입력 상태 업데이트
      isInfoCompleted.value = true;
    }
  }

  // /// 모든 필수 데이터가 입력되었는지 확인
  // bool get isProfileReady {
  //   bool ready = isInfoCompleted.value &&
  //       isBusinessCompleted.value &&
  //       isJobCompleted.value;
  //   return ready;
  // }

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

  /// 변경된 값만 API에 전송
  Future<void> saveUserProfile() async {
    if (!isInfoCompleted.value) {
      Get.snackbar('알림', '모든 정보를 입력해주세요.');
      return;
    }

    Map<String, dynamic> profileData = {};

    // 닉네임 비교
    if (userProfile.value.nickname != oldProfile.nickname) {
      profileData['nickname'] = userProfile.value.nickname;
    }

    // 생년월일 비교
    if (userProfile.value.birthDate != oldProfile.birthDate) {
      profileData['birthDate'] = userProfile.value.birthDate;
    }

    // 성별 비교
    if (userProfile.value.gender != oldProfile.gender) {
      profileData['gender'] = userProfile.value.gender;
    }

    // 한 줄 소개 비교
    if (userProfile.value.profileIntro != oldProfile.profileIntro) {
      profileData['profileIntro'] = userProfile.value.profileIntro;
    }

    // 업종 비교
    if (userProfile.value.businessType != oldProfile.businessType) {
      profileData['businessType'] = userProfile.value.businessType;
    }

    // 직무 비교
    if (userProfile.value.job != oldProfile.job) {
      profileData['job'] = userProfile.value.job;
    }

    // 프로필 사진 비교 (imageId만 전송)
    if (userProfile.value.imageId != oldProfile.imageId) {
      profileData['imageId'] = userProfile.value.imageId;
    }

    // **변경된 값이 없으면 API 호출하지 않음**
    if (profileData.isEmpty) {
      Get.snackbar('알림', '변경된 내용이 없습니다.');
      return;
    }

    print("변경된 데이터만 전송: $profileData");

    bool success = await remoteDataSource.updateUserProfile(profileData);

    if (success) {
      Get.snackbar('성공', isEditMode ? '프로필이 수정되었습니다.' : '프로필 등록이 완료되었습니다.');
      Get.offAllNamed(isEditMode ? '/mypage' : '/home');
    } else {
      Get.snackbar('오류', isEditMode ? '프로필 수정에 실패했습니다.' : '프로필 등록에 실패했습니다.');
    }
  }
}
