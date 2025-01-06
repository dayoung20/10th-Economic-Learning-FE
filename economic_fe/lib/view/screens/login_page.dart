import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 157.07),
            ),
            Image.asset(
              "assets/icon.png",
              width: ScreenUtils.getWidth(context, 65.34),
              height: ScreenUtils.getHeight(context, 77.87),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 32.07),
            ),
            Text(
              "리플의 학습자가 되시면\n더 자세한 단계와 해설을\n확인하실 수 있어요 :)",
              textAlign: TextAlign.center,
              style: Palette.pretendard(
                context,
                const Color(0xFF111111),
                20,
                FontWeight.w400,
                1.6,
                -0.5,
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 59),
            ),
            IconButton(
              onPressed: () {
                controller.clickedLoginBtn(context);
              },
              icon: Image(
                image: const AssetImage(
                  'assets/kakao_login_btn.png',
                ),
                width: ScreenUtils.getWidth(context, 300),
                height: ScreenUtils.getHeight(context, 45),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
