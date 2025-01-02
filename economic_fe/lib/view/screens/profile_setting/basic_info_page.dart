import 'dart:io';

import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/profile_setting/basic_gender_button.dart';
import 'package:economic_fe/view/widgets/profile_setting/basic_label.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BasicInfoPage extends StatelessWidget {
  const BasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final BasicController controller = Get.put(BasicController());

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '기본 정보',
        onPress: () {
          controller.navigateToProfileSetting(context);
        },
        icon: Icons.close,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 10),
            ),
            // 프로필 사진 설정 부분
            SizedBox(
              height: ScreenUtils.getHeight(context, 88),
              child: Stack(
                children: [
                  Container(
                    width: ScreenUtils.getWidth(context, 88),
                    height: ScreenUtils.getHeight(context, 88),
                    decoration: ShapeDecoration(
                      color: const Color(0xFFF3F3F3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          ScreenUtils.getWidth(context, 43),
                        ),
                      ),
                    ),
                    child: Obx(() {
                      return controller.selectedProfileImage.value != null
                          ? ClipOval(
                              child: Image.file(
                                File(controller.selectedProfileImage.value!),
                                fit: BoxFit.cover,
                                width: ScreenUtils.getWidth(context, 88),
                                height: ScreenUtils.getHeight(context, 88),
                              ),
                            )
                          : Icon(
                              Icons.person,
                              size: ScreenUtils.getWidth(context, 43),
                            );
                    }),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    // 카메라 버튼
                    child: GestureDetector(
                      onTap: () {
                        controller.selectProfileImage(context);
                      },
                      child: Container(
                        width: ScreenUtils.getWidth(context, 26),
                        height: ScreenUtils.getHeight(context, 26),
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 4,
                              offset: Offset(0, 0),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.camera_alt_outlined,
                          size: ScreenUtils.getWidth(context, 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 18.8),
            ),
            const BasicLabel(
              label: '닉네임(필수)',
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 4),
            ),
            SizedBox(
              width: ScreenUtils.getWidth(context, 281),
              height: ScreenUtils.getHeight(context, 44),
              child: Obx(() {
                return TextField(
                  onChanged: controller.validateNickname, // 입력 값에 따라 유효성 검사
                  controller:
                      TextEditingController(text: controller.nickname.value),
                  decoration: InputDecoration(
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Container(
                        width: ScreenUtils.getWidth(context, 18),
                        height: ScreenUtils.getHeight(context, 18),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF3F3F3),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(43),
                          ),
                          shadows: const [
                            BoxShadow(
                              color: Color(0x3F000000),
                              blurRadius: 1,
                              offset: Offset(0.20, 0.20),
                              spreadRadius: 0,
                            )
                          ],
                        ),
                        child: Icon(
                          Icons.person,
                          size: ScreenUtils.getWidth(context, 15),
                        ),
                      ),
                    ),
                    suffixIcon: controller.isValid.value
                        ? const Icon(
                            Icons.check_circle_outline,
                            color: Color(0xff067BD5),
                          )
                        : controller.nickname.value.isEmpty
                            ? null
                            : const Icon(
                                Icons.error_outline,
                                color: Colors.red,
                              ),
                    labelStyle: Palette.pretendard(
                      context,
                      const Color(0xFFA2A2A2),
                      16,
                      FontWeight.w400,
                      1.5,
                      -0.4,
                    ),
                    labelText: '닉네임',
                  ),
                );
              }),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 4),
            ),
            Obx(() {
              return controller.isValid.value
                  ? const SizedBox() // 에러 메시지가 없을 때는 아무것도 표시하지 않음
                  : Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtils.getWidth(context, 8),
                      ),
                      child: SizedBox(
                        width: ScreenUtils.getWidth(context, 280),
                        child: Text(
                          controller.errorMessage.value,
                          style: Palette.pretendard(
                            context,
                            const Color(0xFFD50606),
                            12,
                            FontWeight.w400,
                            1.5,
                            -0.3,
                          ),
                        ),
                      ),
                    );
            }),
            SizedBox(
              height: ScreenUtils.getHeight(context, 10),
            ),
            // 성별 선택
            const BasicLabel(
              label: '성별',
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            SizedBox(
              width: ScreenUtils.getWidth(context, 280),
              height: ScreenUtils.getHeight(context, 44),
              child: Obx(() {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: ScreenUtils.getWidth(context, 125),
                      height: ScreenUtils.getHeight(context, 46),
                      padding: const EdgeInsets.all(4),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFA2A2A2)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => controller.selectGender('남'),
                            child: controller.selectedGender.value == '남'
                                ? const BasicGenderButton(
                                    isSelected: true,
                                    text: '남',
                                    textColor: Colors.black,
                                  )
                                : const BasicGenderButton(
                                    isSelected: false,
                                    text: '남',
                                    textColor: Color(0xFFA2A2A2),
                                  ),
                          ),
                          GestureDetector(
                            onTap: () => controller.selectGender('여'),
                            child: controller.selectedGender.value == '여'
                                ? const BasicGenderButton(
                                    isSelected: true,
                                    text: '여',
                                    textColor: Colors.black,
                                  )
                                : const BasicGenderButton(
                                    isSelected: false,
                                    text: '여',
                                    textColor: Color(0xFFA2A2A2),
                                  ),
                          ),
                        ],
                      ),
                    ),
                    // 생년월일 선택 위젯
                    SizedBox(
                      width: ScreenUtils.getWidth(context, 148),
                      height: ScreenUtils.getHeight(context, 44),
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () =>
                              controller.selectBirthday(context), // 날짜 선택
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 10),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 1, color: Color(0xFFA2A2A2)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              controller.selectedBirthday.value ??
                                  '생년월일', // 텍스트 표시
                              style: Palette.pretendard(
                                context,
                                controller.selectedBirthday.value == null
                                    ? const Color(0xFFA2A2A2)
                                    : Colors.black,
                                16,
                                FontWeight.w400,
                                1.6,
                                -0.4,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 18),
            ),
            // 한 줄 소개 입력칸
            const BasicLabel(
              label: '한 줄 소개',
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            Container(
              width: ScreenUtils.getWidth(context, 281),
              padding: EdgeInsets.all(
                ScreenUtils.getWidth(context, 12),
              ),
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      width: ScreenUtils.getWidth(context, 1),
                      color: const Color(0xFFA2A2A2)),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: SizedBox(
                width: ScreenUtils.getWidth(context, 257),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: ScreenUtils.getHeight(context, 10),
                          ),
                          child: const Icon(Icons.edit),
                        ),
                        SizedBox(
                          width: ScreenUtils.getWidth(context, 216),
                          child: Obx(() {
                            return TextField(
                              controller: TextEditingController(
                                  text: controller.userInput.value),
                              onChanged: controller.onTextChanged,
                              maxLines: 5,
                              inputFormatters: [
                                // 글자 수가 maxLength를 초과하지 않도록 제한
                                LengthLimitingTextInputFormatter(
                                    controller.maxLength),
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '한 줄 소개를 입력하세요.',
                                hintStyle: Palette.pretendard(
                                  context,
                                  const Color(0xFFA2A2A2),
                                  16,
                                  FontWeight.w400,
                                  1.5,
                                  -0.4,
                                ),
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: ScreenUtils.getWidth(context, 257),
                      child: Obx(() {
                        return Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${controller.currentLength.value}',
                                style: Palette.pretendard(
                                  context,
                                  controller.currentLength.value >=
                                          controller.maxLength
                                      ? const Color(0xFFD50606)
                                      : const Color(0xFF111111),
                                  12,
                                  FontWeight.w400,
                                  1.5,
                                  1.0,
                                ),
                              ),
                              TextSpan(
                                text: '/${controller.maxLength}',
                                style: Palette.pretendard(
                                  context,
                                  const Color(0xFFA2A2A2),
                                  12,
                                  FontWeight.w400,
                                  1.5,
                                  1.0,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.right,
                        );
                      }),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 75),
            ),
            // 저장하기 버튼 활성화
            Obx(() {
              bool isButtonEnabled = controller.isValid.value &&
                  controller.selectedBirthday.value != null;
              return isButtonEnabled
                  ? CustomButton(
                      text: '저장하기',
                      onPress: () {
                        controller.onSaveButtonClicked();
                        controller.navigateToProfileSetting(context);
                      },
                      bgColor: Palette.buttonColorBlue,
                    )
                  : CustomButtonUnfilled(
                      text: '저장하기',
                      onPress: () {
                        // 저장할 수 없으므로 아무 동작도 하지 않음
                      },
                    );
            }),
          ],
        ),
      ),
    );
  }
}
