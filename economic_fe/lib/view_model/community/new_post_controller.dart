import 'dart:io';
import 'package:economic_fe/data/services/image_picker_service.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/widgets/community/option_dialog.dart';
import 'package:economic_fe/view_model/community/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostController extends GetxController {
  RxBool isUploadBtnEnabled = false.obs;
  RxInt selectedCategoryIndex = 0.obs;
  final List<String> postCategories = [
    "FREE",
    "QUESTION",
    "BOOK_RECOMMENDATION",
    "INFORMATION"
  ];

  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  RxInt contentLength = 0.obs;

  final ImagePickerService _imagePickerService = ImagePickerService();
  RxList<Map<String, dynamic>> attachedImages = <Map<String, dynamic>>[].obs;

  RxBool isEditing = false.obs; // 수정 모드 여부
  RxInt postId = (-1).obs; // 수정할 게시글 ID
  RxList<int> existingImageIds = <int>[].obs; // 기존 이미지 ID 리스트

  // 기존 데이터 저장용 변수 추가
  String originalTitle = "";
  String originalContent = "";
  int originalCategoryIndex = 0;

  @override
  void onInit() {
    super.onInit();

    if (Get.arguments != null) {
      Map<String, dynamic> postInfo = Get.arguments;

      postId.value = postInfo["id"];
      titleController.text = postInfo["title"] ?? "";
      contentController.text = postInfo["content"] ?? "";
      selectedCategoryIndex.value = _getCategoryIndex(postInfo["category"]);
      attachedImages.value = _convertImageList(postInfo["images"]);
      existingImageIds.value = (postInfo["images"] as List<dynamic>)
          .map((img) => img["id"] as int)
          .toList();
      isEditing.value = true;

      // 기존 데이터 저장 (비교용)
      originalTitle = titleController.text;
      originalContent = contentController.text;
      originalCategoryIndex = selectedCategoryIndex.value;
    }

    contentController.addListener(_updateFormStatus);
    titleController.addListener(_updateFormStatus);
    ever(selectedCategoryIndex, (_) => _updateFormStatus());
    ever(attachedImages, (_) => _updateFormStatus());
  }

  @override
  void onClose() {
    contentController.removeListener(_updateFormStatus);
    titleController.removeListener(_updateFormStatus);
    contentController.dispose();
    titleController.dispose();
    super.onClose();
  }

  /// 카테고리 문자열을 인덱스로 변환
  int _getCategoryIndex(String category) {
    switch (category) {
      case "FREE":
        return 0;
      case "QUESTION":
        return 1;
      case "BOOK_RECOMMENDATION":
        return 2;
      case "INFORMATION":
        return 3;
      default:
        return 0;
    }
  }

  /// 서버에서 받아온 이미지 리스트를 UI에 맞게 변환
  List<Map<String, dynamic>> _convertImageList(List<dynamic> imageList) {
    return imageList
        .map((image) =>
            {"file": image["url"], "imageId": image["id"], "isNetwork": true})
        .toList();
  }

  void _updateFormStatus() {
    contentLength.value = contentController.text.length;

    if (!isEditing.value) {
      // [게시물 등록 모드] 제목과 내용이 있어야 하고, 이미지 개수가 5개 이하일 때 버튼 활성화
      isUploadBtnEnabled.value = titleController.text.isNotEmpty &&
          (contentLength.value > 0 && contentLength.value <= 3500);
    } else {
      // [게시물 수정 모드] 기존 값과 비교하여 변경이 있을 때만 버튼 활성화
      bool isTitleChanged = titleController.text != originalTitle;
      bool isContentChanged = contentController.text != originalContent;
      bool isCategoryChanged =
          selectedCategoryIndex.value != originalCategoryIndex;

      // 기존 이미지 리스트와 비교하여 이미지 변경 여부 확인
      List<int> newImageIds = attachedImages
          .where((e) => !existingImageIds.contains(e['imageId']))
          .map((e) => e['imageId'] as int)
          .toList();
      bool isImageChanged = newImageIds.isNotEmpty ||
          existingImageIds.length != attachedImages.length;

      isUploadBtnEnabled.value = isTitleChanged ||
          isContentChanged ||
          isCategoryChanged ||
          isImageChanged;
    }
  }

  /// 카테고리 탭 선택
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  /// 사진 선택 (갤러리 또는 카메라)
  Future<void> pickImage(BuildContext context) async {
    if (attachedImages.length >= 5) {
      Get.snackbar('알림', '사진은 최대 5개까지 첨부할 수 있습니다.');
      return;
    }

    final XFile? image =
        await _imagePickerService.showImagePickerDialog(context);
    if (image != null) {
      File file = File(image.path);

      int? imageId = await RemoteDataSource.uploadImage(file);
      if (imageId != null) {
        attachedImages.add({'file': file, 'imageId': imageId});
      } else {
        Get.snackbar('이미지 업로드 실패', '이미지를 서버에 업로드하는 데 실패했습니다.');
      }
    }
  }

  /// 사진 삭제 (서버에서 삭제 요청)
  Future<void> confirmDeleteImage(int index, BuildContext context) async {
    OptionsDialog.showConfirmationDialog(
      context: context,
      content: '사진을 삭제하시겠어요?',
      isReport: false,
      onConfirm: () async {
        Navigator.of(context).pop();

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

  /// 게시물 등록 또는 수정
  Future<void> submitPost() async {
    if (!isUploadBtnEnabled.value) {
      Get.snackbar('알림', '게시물 제목과 내용을 입력해주세요.');
      return;
    }

    String selectedCategory = postCategories[selectedCategoryIndex.value];

    // 기존 이미지 제외하고 새로 추가된 이미지 ID만 추출
    List<int> newImageIds = attachedImages
        .where((e) => !existingImageIds.contains(e['imageId']))
        .map((e) => e['imageId'] as int)
        .toList();

    Map<String, dynamic> postData = {
      "title": titleController.text,
      "content": contentController.text,
      "type": selectedCategory,
      "newImageIds": newImageIds,
    };

    bool success;
    if (isEditing.value) {
      // 게시물 수정
      success = await RemoteDataSource.editPost(postId.value, postData);
    } else {
      // 게시물 등록
      success = await RemoteDataSource.createPost(
        title: postData["title"],
        content: postData["content"],
        type: postData["type"],
        imageIds: newImageIds,
      );
    }

    if (success) {
      Get.snackbar(isEditing.value ? '수정 성공' : '등록 성공',
          '게시물이 성공적으로 ${isEditing.value ? '수정' : '등록'}되었습니다.');

      // 입력 필드 초기화
      titleController.clear();
      contentController.clear();
      attachedImages.clear();
      existingImageIds.clear();

      Get.offNamed('/community');

      // if (isEditing.value) {
      //   // // 게시물 수정 모드 → 수정된 게시글 상세 페이지로 이동 (postId 전달)
      //   // Get.offNamed('/community/detail', arguments: postId.value);
      // } else {
      //   // 게시물 등록 모드 → 커뮤니티 메인 페이지로 이동
      //   Get.offNamed('/community');
      // }
    } else {
      Get.snackbar(isEditing.value ? '수정 실패' : '등록 실패',
          '게시물 ${isEditing.value ? '수정' : '등록'} 중 오류가 발생했습니다.');
    }
  }
}
