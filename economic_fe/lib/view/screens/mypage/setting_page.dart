import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/mypage/category_options.dart';
import 'package:economic_fe/view/widgets/mypage/category_text.dart';
import 'package:economic_fe/view_model/mypage/setting_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({super.key});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final SettingController controller = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '설정 및 약관',
        icon: Icons.arrow_back_ios_new,
        onPress: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryText(text: '알림'),
            Obx(() {
              return CategoryOptions(
                text: '전체 알림',
                onTap: controller.isLoading.value
                    ? () {} // 로딩 중일 때 빈 함수
                    : () {
                        controller.toggle();
                      },
                isToggle: true,
                isToggleOn: controller.isToggled.value,
              );
            }),
            SizedBox(
              height: 36.h,
            ),
            const CategoryText(text: '약관 및 정보'),
            CategoryOptions(
              text: '이용약관',
              onTap: () {
                Get.toNamed('/login/agreement/detail');
              },
            ),
            CategoryOptions(
              text: '버전 정보',
              isText: true,
              onTap: () {},
            ),
            SizedBox(
              height: 28.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  '회원탈퇴',
                  style: TextStyle(
                    color: const Color(0xFF767676),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
