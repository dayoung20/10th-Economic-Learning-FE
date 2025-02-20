import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/login/login_exist_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class LoginExistPage extends StatefulWidget {
  const LoginExistPage({super.key});

  @override
  State<LoginExistPage> createState() => _LoginExistPageState();
}

class _LoginExistPageState extends State<LoginExistPage> {
  @override
  Widget build(BuildContext context) {
    final LoginExistController controller = Get.put(LoginExistController());

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
                SizedBox(
                  height: 10.h,
                ),
                Text(
                  '처음 시작하는 경제 학습',
                  style: TextStyle(
                    color: const Color(0xFF404040),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
              ],
            ),
            // 카카오 로그인 버튼
            Column(
              children: [
                IconButton(
                  onPressed: () {
                    controller.login();
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
