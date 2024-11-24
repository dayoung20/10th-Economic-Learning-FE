import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/kakao_login_btn.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 157.06),
            ),
            Image.asset(
              "assets/icon_2.png",
              width: ScreenUtils.getWidth(context, 65.34),
              height: ScreenUtils.getHeight(context, 77.87),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 32.07),
            ),
            Text(
              "리플의 학습자가 되시면\n더 자세한 단계와 해설을\n확인하실 수 있어요 :)",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: ScreenUtils.getWidth(context, 20),
                fontWeight: FontWeight.w400,
                letterSpacing: ScreenUtils.getWidth(context, -0.50),
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 59),
            ),
            GestureDetector(
              onTap: () {}, // 서버 요청
              child: const KakaoLoginBtn(),
            ),
          ],
        ),
      ),
    );
  }
}
