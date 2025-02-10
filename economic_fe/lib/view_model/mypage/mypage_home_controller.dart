import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageHomeController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();
  final ImagePickerService _imagePickerService = ImagePickerService();
  var selectedProfileImage = Rx<String?>(null);

  // 요일 체크 상태 관리 (월~일)
  var isCheckedList =
      <bool>[false, false, false, false, false, false, false].obs;

  @override
  void onInit() {
    super.onInit();
    fetchWeeklyAttendanceStatus(); // 컨트롤러 초기화 시 출석 상태 불러오기
  }

  // 요일별 출석 현황 조회 후 isCheckedList 업데이트
  Future<void> fetchWeeklyAttendanceStatus() async {
    try {
      var attendanceData = await _remoteDataSource.fetchWeeklyAttendance();

      // API 응답값을 isCheckedList에 적용
      isCheckedList.value = [
        attendanceData["monday"] ?? false,
        attendanceData["tuesday"] ?? false,
        attendanceData["wednesday"] ?? false,
        attendanceData["thursday"] ?? false,
        attendanceData["friday"] ?? false,
        attendanceData["saturday"] ?? false,
        attendanceData["sunday"] ?? false,
      ];
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
