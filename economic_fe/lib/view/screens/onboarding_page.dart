import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
                onPress: () {},
                bgColor: Palette.buttonColorGreen),
          ],
        ),
      ),
    );
  }
}
