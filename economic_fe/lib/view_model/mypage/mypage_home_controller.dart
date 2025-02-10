import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageHomeController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final ImagePickerService _imagePickerService = ImagePickerService();

  var selectedProfileImage = Rx<String?>(null);
  var currentStreak = 0.obs; // 연속 출석 날짜

  // 요일 체크 상태 관리 (월~일)
  var isCheckedList =
      <bool>[false, false, false, false, false, false, false].obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentStreak();
    fetchWeeklyAttendanceStatus();
  }

  // 연속 출석 날짜 조회
  Future<void> fetchCurrentStreak() async {
    try {
      var response = await _remoteDataSource.fetchCurrentStreak();
      currentStreak.value = response;
    } catch (e) {
      debugPrint("fetchCurrentStreak() 오류 발생: $e");
      currentStreak.value = 0; // 오류 발생 시 기본값 설정
    }
  }

  // 요일별 출석 현황 조회 후 isCheckedList 업데이트
  Future<void> fetchWeeklyAttendanceStatus() async {
    try {
      var attendanceData = await _remoteDataSource.fetchWeeklyAttendance();

      if (attendanceData.isNotEmpty) {
        isCheckedList.value = [
          attendanceData["sunday"] ?? false,
          attendanceData["monday"] ?? false,
          attendanceData["tuesday"] ?? false,
          attendanceData["wednesday"] ?? false,
          attendanceData["thursday"] ?? false,
          attendanceData["friday"] ?? false,
          attendanceData["saturday"] ?? false,
        ];
      }
    } catch (e) {
      debugPrint("fetchWeeklyAttendanceStatus() 오류 발생: $e");
    }
  }

  // 프로필 사진 선택 함수
  Future<void> selectProfileImage(BuildContext context) async {
    final image = await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      selectedProfileImage.value = image.path; // 이미지 경로 저장
      print('Selected image path: ${image.path}');
    }
  }
}
