import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  // 갤러리에서 이미지 선택
  Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  // 카메라로 이미지 캡처
  Future<XFile?> pickImageFromCamera() async {
    return await _picker.pickImage(source: ImageSource.camera);
  }

  // 프로필 사진 선택 다이얼로그
  Future<XFile?> showImagePickerDialog(BuildContext context) async {
    return await showDialog<XFile?>(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 27),
            child: Column(
              mainAxisSize: MainAxisSize.min, // 다이얼로그 크기를 내용에 맞게 조정
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '프로필 사진',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    height: 1.30,
                    letterSpacing: -0.60,
                  ),
                ),
                const SizedBox(
                  height: 25.5,
                ),
                // 사진첩 버튼
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context, await pickImageFromGallery());
                  },
                  child: const Text(
                    '사진첩',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                // 카메라 버튼
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context, await pickImageFromCamera());
                  },
                  child: const Text(
                    '카메라',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      height: 1.30,
                      letterSpacing: -0.50,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
