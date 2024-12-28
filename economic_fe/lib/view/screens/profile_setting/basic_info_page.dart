import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/profile_setting/basic_label.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_selected.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_unselected.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_setting_app_bar.dart';
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

    // 연령대 리스트
    final List<String> ageRanges = [
      '10대',
      '20대',
      '30대',
      '40대',
      '50대',
      '60대',
      '70대',
      '80대'
    ];

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: ProfileSettingAppBar(
        title: '기본 정보',
        onPress: () {
          controller.navigateToProfileSetting(context);
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 28),
            ),
            const BasicLabel(
              label: '닉네임(필수)',
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
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
                    prefixIcon: const Icon(Icons.account_circle),
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
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFA2A2A2),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFFA2A2A2),
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    border: InputBorder.none,
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
              height: ScreenUtils.getHeight(context, 16),
            ),
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
                    GestureDetector(
                      onTap: () => controller.selectGender('남자'),
                      child: controller.selectedGender.value == '남자'
                          ? const ProfileButtonSelected(
                              text: '남자',
                              paddingWidth: 55,
                              paddingHeight: 8,
                              height: 40,
                              fontSize: 16,
                            )
                          : const ProfileButtonUnselected(
                              text: '남자',
                              paddingWidth: 55,
                              paddingHeight: 8,
                              height: 40,
                              fontSize: 16,
                            ),
                    ),
                    GestureDetector(
                      onTap: () => controller.selectGender('여자'),
                      child: controller.selectedGender.value == '여자'
                          ? const ProfileButtonSelected(
                              text: '여자',
                              paddingWidth: 55,
                              paddingHeight: 8,
                              height: 40,
                              fontSize: 16,
                            )
                          : const ProfileButtonUnselected(
                              text: '여자',
                              paddingWidth: 55,
                              paddingHeight: 8,
                              height: 40,
                              fontSize: 16,
                            ),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
            const BasicLabel(
              label: '연령대(필수)',
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            // 연령대 선택 버튼 두 줄로 배치
            SizedBox(
              width: ScreenUtils.getWidth(context, 281),
              child: Obx(() {
                return Column(
                  children: [
                    // 첫 번째 줄 (4개의 버튼)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        String ageRange = ageRanges[index];
                        return GestureDetector(
                          onTap: () => controller.selectAgeRange(ageRange),
                          child: controller.selectedAgeRange.value == ageRange
                              ? ProfileButtonSelected(
                                  text: ageRange,
                                  paddingWidth: 20,
                                  paddingHeight: 8,
                                  height: 44,
                                  fontSize: 14,
                                )
                              : ProfileButtonUnselected(
                                  text: ageRange,
                                  paddingWidth: 20,
                                  paddingHeight: 8,
                                  height: 44,
                                  fontSize: 14,
                                ),
                        );
                      }),
                    ),
                    SizedBox(height: ScreenUtils.getHeight(context, 12)),
                    // 두 번째 줄 (4개의 버튼)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(4, (index) {
                        String ageRange = ageRanges[index + 4]; // 나머지 4개 버튼
                        return GestureDetector(
                          onTap: () => controller.selectAgeRange(ageRange),
                          child: controller.selectedAgeRange.value == ageRange
                              ? ProfileButtonSelected(
                                  text: ageRange,
                                  paddingWidth: 20,
                                  paddingHeight: 8,
                                  height: 44,
                                  fontSize: 14,
                                )
                              : ProfileButtonUnselected(
                                  text: ageRange,
                                  paddingWidth: 20,
                                  paddingHeight: 12,
                                  height: 44,
                                  fontSize: 14,
                                ),
                        );
                      }),
                    ),
                  ],
                );
              }),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
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
              height: ScreenUtils.getHeight(context, 14),
            ),
            // 저장하기 버튼 활성화
            Obx(() {
              bool isButtonEnabled = controller.isValid.value &&
                  controller.selectedAgeRange.value != null;
              return isButtonEnabled
                  ? CustomButton(
                      text: '저장하기',
                      onPress: () {
                        controller.onSaveButtonClicked();
                        controller.navigateToProfileSetting(
                            context); // 프로필 설정 화면으로 이동
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
