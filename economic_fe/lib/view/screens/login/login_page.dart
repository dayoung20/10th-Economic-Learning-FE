import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/login/login_controller.dart';
import 'package:flutter/material.dart';
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
              ],
            ),
            const Text(
              '리플의 학습자가 되시면 \n더 자세한 단계와 해설을 확인할 수 있어요 ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF767676),
                fontSize: 16,
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
