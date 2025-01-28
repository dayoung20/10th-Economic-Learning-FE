import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageHomeController extends GetxController {
  final ImagePickerService _imagePickerService = ImagePickerService();
  var selectedProfileImage = Rx<String?>(null);

  // 프로필 사진 선택 함수
  Future<void> selectProfileImage(BuildContext context) async {
    final image = await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      selectedProfileImage.value = image.path; // 이미지 경로 저장
      print('Selected image path: ${image.path}');
    }
  }

  // 요일 체크 상태 관리
  var isCheckedList = <bool>[true, true, false, true, true, true, false].obs;
}
