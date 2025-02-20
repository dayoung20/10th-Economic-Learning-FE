import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_snack_bar.dart';
import 'package:economic_fe/view_model/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/text_utils.dart';

class QuizCard extends StatefulWidget {
  final double screenWidth;
  final double screenHeight;
  final void Function()? onPress;
  final int option; // option : 0 -> 다중 선택, 1 -> ox 문제
  final String question;
  final List<String>? answerOptions;
  final bool isQuiz;
  final bool isLast;
  final int? answer;
  final Function()? onFinishTest;
  final bool? isCorrectQuiz;
  final int? quizId;

  // 선택한 옵션 부모로 전달
  final Function(int)? onOptionSelected;

  // 퀴즈에서 다음 문제로 넘어갈 때 실행되는 함수
  final Function()? onNextQuizBtn;

  const QuizCard({
    super.key,
    required this.screenHeight,
    required this.screenWidth,
    required this.onPress,
    required this.option,
    required this.question,
    this.answerOptions,
    required this.isQuiz,
    required this.isLast,
    this.answer,
    this.onOptionSelected,
    this.onFinishTest,
    this.isCorrectQuiz,
    this.onNextQuizBtn,
    this.quizId,
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  late final QuizController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(QuizController()..getStats());
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: widget.screenHeight * 0.7,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      // 질문 부분
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.only(
                          top: 28,
                          left: 40,
                          right: 40,
                          bottom: 24,
                        ),
                        decoration: const ShapeDecoration(
                          color: Color(0xFFF2F3F5),
                          shape: RoundedRectangleBorder(
                            side:
                                BorderSide(width: 1, color: Color(0xFFA2A2A2)),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - (32 + 80),
                          child: Text(
                            addZeroWidthJoiner(
                                widget.question), // 유틸리티 함수 호출 (한글 단어 단위 줄바꿈)
                            style: const TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 18,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w500,
                              height: 1.70,
                              letterSpacing: -0.50,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 32,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 24),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          border: Border(
                            left:
                                BorderSide(color: Color(0xFFA2A2A2), width: 1),
                            right:
                                BorderSide(color: Color(0xFFA2A2A2), width: 1),
                            bottom: BorderSide(
                              color: Color(0xFFA2A2A2),
                              width: 1,
                            ),
                          ),
                        ),
                        child: widget.option == 0
                            ?
                            // 다중 선택 문제인 경우
                            Column(
                                children: List.generate(4, (index) {
                                  return Obx(() {
                                    return controller.clickCheckBtn.value
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 8,
                                              horizontal: 16,
                                            ),
                                            child: MultipleOptionContainer(
                                                widget: widget,
                                                optionNum: index + 1,
                                                isSelected: controller
                                                        .selectedOption.value ==
                                                    index,
                                                isQuiz: true,
                                                isCorrect:
                                                    controller.isCorrect.value),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              controller.selectOption(index);
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8,
                                                horizontal: 16,
                                              ),
                                              child: MultipleOptionContainer(
                                                widget: widget,
                                                optionNum: index + 1,
                                                isSelected: controller
                                                        .selectedOption.value ==
                                                    index,
                                                isQuiz: false,
                                              ),
                                            ),
                                          );
                                  });
                                }),
                              )
                            :
                            // OX 문제인 경우
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(2, (index) {
                                  return Obx(() {
                                    return controller.clickCheckBtn.value
                                        ? OXOptionContainer(
                                            option: index == 0 ? 'O' : 'X',
                                            isSelected: controller
                                                    .selectedOption.value ==
                                                index,
                                            isQuiz: true,
                                            isCorrect:
                                                controller.isCorrect.value,
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              controller.selectOption(
                                                  index); // 선택된 옵션 저장
                                            },
                                            child: OXOptionContainer(
                                              option: index == 0 ? 'O' : 'X',
                                              isSelected: controller
                                                      .selectedOption.value ==
                                                  index,
                                              isQuiz: false,
                                            ),
                                          );
                                  });
                                }),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(() {
                return CustomButton(
                  text: widget.isQuiz
                      ? '확인'
                      : widget.isLast
                          ? widget.isQuiz
                              ? "종료하기"
                              : '레벨테스트 종료'
                          : '다음 문제',
                  onPress: controller.isNextButtonEnabled
                      ? widget.isQuiz
                          ? () {
                              // 퀴즈에서 다음 문제 버튼 클릭 시 함수
                              controller.clickCheckBtn.value = true;
                              controller.isCorrectAnswer.value =
                                  controller.isCorrect.value ? 1 : 2;

                              // 답안 제출
                              controller.postSubmitQuiz(widget.quizId!,
                                  controller.selectedOption.value);
                              print("se : ${controller.selectedOption.value}");
                            }
                          : widget.isLast
                              ? () {
                                  widget.onFinishTest!();
                                }
                              : () {
                                  // "다음 문제" 버튼 활성화
                                  // 다음 문제로 넘어가는 로직 추가
                                  print("다음문제");
                                  widget.onOptionSelected != null
                                      ? widget.onOptionSelected!(
                                          controller.selectedOption.value)
                                      : null;
                                  //새로 추가됨
                                  controller.selectedOption.value = -1;
                                }
                      : null,
                  bgColor: controller.isNextButtonEnabled
                      ? Palette.buttonColorGreen
                      : const Color(0xFFD6D6D6),
                  textColor: controller.isNextButtonEnabled
                      ? Colors.white
                      : const Color(0xFFA2A2A2),
                );
              }),
            ],
          ),
        ),
        // 정답 여부 표시하는 부분
        Obx(() {
          return Positioned(
            bottom: 0,
            child: controller.clickCheckBtn.value
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 183,
                    decoration: controller.isCorrect.value
                        ? const BoxDecoration(color: Color(0xFFE1F6FF))
                        : const BoxDecoration(color: Color(0xFFFFF2F1)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    controller.isCorrect.value
                                        ? 'assets/check_circle.png'
                                        : 'assets/subtract.png',
                                    width: 32,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    controller.isCorrect.value
                                        ? '맞았어요!'
                                        : '아쉬워요',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 24,
                                      fontFamily: 'Pretendard Variable',
                                      fontWeight: FontWeight.w500,
                                      height: 1.40,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.viewDescription.value = true;
                                    },
                                    child: Container(
                                      width: 88,
                                      height: 40,
                                      decoration: ShapeDecoration(
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 1,
                                              color: Color(0xFFA2A2A2)),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          '해설보기',
                                          style: TextStyle(
                                            color: Color(0xFF111111),
                                            fontSize: 14,
                                            fontFamily: 'Pretendard Variable',
                                            fontWeight: FontWeight.w400,
                                            height: 1.14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: GestureDetector(
                                      onTap: () {
                                        controller.isBookmarked.value =
                                            !controller.isBookmarked.value;
                                        CustomSnackBar.show(
                                            context: context,
                                            message:
                                                controller.isBookmarked.value
                                                    ? '퀴즈를 스크랩했어요'
                                                    : '스크랩을 취소했어요');

                                        if (controller.isBookmarked.value) {
                                          controller
                                              .postScrapQuiz(widget.quizId!);
                                        } else {
                                          controller.postScrapDeleteQuiz(
                                              widget.quizId!);
                                        }
                                      },
                                      child: Obx(() {
                                        return Image.asset(
                                          controller.isBookmarked.value
                                              ? 'assets/bookmark_selected.png'
                                              : 'assets/bookmark.png',
                                          width: 15,
                                          height: 21,
                                        );
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: widget.isLast ? '종료하기' : '다음 문제',
                          onPress: () {
                            if (widget.isLast) {
                              widget.onFinishTest!();
                            } else {
                              print("next ::");
                              widget.onNextQuizBtn!();
                              controller.clickCheckBtn.value = false;
                              controller.selectedOption.value = -1;
                              controller.isBookmarked.value = false;
                            }
                          },
                          bgColor: controller.isCorrect.value
                              ? const Color(0xff067BD5)
                              : const Color(0xffFF5468),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          );
        }),
        // 해설 창 띄울 시 화면 어둡게
        Obx(() {
          return Positioned(
            child: controller.viewDescription.value
                ? Container(
                    width: widget.screenWidth,
                    height: widget.screenHeight,
                    color: Colors.black.withOpacity(0.5), // 어두운 배경 추가
                  )
                : const SizedBox(),
          );
        }),
        // 해설 창
        Obx(() {
          return Positioned(
            bottom: 0,
            child: controller.viewDescription.value
                ? Container(
                    width: widget.screenWidth,
                    height: 552,
                    padding: const EdgeInsets.all(24),
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFA2A2A2)),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '해설',
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 18,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w600,
                                height: 1.20,
                                letterSpacing: -0.45,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                controller.viewDescription.value = false;
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          child: SizedBox(
                            height: 384,
                            child: Text(
                              controller.explanation.value,
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontFamily: 'Pretendard Variable',
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          );
        }),
      ],
    );
  }
}

// OX 문제 선택지 박스
class OXOptionContainer extends StatelessWidget {
  final String option;
  final bool isSelected;
  final bool isQuiz;
  final bool? isCorrect;

  const OXOptionContainer({
    super.key,
    required this.option,
    required this.isSelected,
    required this.isQuiz,
    this.isCorrect,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (MediaQuery.of(context).size.width - 80) / 2,
      height: (MediaQuery.of(context).size.width - 80) / 2,
      decoration: isSelected
          ? isQuiz
              ? ShapeDecoration(
                  color: isCorrect!
                      ? const Color(0xFFE1F6FF)
                      : const Color(0xFFFFF2F1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 3,
                        color: isCorrect!
                            ? const Color(0xFF067BD5)
                            : const Color(0xFFFF5468)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              : ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(width: 3, color: Color(0xFF1DB691)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
          : ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
      child: Center(
        child: Text(
          option,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 90,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w500,
            height: 0.18,
          ),
        ),
      ),
    );
  }
}

// 다중 선택 문제 선택지 박스
class MultipleOptionContainer extends StatelessWidget {
  final int optionNum;
  final bool isSelected;
  final bool isQuiz;
  final bool? isCorrect;

  const MultipleOptionContainer({
    super.key,
    required this.widget,
    required this.optionNum,
    required this.isSelected,
    required this.isQuiz,
    this.isCorrect,
  });

  final QuizCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - (64 + 32),
      padding: const EdgeInsets.all(16),
      decoration: isSelected
          ? isQuiz
              ? ShapeDecoration(
                  color: isCorrect!
                      ? const Color(0xFFE1F6FF)
                      : const Color(0xFFFFF2F1),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        width: 3,
                        color: isCorrect!
                            ? const Color(0xFF067BD5)
                            : const Color(0xFFFF5468)),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
              : ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      width: 3,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFF1DB691),
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                )
          : ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(12),
              ),
            ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: ShapeDecoration(
              color: isSelected
                  ? isQuiz
                      ? isCorrect!
                          ? const Color(0xFF067BD5)
                          : const Color(0xFFFF5468)
                      : const Color(0xFFF2F3F5)
                  : const Color(0xFFF2F3F5),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4)),
            ),
            child: Center(
              child: Text(
                '$optionNum',
                style: TextStyle(
                  color: isSelected
                      ? isQuiz
                          ? Colors.white
                          : const Color(0xFF111111)
                      : const Color(0xFF111111),
                  fontSize: 14,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Expanded(
            child: Text(
              addZeroWidthJoiner(widget.answerOptions![optionNum - 1]),
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 18,
                fontWeight: FontWeight.w500,
                height: 1.40,
                letterSpacing: -0.45,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
