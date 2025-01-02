import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/profile_setting/select_button_line.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PartSelectPage extends StatelessWidget {
  const PartSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final PartSelectController controller = Get.put(PartSelectController());

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '업종/직무',
        onPress: () {
          controller.navigateToProfileSetting(context);
        },
        icon: Icons.close,
      ),
      body: Column(
        children: [
          SizedBox(
            width: ScreenUtils.getWidth(context, 360),
            child: Padding(
              padding: EdgeInsets.only(
                left: ScreenUtils.getWidth(context, 16),
              ),
              child: Text(
                '직무',
                style: Palette.pretendard(
                  context,
                  const Color(0xff111111),
                  20,
                  FontWeight.w500,
                  1.5,
                  -0.5,
                ),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 17),
          ),
          // 직무 선택 부분
          SizedBox(
            height: ScreenUtils.getHeight(context, 500),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // 전문직
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: Text(
                      '[전문직]',
                      style: Palette.pretendard(
                        context,
                        const Color(0xFF767676),
                        16,
                        FontWeight.w500,
                        1.5,
                        -0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 8),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: const Column(
                      children: [
                        // 첫번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 0,
                          subject: 'part',
                          partType: 1,
                        ),
                        // 두번째 줄
                        SelectButtonLine(
                          indexNum: 3,
                          indexAddNum: 2,
                          subject: 'part',
                          partType: 1,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 3),
                  ),
                  // 기업/사무직
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: Text(
                      '[기업/사무직]',
                      style: Palette.pretendard(
                        context,
                        const Color(0xFF767676),
                        16,
                        FontWeight.w500,
                        1.5,
                        -0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 8),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: const Column(
                      children: [
                        // 첫번째 줄
                        SelectButtonLine(
                          indexNum: 3,
                          indexAddNum: 0,
                          subject: 'part',
                          partType: 2,
                        ),
                        // 두번째 줄
                        SelectButtonLine(
                          indexNum: 3,
                          indexAddNum: 3,
                          subject: 'part',
                          partType: 2,
                        ),
                        // 세번째 줄
                        SelectButtonLine(
                          indexNum: 1,
                          indexAddNum: 6,
                          subject: 'part',
                          partType: 2,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 14),
                  ),
                  // IT/기술직
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: Text(
                      '[IT/기술직]',
                      style: Palette.pretendard(
                        context,
                        const Color(0xFF767676),
                        16,
                        FontWeight.w500,
                        1.5,
                        -0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 8),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: const Column(
                      children: [
                        // 첫번째 줄
                        SelectButtonLine(
                          indexNum: 1,
                          indexAddNum: 0,
                          subject: 'part',
                          partType: 3,
                        ),
                        // 두번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 1,
                          subject: 'part',
                          partType: 3,
                        ),
                        // 세번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 3,
                          subject: 'part',
                          partType: 3,
                        ),
                        // 네번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 5,
                          subject: 'part',
                          partType: 3,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 15),
                  ),
                  // 서비스/창업
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: Text(
                      '[서비스/창업]',
                      style: Palette.pretendard(
                        context,
                        const Color(0xFF767676),
                        16,
                        FontWeight.w500,
                        1.5,
                        -0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 8),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: const Column(
                      children: [
                        // 첫번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 0,
                          subject: 'part',
                          partType: 4,
                        ),
                        // 두번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 2,
                          subject: 'part',
                          partType: 4,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 16),
                  ),
                  // 기타
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: Text(
                      '[기타]',
                      style: Palette.pretendard(
                        context,
                        const Color(0xFF767676),
                        16,
                        FontWeight.w500,
                        1.5,
                        -0.4,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtils.getHeight(context, 8),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 312),
                    child: const Column(
                      children: [
                        // 첫번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 0,
                          subject: 'part',
                          partType: 5,
                        ),
                        // 두번째 줄
                        SelectButtonLine(
                          indexNum: 2,
                          indexAddNum: 2,
                          subject: 'part',
                          partType: 5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 16),
          ),
          // 저장하기 버튼 활성화
          Obx(() {
            bool isButtonEnabled = controller.selectedPart.value != null;
            return isButtonEnabled
                ? Center(
                    child: CustomButton(
                      text: '저장하기',
                      onPress: () {
                        controller.onSaveButtonClicked();
                        controller.navigateToProfileSetting(
                            context); // 프로필 설정 화면으로 이동
                      },
                      bgColor: Palette.buttonColorBlue,
                    ),
                  )
                : Center(
                    child: CustomButtonUnfilled(
                      text: '저장하기',
                      onPress: () {
                        // 저장할 수 없으므로 아무 동작도 하지 않음
                      },
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
