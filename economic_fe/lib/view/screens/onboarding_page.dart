import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view_model/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
    controller = Get.put(OnboardingController()..getStats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Image.asset("assets/icon.png"),
            Text(
              "Ripple",
              style: Palette.title,
            ),
            const Text("처음 시작하는 경제 학습"),
            const SizedBox(
              height: 260.5,
            ),
            CustomButton(
              text: "시작하기",
              onPress: () {
                final controller = Get.find<OnboardingController>();
                controller.clickedStartBtn(context);
              },
              bgColor: Palette.buttonColorBlue,
            ),
          ],
        ),
      ),
    );
  }
}
