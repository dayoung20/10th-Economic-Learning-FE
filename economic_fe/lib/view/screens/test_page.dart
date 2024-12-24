import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view_model/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late final TestController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TestController()..getStats());
  }

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
              onPress: () {
                controller.clickedTestMultiBtn(context);
              },
              bgColor: Palette.buttonColorBlue,
            ),
            const SizedBox(
              height: 12,
            ),
            CustomButton(
                text: "나중에 할게요",
                onPress: () {
                  controller.clickedAfterBtn(context);
                },
                bgColor: Palette.background),
          ],
        ),
      ),
    );
  }
}
