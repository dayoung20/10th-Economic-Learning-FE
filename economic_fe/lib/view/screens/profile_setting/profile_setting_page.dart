import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_setting_button.dart';
import 'package:economic_fe/view_model/profile_setting/profile_setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final ProfileSettingController controller =
        Get.put(ProfileSettingController());

    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 49),
            ),
            Text(
              '프로필 설정',
              style: Palette.pretendard(
                context,
                const Color(0xFF111111),
                20,
                FontWeight.w500,
                1.3,
                -0.5,
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 37),
            ),
            // "기본 정보" 버튼 상태에 따라 디자인 변경
            Obx(() {
              return ProfileSettingButton(
                title: '기본 정보',
                onPress: () {
                  // 기본 정보 입력 페이지로 이동
                  controller.navigateToBasic(context);
                },
                isSelected: controller.saveButtonClicked.value,
                icon: const Icon(Icons.person), // 클릭 여부에 따라 버튼 스타일 변경
              );
            }),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
            const ProfileSettingButton(
              title: '업종',
              icon: Icon(Icons.business_center),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
            const ProfileSettingButton(
              title: '직무',
              icon: Icon(Icons.badge),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 241),
            ),
            CustomButtonUnfilled(
              text: '저장하기',
              onPress: () {},
            ),
          ],
        ),
      ),
    );
  }
}
