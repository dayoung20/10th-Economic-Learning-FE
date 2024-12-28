import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TestOxPage extends StatefulWidget {
  const TestOxPage({super.key});

  @override
  State<TestOxPage> createState() => _TestMultipleChoicePageState();
}

class _TestMultipleChoicePageState extends State<TestOxPage> {
  int? selectedOption;
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
                        "레벨테스트",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Text(
                        "1/9",
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
      body: Align(
        alignment: Alignment.topCenter,
        child: QuizCard(
          screenHeight: screenHeight,
          screenWidth: screenWidth,
          onPress: () {},
          option: 1,
          question: question,
          // answerOptions: options,
        ),
      ),
    );
  }
}
