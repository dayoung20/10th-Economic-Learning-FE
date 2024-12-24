import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 178,
            ),
            Text(
              '경제학습의 첫걸음,',
              style: Palette.cardTitle,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 90,
                ),
                Text(
                  '나의 레벨은?',
                  style: Palette.cardTitle,
                ),
                Image.asset(
                  "assets/icon.png", width: 35.0, // 원하는 가로 크기
                  height: 35.0,
                ),
              ],
            ),
            const SizedBox(
              height: 44,
            ),
            Text(
              '학습 수준을 정확히 파악할 수 있도록 \n간단한 테스트를 준비했습니다. \n함께 시작해볼까요?',
              style: Palette.subleveltitle,
            ),
            const SizedBox(
              height: 183,
            ),
            CustomButton(
              text: "레벨테스트 시작하기",
              onPress: () {},
              bgColor: Palette.buttonColorBlue,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
                text: "나중에 할게요", onPress: () {}, bgColor: Palette.background),
          ],
        ),
      ),
    );
  }
}
