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
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BasicInfoPage extends StatelessWidget {
  const BasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BasicController controller = Get.put(BasicController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '기본 정보',
        onPress: () {
          Get.back();
        },
        icon: Icons.close,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  children: [
                    SizedBox(height: ScreenUtils.getHeight(context, 10.h)),
                    Expanded(
                      child: Column(
                        children: [
                          // 프로필 사진 설정 부분
                          SizedBox(height: 88.h),
                          const BasicLabel(label: '닉네임'),
                          SizedBox(height: ScreenUtils.getHeight(context, 4)),
                          SizedBox(
                            width: ScreenUtils.getWidth(context, 281.w),
                            height: ScreenUtils.getHeight(context, 44.h),
                            child: Obx(() {
                              return TextField(
                                onChanged: (value) {
                                  controller.nickname.value = value;
                                  controller.validateNickname(value);
                                },
                                controller: controller.nicknameController,
                                decoration: InputDecoration(
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Icon(Icons.person, size: 18.w),
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
                                ),
                              );
                            }),
                          ),
                          SizedBox(
                              height: ScreenUtils.getHeight(context, 10.h)),
                          const BasicLabel(label: '성별'),
                          SizedBox(height: ScreenUtils.getHeight(context, 8.h)),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () => controller.selectGender('MALE'),
                                  child: BasicGenderButton(
                                    text: '남',
                                    textColor:
                                        controller.selectedGender.value ==
                                                'MALE'
                                            ? Colors.black
                                            : const Color(0xffa2a2a2),
                                    isSelected:
                                        controller.selectedGender.value ==
                                            'MALE',
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                GestureDetector(
                                  onTap: () =>
                                      controller.selectGender('FEMALE'),
                                  child: BasicGenderButton(
                                    text: '여',
                                    textColor:
                                        controller.selectedGender.value ==
                                                'FEMALE'
                                            ? Colors.black
                                            : const Color(0xffa2a2a2),
                                    isSelected:
                                        controller.selectedGender.value ==
                                            'FEMALE',
                                  ),
                                ),
                              ],
                            );
                          }),
                          SizedBox(
                              height: ScreenUtils.getHeight(context, 10.h)),
                          const BasicLabel(label: '한 줄 소개'),
                          SizedBox(height: ScreenUtils.getHeight(context, 8.h)),
                          Container(
                            width: ScreenUtils.getWidth(context, 281.w),
                            padding: EdgeInsets.all(
                                ScreenUtils.getWidth(context, 12)),
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: ScreenUtils.getWidth(context, 1.w),
                                    color: const Color(0xFFA2A2A2)),
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: TextField(
                              controller: controller.userInputController,
                              onChanged: controller.onTextChanged,
                              maxLines: 5,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(
                                    controller.maxLength)
                              ],
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: '한 줄 소개를 입력하세요.',
                                hintStyle: Palette.pretendard(
                                  context,
                                  const Color(0xFFA2A2A2),
                                  16.sp,
                                  FontWeight.w400,
                                  1.5,
                                  -0.4,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(() {
                      return controller.isValid.value &&
                              controller.selectedBirthday.value != null
                          ? CustomButton(
                              text: '저장하기',
                              onPress: () => controller.onSaveButtonClicked(),
                              bgColor: Palette.buttonColorGreen,
                            )
                          : CustomButtonUnfilled(
                              text: '저장하기',
                              onPress: () {},
                            );
                    }),
                    SizedBox(height: ScreenUtils.getHeight(context, 20.h)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
