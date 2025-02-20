import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
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
      appBar: CustomAppBar(
        title: '프로필 설정',
        icon: Icons.arrow_back_ios_new,
        onPress: () {
          controller.goBack();
        },
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 37),
            ),
            // "기본 정보" 저장 상태에 따라 디자인 변경
            Obx(() {
              return ProfileSettingButton(
                title: '기본 정보',
                onPress: () {
                  Get.toNamed('/profile_setting/basic');
                },
                isSelected: controller.basicSaveButtonClicked.value,
                icon: const Icon(Icons.person),
              );
            }),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
            // "업종" 저장 상태에 따라 디자인 변경
            Obx(() {
              return ProfileSettingButton(
                title: '업종',
                onPress: () {
                  Get.toNamed('/profile_setting/job');
                },
                isSelected: controller.jobSaveButtonClicked.value,
                icon: const Icon(Icons.business_center),
              );
            }),
            SizedBox(
              height: ScreenUtils.getHeight(context, 16),
            ),
            // "직무" 저장 상태에 따라 디자인 변경
            Obx(() {
              return ProfileSettingButton(
                title: '직무',
                onPress: () {
                  Get.toNamed('/profile_setting/part');
                },
                isSelected: controller.partSaveButtonClicked.value,
                icon: const Icon(Icons.badge),
              );
            }),
            SizedBox(
              height: ScreenUtils.getHeight(context, 241),
            ),
            // 저장하기 버튼 활성화
            Obx(() {
              return controller.isInfoCompleted.value
                  ? Center(
                      child: CustomButton(
                        text: '저장하기',
                        onPress: () async {
                          await controller.saveUserProfile();
                        },
                        bgColor: Palette.buttonColorBlue,
                      ),
                    )
                  : Center(
                      child: CustomButtonUnfilled(
                        text: '저장하기',
                        onPress: () {},
                      ),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
