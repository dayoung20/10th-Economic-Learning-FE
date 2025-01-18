import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  // 등록 버튼 활성화 상태 관리
  var isUploadBtnEnabled = false.obs;

  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  // 게시물 제목 입력 controller
  final TextEditingController titleController = TextEditingController();

  // 게시물 내용 입력 controller
  final TextEditingController contentController = TextEditingController();

  var contentLength = 0.obs; // 글자수를 추적할 Rx 변수

  @override
  void onInit() {
    super.onInit();
    contentController.addListener(_updateContentLength);
  }

  @override
  void onClose() {
    contentController.removeListener(_updateContentLength);
    contentController.dispose();
    titleController.dispose();
    super.onClose();
  }

  void _updateContentLength() {
    contentLength.value = contentController.text.length;
    isUploadBtnEnabled.value = contentLength.value > 0 &&
        contentLength.value <= 3500 &&
        titleController.text.isNotEmpty;
  }

  // 일반 게시판 화면으로 이동
  void toDetailPage() {
    // 게시물 등록 API 연결 로직
    Get.snackbar('등록 성공', '게시물이 성공적으로 등록되었습니다.');
    Get.toNamed('/community');
  }

  // 카메라 또는 갤러리에서 이미지 선택
  var attachedImages = <XFile>[].obs; // 첨부된 이미지 리스트
  final ImagePicker _picker = ImagePicker();
  Future<void> pickImage(ImageSource source) async {
    if (attachedImages.length >= 5) {
      Get.snackbar('알림', '사진은 최대 5개까지 첨부할 수 있습니다.');
      return;
    }
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      attachedImages.add(image);
    }
  }
}
