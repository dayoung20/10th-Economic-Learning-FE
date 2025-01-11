import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/login/login_exist_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginExistPage extends StatelessWidget {
  const LoginExistPage({super.key});

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
                const SizedBox(
                  height: 164,
                ),
                // 어플 로고
                Image.asset(
                  "assets/icon.png",
                  width: 65.34,
                  height: 77.87,
                ),
                const Text(
                  "Ripple",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 45,
                    fontFamily: 'Palanquin',
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.90,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "처음 시작하는 경제 학습",
                  style: TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 16,
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
                    'assets/kakao_login_exist_btn.png',
                    width: 300,
                    height: 45,
                  ),
                ),
                const SizedBox(
                  height: 267,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
