import 'package:flutter/material.dart';

class QuizCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final void Function()? onPress;
  final int option; // option : 0 -> 다중 선택, 1 -> ox 문제
  final String question;
  final List<String>? answerOptions;

  const QuizCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.onPress,
    required this.option,
    required this.question,
    this.answerOptions,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  int? selectedOption;
  final List<String>? oxOption = [" O", " X"];
  void selectOption(int index) {
    setState(() {
      selectedOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.screenWidth * 0.8665,
      height: widget.screenHeight * 0.8026,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffa2a2a2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Flexible(
            flex: 1,
            child: quizQuestion(
              widget.screenWidth,
              Icons.bookmark,
              'Q. 다음 중 복리 효과가 경제적\n결과로 나타날 수 있는\n상황으로 적절한 것은?',
            ),
          ),
          Flexible(
            flex: 1,
            child: QuizOptionsContainer(
                widget.screenWidth, widget.screenHeight, widget.option),
          ),
        ],
      ),
    );
  }

  Container quizQuestion(
      double screenWidth, IconData bookmark, String question) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xfff2f3f5),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        border: Border(
          bottom: BorderSide(
            color: Color(0xffa2a2a2),
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                bookmark,
                color: const Color(0xff067bd5),
                size: 30,
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              width: screenWidth * 0.6917,
              child: Text(
                question,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Pretendard',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container QuizOptionsContainer(
      double screenWidth, double screenHeight, int option) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      child: option == 0
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.option == 0
                  ? List.generate(
                      4,
                      (index) => GestureDetector(
                        onTap: () => selectOption(index + 1),
                        child: quizOptionCard(
                          screenWidth,
                          screenHeight,
                          selectedOption == index + 1
                              ? const Color(0xff1eb692)
                              : Colors.white,
                          selectedOption == index + 1
                              ? const Color(0xff1eb692)
                              : const Color(0xffd3d3d3),
                          index + 1,
                          widget.answerOptions![index],
                          widget.option,
                        ),
                      ),
                    )
                  : List.generate(
                      2,
                      (index) => GestureDetector(
                        onTap: () => selectOption(index + 1),
                        child: quizOptionCard(
                            screenWidth,
                            screenHeight,
                            selectedOption == index + 1
                                ? const Color(0xff1eb692)
                                : Colors.white,
                            selectedOption == index + 1
                                ? const Color(0xff1eb692)
                                : const Color(0xffd3d3d3),
                            index + 1,
                            oxOption![index],
                            widget.option),
                      ),
                    ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widget.option == 0
                  ? List.generate(
                      4,
                      (index) => GestureDetector(
                        onTap: () => selectOption(index + 1),
                        child: quizOptionCard(
                            screenWidth,
                            screenHeight,
                            selectedOption == index + 1
                                ? const Color(0xff1eb692)
                                : Colors.white,
                            selectedOption == index + 1
                                ? const Color(0xff1eb692)
                                : const Color(0xffd3d3d3),
                            index + 1,
                            widget.answerOptions![index],
                            widget.option),
                      ),
                    )
                  : List.generate(
                      2,
                      (index) => GestureDetector(
                        onTap: () => selectOption(index + 1),
                        child: quizOptionCard(
                          138,
                          138,
                          selectedOption == index + 1
                              ? const Color(0xff1eb692)
                              : Colors.white,
                          selectedOption == index + 1
                              ? const Color(0xff1eb692)
                              : const Color(0xffd3d3d3),
                          index + 1,
                          oxOption![index],
                          widget.option,
                        ),
                      ),
                    ),
            ),
    );
  }

  Container quizOptionCard(
    double screenWidth,
    double screenHeight,
    Color background,
    Color border,
    int number,
    String text,
    int option,
  ) {
    return Container(
      width: option == 0 ? screenWidth * 0.75 : 138,
      height: option == 0 ? screenHeight * 0.08 : 138,
      decoration: BoxDecoration(
        color: background,
        border: Border.all(
          color: border,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: option == 0
                ? Container(
                    width: screenWidth * 0.02,
                    height: screenHeight * 0.02,
                    decoration: BoxDecoration(
                      color: const Color(0xffe5e9ec),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Center(
                      child: Text(
                        number.toString(),
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: option == 0 ? 15 : 60,
              fontFamily: 'Pretandard',
              fontWeight: FontWeight.w500,
              height: 1.1,
              color: selectedOption == number ? Colors.white : Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
