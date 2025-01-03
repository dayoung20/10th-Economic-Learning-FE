import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final question = 'Q. 다음 중 복리 효과가 경제적\n결과로 나타날 수 있는\n상황으로 적절한 것은?';
  // int answer =
  final List<String> options = [
    '단기간 대출을 받은 경우',
    '장기간 투자한 예금 계좌의\n이자가 점점 커지는 경우',
    '정기적으로 단리로 계산된\n이자만 지급되는 경우',
    '원금만 같아도 되는 상황'
  ];
  @override
  Widget build(BuildContext context) {
    int? selectedOption;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
          elevation: 0,
          backgroundColor: Colors.white, // AppBar 배경색
          flexibleSpace: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 상단 앱바
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const Text(
                        "고급퀴즈",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "1/3",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                // 진행 바
                const LinearProgressIndicator(
                  value: 0.1, // 진행 퍼센트 (0.0 ~ 1.0)
                  backgroundColor: Color(0xffe0e0e0),
                  color: Color(0xff1eb692), // 진행 바 색상
                ),
              ],
            ),
          ),
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
              answerOptions: options,
              isLast: false,
              isQuiz: true,
              answer: 2,
            ),
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
