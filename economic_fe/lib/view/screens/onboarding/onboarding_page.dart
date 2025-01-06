import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view_model/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final OnboardingController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnboardingController()
      ..getStats());
  }

  @override
  Widget build(BuildContext context) {
    // 화면이 로드된 후 3초 뒤에 자동으로 이동
    Future.delayed(Duration(seconds: 3), () {
      context.go('/onboarding'); // '/onboarding'으로 이동
    });

    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtils.getHeight(context, 154),
            ),
            // 어플 로고
            Image.asset(
              "assets/icon.png",
              width: ScreenUtils.getWidth(context, 65.34),
              height: ScreenUtils.getHeight(context, 77.87),
            ),
            Text(
              "Ripple",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 45,
                fontFamily: 'Palanquin',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.90,
              ),
            ),
            const Text(
              "처음 시작하는 경제 학습",
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.40,
                letterSpacing: -0.80,
              ),
            ),
            // const SizedBox(
            //   height: 260.5,
            // ),
            // CustomButton(
            //   text: "시작하기",
            //   onPress: () {
            //     final controller = Get.find<OnboardingController>();
            //     controller.clickedStartBtn(context);
            //   },
            //   bgColor: Palette.buttonColorBlue,
            // ),
          ],
        ),
      ),
    );
  }
}
