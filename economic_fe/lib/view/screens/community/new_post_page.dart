import 'dart:io';

import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/category_tab.dart';
import 'package:economic_fe/view_model/community/new_post_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class NewPostPage extends StatelessWidget {
  const NewPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    final NewPostController controller = Get.put(NewPostController());

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        forceMaterialTransparency: true,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close),
        ),
        title: const Text(
          '일반 게시판',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.30,
            letterSpacing: -0.50,
          ),
        ),
        centerTitle: true,
        actions: [
          Obx(() {
            return Padding(
              padding: const EdgeInsets.only(right: 16),
              // 등록 버튼
              child: GestureDetector(
                onTap: controller.isUploadBtnEnabled.value
                    ? controller.toDetailPage // 게시물 등록 api 연결 로직 필요
                    : null,
                child: Text(
                  '등록',
                  style: TextStyle(
                    color: controller.isUploadBtnEnabled.value
                        ? const Color(0xFF111111)
                        : const Color(0xFFD9D9D9),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.50,
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      body: Column(
        children: [
          Obx(() {
            return SizedBox(
              height: 53,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(0);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 0,
                        text: '전체',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(1);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 1,
                        text: '자유',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(2);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 2,
                        text: '질문',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(3);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 3,
                        text: '책추천',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(4);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 4,
                        text: '정보 공유',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          // 제목 입력칸
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: TextField(
              controller: controller.titleController,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: '제목을 입력해주세요.',
                hintStyle: TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.30,
                  letterSpacing: -0.45,
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 32,
            height: 1,
            color: const Color(0xffd9d9d9),
          ),
          // 내용 입력칸
          Expanded(
            child: Obx(() {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextField(
                        controller: controller.contentController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: '경제 어쩌고에 대한 간단한 의견을 남겨주세요.',
                          hintStyle: TextStyle(
                            color: Color(0xFFA2A2A2),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                            letterSpacing: -0.40,
                          ),
                        ),
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      // 첨부된 사진 표시
                      if (controller.attachedImages.isNotEmpty)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 12),
                            child: controller.attachedImages.length == 1
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width - 52,
                                    height:
                                        MediaQuery.of(context).size.width - 52,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: FileImage(
                                          File(controller
                                              .attachedImages[0].path),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Color(0xFFD9D9D9)),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: MediaQuery.of(context).size.width *
                                        0.45,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount:
                                          controller.attachedImages.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.45,
                                            decoration: ShapeDecoration(
                                              image: DecorationImage(
                                                image: FileImage(
                                                  File(controller
                                                      .attachedImages[index]
                                                      .path),
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(
                                                    width: 1,
                                                    color: Color(0xFFD9D9D9)),
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1,
              color: Color(0xFFD9D9D9),
            ),
          ),
        ),
        child: Padding(
          padding: MediaQuery.of(context).viewInsets.bottom > 0
              ? EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 16,
                  right: 16,
                  top: 10,
                )
              : const EdgeInsets.only(bottom: 34, left: 16, right: 16, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 사진 추가 버튼
              GestureDetector(
                onTap: () async {
                  // 이미지 선택 다이얼로그
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Wrap(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.camera),
                            title: const Text('카메라'),
                            onTap: () {
                              Navigator.of(context).pop();
                              controller.pickImage(ImageSource.camera);
                            },
                          ),
                          ListTile(
                            leading: const Icon(Icons.photo),
                            title: const Text('갤러리'),
                            onTap: () {
                              Navigator.of(context).pop();
                              controller.pickImage(ImageSource.gallery);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Image.asset(
                  'assets/add_photo.png',
                  width: 24,
                  height: 24,
                ),
              ),
              // 글자수 제한
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Obx(() {
                      final contentLength = controller.contentLength.value;
                      final isOverLimit = contentLength > 3500;
                      return Text(
                        '$contentLength',
                        style: TextStyle(
                          color: isOverLimit
                              ? Colors.red
                              : const Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      );
                    }),
                    const Text(
                      '/3500',
                      style: TextStyle(
                        color: Color(0xFF767676),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
