import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                SizedBox(
                  height: 164.h,
                ),
                // 어플 로고
                Image.asset(
                  "assets/icon.png",
                  width: 65.34.w,
                  height: 77.87.h,
                ),
                Text(
                  "Ripple",
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 45.sp,
                    fontFamily: 'Palanquin',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.90,
                  ),
                ),
              ],
            ),
            Text(
              '리플의 학습자가 되시면 \n더 자세한 단계와 해설을 확인할 수 있어요 ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF767676),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                height: 1.60,
                letterSpacing: -0.40,
              ),
            ),
            // 카카오 로그인 버튼
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    // controller.clickedLoginBtn();
                    controller.login();
                    // print("로그인 페이지 : $answers");
                  },
                  icon: Image.asset(
                    'assets/kakao_login_btn.png',
                    width: 300.w,
                    height: 45.h,
                  ),
                ),
                SizedBox(
                  height: 267.h,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
