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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 178,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: SizedBox(
              height: 78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '경제학습의 첫걸음,',
                    style: Palette.cardTitle,
                  ),
                  Row(
                    children: [
                      Text(
                        '나의 레벨은?',
                        style: Palette.cardTitle,
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Image.asset(
                        "assets/icon.png", width: 35.0, // 원하는 가로 크기
                        height: 35.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 44,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: Text(
              '학습 수준을 정확히 파악할 수 있도록 \n간단한 테스트를 준비했습니다. \n함께 시작해볼까요?',
              style: Palette.subleveltitle,
            ),
          ),
          const SizedBox(
            height: 175,
          ),
          Center(
            child: CustomButton(
              text: "레벨테스트 시작하기",
              onPress: () {
                controller.clickedTestMultiBtn(context);
              },
              bgColor: Palette.buttonColorBlue,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                controller.clickedAfterBtn(context);
              },
              child: SizedBox(
                child: Text(
                  '나중에 할래요',
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 18,
                    fontFamily: 'Pretendard Variable',
                    fontWeight: FontWeight.w600,
                    height: 1.20,
                    letterSpacing: -0.45,
                  ),
                ),
              ),
            ),
          )
          // CustomButton(
          //     text: "나중에 할게요",
          //     onPress: () {
          //       controller.clickedAfterBtn(context);
          //     },
          //     bgColor: Palette.background),
          // Stack(
          //   alignment: Alignment.center,
          //   children: [
          //     ElevatedButton(
          //       onPressed: () => {print("onpressed")},
          //       child: const Text('버튼'),
          //     ),
          //     if (true) // 조건부 렌더링은 children 내에서 이루어짐
          //       AbsorbPointer(
          //         absorbing: true,
          //         child: Container(
          //           color: Colors.transparent, // 버튼이 보이도록 투명 처리
          //           height: 48,
          //           width: 100,
          //         ),
          //       ),
          //   ],
          // ),
        ],
      ),
      // ElevatedButton(
      //         onPressed: () => {print("onpressed")},
      //         child: const Text('버튼'),
      //       ),
      //       if (_isDisabled)
      //         AbsorbPointer(
      //           absorbing: true,
      //           child: Container(
      //             color: Colors.transparent, // 버튼이 보이도록 투명 처리
      //             height: 48,
      //             width: 100,
      //           ),
      //         ),
    );
  }
}
