import 'dart:io';

import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/widgets/community/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  // 등록 버튼 활성화 상태 관리
  var isUploadBtnEnabled = false.obs;

  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리별 서버 타입 매핑
  final List<String> postCategories = [
    "FREE",
    "QUESTION",
    "BOOK_RECOMMENDATION",
    "INFORMATION"
  ];

  // 게시물 제목 입력 controller
  final TextEditingController titleController = TextEditingController();

  // 게시물 내용 입력 controller
  final TextEditingController contentController = TextEditingController();
  var contentLength = 0.obs; // 글자수를 추적할 Rx 변수

  // Image Picker Service 추가
  final ImagePickerService _imagePickerService = ImagePickerService();

  // 첨부된 이미지 리스트
  // var attachedImages = <XFile>[].obs;
  // final ImagePicker _picker = ImagePicker();
  var attachedImages = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    // contentController.addListener(_updateContentLength);
    contentController.addListener(_updateFormStatus);
    titleController.addListener(_updateFormStatus);
  }

  @override
  void onClose() {
    // contentController.removeListener(_updateContentLength);
    contentController.removeListener(_updateFormStatus);
    titleController.removeListener(_updateFormStatus);
    contentController.dispose();
    titleController.dispose();
    super.onClose();
  }

  // 내용 글자수 및 제목 입력 여부에 따라 등록 버튼 활성화 업데이트
  void _updateFormStatus() {
    contentLength.value = contentController.text.length;
    isUploadBtnEnabled.value = titleController.text.isNotEmpty &&
        contentLength.value > 0 &&
        contentLength.value <= 3500;
  }

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  // 사진 선택 (갤러리 또는 카메라)
  Future<void> pickImage(BuildContext context) async {
    if (attachedImages.length >= 5) {
      Get.snackbar('알림', '사진은 최대 5개까지 첨부할 수 있습니다.');
      return;
    }

    final XFile? image =
        await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      File file = File(image.path);

      // 이미지 업로드 후 `imageId` 가져오기
      int? imageId = await RemoteDataSource.uploadImage(file);
      if (imageId != null) {
        attachedImages.add({
          'file': file,
          'imageId': imageId,
        });
      } else {
        Get.snackbar('이미지 업로드 실패', '이미지를 서버에 업로드하는 데 실패했습니다.');
      }
    }
  }

// 사진 삭제 다이얼로그 적용 (삭제 후 다이얼로그 닫기)
  Future<void> confirmDeleteImage(int index, BuildContext context) async {
    OptionsDialog.showConfirmationDialog(
      context: context,
      content: '사진을 삭제하시겠어요?', // 사진 삭제 메시지
      isReport: false, // 신고가 아닌 삭제
      onConfirm: () async {
        Navigator.of(context).pop(); // 다이얼로그 먼저 닫기

        int imageId = attachedImages[index]['imageId'];

        bool success = await RemoteDataSource.deleteImage(imageId);
        if (success) {
          attachedImages.removeAt(index);
          Get.snackbar('삭제 완료', '사진이 삭제되었습니다.');
        } else {
          Get.snackbar('삭제 실패', '서버에서 사진 삭제에 실패했습니다.');
        }
      },
    );
  }

  /// **게시물 등록 API 호출**
  Future<void> submitPost() async {
    if (!isUploadBtnEnabled.value) {
      Get.snackbar('알림', '게시물 제목과 내용을 입력해주세요.');
      return;
    }

    String selectedCategory = postCategories[selectedCategoryIndex.value];

    // 이미지 파일 리스트 생성
    List<int> imageIds =
        attachedImages.map((e) => e['imageId'] as int).toList();

    try {
      bool success = await RemoteDataSource.createPost(
        title: titleController.text,
        content: contentController.text,
        type: selectedCategory,
        imageIds: imageIds,
      );

      if (success) {
        Get.snackbar('등록 성공', '게시물이 성공적으로 등록되었습니다.');

        // **등록 후 입력 필드 초기화**
        titleController.clear();
        contentController.clear();
        attachedImages.clear();

        // **커뮤니티 메인 페이지로 이동**
        Get.offNamed('/community');
      } else {
        Get.snackbar('등록 실패', '게시물 등록 중 오류가 발생했습니다.');
      }
    } catch (e) {
      debugPrint("게시물 등록 중 예외 발생: $e");
      Get.snackbar('등록 오류', '네트워크 오류가 발생했습니다.');
    }
  }
}
