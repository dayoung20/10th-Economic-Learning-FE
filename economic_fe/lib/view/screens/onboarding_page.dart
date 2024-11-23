import 'package:economic_fe/view/theme/palette.dart';
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
          // mainAxisAlignment: MainAxisAlignment.center, // 세로 방향 중앙 정렬
          // crossAxisAlignment: CrossAxisAlignment.center, // 가로 방향 중앙 정렬
          children: [
            Image.asset("assets/icon.png"),
            Text(
              "Ripple",
              style: Palette.title,
            ),
            const Text("처음 시작하는 경제 학습"),
          ],
        ),
      ),
    );
  }
}
