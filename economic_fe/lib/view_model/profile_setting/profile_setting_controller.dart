import 'package:economic_fe/data/models/user_profile.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:get/get.dart';

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

    Map<String, dynamic> profileData = userProfile.value.toJson();
    if (profileData['imageId'] == null) {
      profileData.remove('imageId');
    }

    print("전송 데이터: $profileData");

    try {
      final response = await remoteDataSource.registerUserProfile(profileData);

      if (response['isSuccess'] == true) {
        Get.snackbar('성공', '프로필 등록이 완료되었습니다.');
        Get.offAllNamed('/home');
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
}
