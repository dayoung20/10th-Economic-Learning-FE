import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingCardPage extends StatefulWidget {
  const OnboardingCardPage({super.key});

  @override
  State<OnboardingCardPage> createState() => _OnboardingCardPageState();
}

class _OnboardingCardPageState extends State<OnboardingCardPage> {
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
          Text(
            "학습과 퀴즈로 누구나 함께",
            style: Palette.cardTitle,
          ),
          Text(
            "개념 학습과 퀴즈로 누구나 쉽게 경제 학습이 가능해요.",
            textAlign: TextAlign.center,
            style: Palette.cardSub,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            text: "시작하기",
            onPress: () {},
            bgColor: Palette.buttonColorBlue,
          ),
          const SizedBox(
            height: 12,
          ),
          CustomButton(
            text: "계정이 이미 있어요",
            onPress: () {},
            bgColor: Palette.buttonColorGreen,
          ),
        ],
      )),
    );
  }
}
