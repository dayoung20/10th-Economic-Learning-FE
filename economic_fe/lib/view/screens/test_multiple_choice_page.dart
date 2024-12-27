import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TestMultipleChoicePage extends StatefulWidget {
  const TestMultipleChoicePage({super.key});

  @override
  State<TestMultipleChoicePage> createState() => _TestMultipleChoicePageState();
}

class _TestMultipleChoicePageState extends State<TestMultipleChoicePage> {
  int? selectedOption;
  // final QuizController quizController = Get.find<QuizController>();

  final question = 'Q. 다음 중 복리 효과가 경제적\n결과로 나타날 수 있는\n상황으로 적절한 것은?';
  final List<String> options = [
    '단기간 대출을 받은 경우',
    '장기간 투자한 예금 계좌의\n이자가 점점 커지는 경우',
    '정기적으로 단리로 계산된\n이자만 지급되는 경우',
    '원금만 같아도 되는 상황'
  ];

  void selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(),
        title: Text(
          '레벨테스트',
          style: Palette.appTitle,
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: QuizCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                onPress: () {},
                option: 0,
                question: question,
                answerOptions: options),
          ),
          // CustomButton(
          //   text: "다음 문제",
          //   onPress: () {},
          //   bgColor: const Color.fromARGB(255, 186, 209, 255),
          // ),
          // ElevatedButton(
          //   onPressed: () {},
          //   child: const Text("다음 문제"),
          // ),
          // Center(
          //   child: Obx(() => Text(
          //         'Selected Option: ${quizController.selectedOption.value}',
          //         style: const TextStyle(fontSize: 24),
          //       )),
          // )
        ],
      ),
    );
  }
}
