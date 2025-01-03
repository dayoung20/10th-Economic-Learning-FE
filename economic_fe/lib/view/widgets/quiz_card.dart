import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/next_button.dart';

// import 'package:economic_fe/view/widgets/next_button.dart';
import 'package:economic_fe/view_model/quiz_controller.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  });

  @override
  State<QuizCard> createState() => _QuizCardState();
}

class _QuizCardState extends State<QuizCard> {
  // int? selectedOption;
  late final QuizController controller;
  //final List<String>? oxOption = [" O", " X"];

  @override
  void initState() {
    super.initState();
    controller = Get.put(QuizController()..getStats());
    // controller.isCorrectAnswer = 0;
    // controller.clickCheckBtn = false;
  }

  // void selectOption(int index) {
  //   setState(() {
  //     // selectedOption = index;
  //     controller.selectedNumber.value = index;
  //     print('선택된 번호 : ${controller.selectedNumber.value}');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // return Column(
    //   children: [
    //     Container(
    //       width: 328,
    //       height: widget.option == 0
    //           ? ScreenUtils.getHeight(context, 570)
    //           : ScreenUtils.getHeight(context, 370),
    //       decoration: BoxDecoration(
    //         border: Border.all(color: const Color(0xffa2a2a2)),
    //         borderRadius: BorderRadius.circular(10),
    //       ),
    //       child: Column(
    //         children: [
    //           Flexible(
    //             flex: widget.option == 0 ? 4 : 1,
    //             child: quizQuestion(
    //               widget.screenWidth,
    //               Icons.bookmark,
    //               'Q. 다음 중 복리 효과가 경제적\n결과로 나타날 수 있는\n상황으로 적절한 것은?',
    //             ),
    //           ),
    //           Flexible(
    //             flex: widget.option == 0 ? 7 : 1,
    //             child: Center(
    //               child: QuizOptionsContainer(
    //                   widget.screenWidth, widget.screenHeight, widget.option),
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //     const SizedBox(
    //       height: 5,
    //     ),
    //     Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Obx(() => NextButton(
    //               // text: widget.isLast && widget.isQuiz ? "확인" : "다음 문제",
    //               text: widget.isQuiz
    //                   ? "확인"
    //                   : widget.isLast
    //                       ? "레벨테스트 종료"
    //                       : "다음 문제",
    //               isEnabled: controller.selectedNumber.value != -1, // 활성화 상태 전달
    //               onPressed: () {
    //                 widget.isQuiz && controller.isCorrectAnswer == 1
    //                     ? showModalBottomSheet(
    //                         backgroundColor: const Color(0xFFE1F6FF),
    //                         context: context,
    //                         shape: const RoundedRectangleBorder(
    //                             // borderRadius: BorderRadius.vertical(
    //                             //     top: Radius.circular(20)),
    //                             ),
    //                         builder: (context) {
    //                           return Container(
    //                             padding: const EdgeInsets.all(20),
    //                             height: 183,
    //                             width: 362,
    //                             child: Column(
    //                               crossAxisAlignment: CrossAxisAlignment.start,
    //                               children: [
    //                                 Row(
    //                                   children: [
    //                                     SvgPicture.asset(
    //                                       'assets/check_circle.svg', // SVG 파일 경로
    //                                       height: 32, // 높이
    //                                       width: 32, // 너비
    //                                       color: const Color(
    //                                           0xFF067BD5), // 색상 변경 (선택 사항)
    //                                     ),
    //                                     const SizedBox(
    //                                       width: 11.3,
    //                                     ),
    //                                     const Text(
    //                                       '맞았어요!',
    //                                       style: TextStyle(
    //                                         fontSize: 24,
    //                                         fontWeight: FontWeight.w500,
    //                                         height: 1.4,
    //                                       ),
    //                                     ),
    //                                     const SizedBox(
    //                                       width: 42,
    //                                     ),
    //                                     ElevatedButton(
    //                                       onPressed: () {},
    //                                       style: ElevatedButton.styleFrom(
    //                                         backgroundColor:
    //                                             Colors.white, // 배경 색상
    //                                         foregroundColor:
    //                                             Colors.black, // 글자 색상
    //                                         padding: const EdgeInsets.symmetric(
    //                                             horizontal: 20,
    //                                             vertical: 15), // 내부 패딩
    //                                         shape: RoundedRectangleBorder(
    //                                           borderRadius:
    //                                               BorderRadius.circular(
    //                                                   10), // 모서리 둥글기
    //                                           side: const BorderSide(
    //                                             color: Colors.black, // 테두리 색상
    //                                             width: 0.5, // 테두리 두께
    //                                           ),
    //                                         ),
    //                                         // elevation: 5, // 그림자 높이
    //                                       ),
    //                                       child: const Text("해설보기"),
    //                                     ),
    //                                     IconButton(
    //                                         onPressed: () {},
    //                                         icon: const Icon(
    //                                             Icons.bookmark_border)),
    //                                   ],
    //                                 ),
    //                                 const SizedBox(height: 10),
    //                                 // const Text(
    //                                 //   '여기에 모달의 내용을 입력하세요.',
    //                                 //   style: TextStyle(fontSize: 16),
    //                                 // ),
    //                                 const Spacer(),
    //                                 // ElevatedButton(
    //                                 //   onPressed: () {
    //                                 //     Navigator.pop(context); // 모달 닫기
    //                                 //   },
    //                                 //   child: const Text('닫기'),
    //                                 // ),
    //                                 NextButton(
    //                                   isEnabled: true,
    //                                   onPressed: () {},
    //                                   btnColor: Colors.blue,
    //                                 ),
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       )
    //                     // : null;
    //                     : widget.isQuiz && controller.isCorrectAnswer == 2
    //                         ? showModalBottomSheet(
    //                             backgroundColor: const Color(0xFFFFF2F1),
    //                             context: context,
    //                             shape: const RoundedRectangleBorder(
    //                                 // borderRadius: BorderRadius.vertical(
    //                                 //     top: Radius.circular(20)),
    //                                 ),
    //                             builder: (context) {
    //                               return Container(
    //                                 padding: const EdgeInsets.all(20),
    //                                 height: 183,
    //                                 width: 362,
    //                                 child: Column(
    //                                   crossAxisAlignment:
    //                                       CrossAxisAlignment.start,
    //                                   children: [
    //                                     Row(
    //                                       children: [
    //                                         SvgPicture.asset(
    //                                           'assets/subtract.svg', // SVG 파일 경로
    //                                           height: 32, // 높이
    //                                           width: 32, // 너비
    //                                           color: const Color(
    //                                               0xFFFF5468), // 색상 변경 (선택 사항)
    //                                         ),
    //                                         const SizedBox(
    //                                           width: 11.3,
    //                                         ),
    //                                         const Text(
    //                                           '아쉬워요',
    //                                           style: TextStyle(
    //                                             fontSize: 24,
    //                                             fontWeight: FontWeight.w500,
    //                                             height: 1.4,
    //                                           ),
    //                                         ),
    //                                         const SizedBox(
    //                                           width: 45,
    //                                         ),
    //                                         ElevatedButton(
    //                                           onPressed: () {},
    //                                           style: ElevatedButton.styleFrom(
    //                                             backgroundColor:
    //                                                 Colors.white, // 배경 색상
    //                                             foregroundColor:
    //                                                 Colors.black, // 글자 색상
    //                                             padding:
    //                                                 const EdgeInsets.symmetric(
    //                                                     horizontal: 20,
    //                                                     vertical: 15), // 내부 패딩
    //                                             shape: RoundedRectangleBorder(
    //                                               borderRadius:
    //                                                   BorderRadius.circular(
    //                                                       10), // 모서리 둥글기
    //                                               side: const BorderSide(
    //                                                 color:
    //                                                     Colors.black, // 테두리 색상
    //                                                 width: 0.5, // 테두리 두께
    //                                               ),
    //                                             ),
    //                                             // elevation: 5, // 그림자 높이
    //                                           ),
    //                                           child: const Text("해설보기"),
    //                                         ),
    //                                         IconButton(
    //                                             onPressed: () {},
    //                                             icon: const Icon(
    //                                                 Icons.bookmark_border)),
    //                                       ],
    //                                     ),
    //                                     const SizedBox(height: 10),
    //                                     // const Text(
    //                                     //   '여기에 모달의 내용을 입력하세요.',
    //                                     //   style: TextStyle(fontSize: 16),
    //                                     // ),
    //                                     const Spacer(),
    //                                     // ElevatedButton(
    //                                     //   onPressed: () {
    //                                     //     Navigator.pop(context); // 모달 닫기
    //                                     //   },
    //                                     //   child: const Text('닫기'),
    //                                     // ),
    //                                     NextButton(
    //                                       isEnabled: true,
    //                                       onPressed: () {},
    //                                       btnColor: Colors.red,
    //                                     ),
    //                                   ],
    //                                 ),
    //                               );
    //                             },
    //                           )
    //                         : null;
    //
    //                 print("다음 문제로 이동");
    //                 if (widget.answer == controller.selectedNumber.value &&
    //                     widget.isQuiz) {
    //                   setState(() {
    //                     // 정답인 경우
    //                     controller.isCorrectAnswer = 1;
    //                     controller.clickCheckBtn = true;
    //                   });
    //                 } else {
    //                   //답이 틀린 경우
    //                   setState(() {
    //                     controller.isCorrectAnswer = 2;
    //                     controller.clickCheckBtn = true;
    //                   });
    //                 }
    //               },
    //             )),
    //       ],
    //     ),
    //   ],
    // );
    return Stack(
      children: [
        Center(
          child: Column(
            children: [
              SizedBox(
                height: 550,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 22,
                      ),
                      // 질문 부분
                      Container(
                        width: 328,
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
                          width: 237,
                          child: Text(
                            addZeroWidthJoiner(
                                widget.question), // 유틸리티 함수 호출 (한글 단어 단위 줄바꿈)
                            style: const TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 20,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w500,
                              height: 1.70,
                              letterSpacing: -0.50,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 328,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 24),
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
                                                vertical: 8),
                                            child: MultipleOptionContainer(
                                              widget: widget,
                                              optionNum: index + 1,
                                              isSelected: controller
                                                      .selectedOption.value ==
                                                  index,
                                              isQuiz: true,
                                              isCorrect: controller
                                                          .isCorrectAnswer
                                                          .value ==
                                                      1
                                                  ? true
                                                  : false,
                                            ),
                                          )
                                        : GestureDetector(
                                            onTap: () {
                                              controller.selectOption(
                                                  index); // 선택된 옵션 저장
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
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
                                            isCorrect: controller
                                                        .isCorrectAnswer
                                                        .value ==
                                                    1
                                                ? true
                                                : false,
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
                          ? '레벨테스트 종료'
                          : '다음 문제',
                  onPress: controller.isNextButtonEnabled
                      ? widget.isQuiz
                          ? () {
                              controller.clickCheckBtn.value = true;
                              controller.isCorrectAnswer.value =
                                  controller.selectedOption.value == 0 ? 1 : 2;
                            }
                          : () {
                              // "다음 문제" 버튼 활성화
                              // 다음 문제로 넘어가는 로직 추가
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
                    decoration: controller.isCorrectAnswer.value == 1
                        ? const BoxDecoration(color: Color(0xFFE1F6FF))
                        : const BoxDecoration(color: Color(0xFFFFF2F1)),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(33),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    controller.isCorrectAnswer.value == 1
                                        ? 'assets/check_circle.png'
                                        : 'assets/subtract.png',
                                    width: 32,
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    controller.isCorrectAnswer.value == 1
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
                                  Container(
                                    width: 88,
                                    height: 40,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 1, color: Color(0xFFA2A2A2)),
                                        borderRadius: BorderRadius.circular(7),
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 4),
                                    child: Image.asset(
                                      'assets/bookmark.png',
                                      width: 15,
                                      height: 21,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        CustomButton(
                          text: widget.isLast ? '종료하기' : '다음 문제',
                          onPress: () {},
                          bgColor: controller.isCorrectAnswer.value == 1
                              ? const Color(0xff067BD5)
                              : const Color(0xffFF5468),
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

  // Container quizQuestion(
  //     double screenWidth, IconData bookmark, String question) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Color(0xfff2f3f5),
  //       borderRadius: BorderRadius.only(
  //         topLeft: Radius.circular(10),
  //         topRight: Radius.circular(10),
  //       ),
  //       border: Border(
  //         bottom: BorderSide(
  //           color: Color(0xffa2a2a2),
  //         ),
  //       ),
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         const SizedBox(
  //           height: 15,
  //         ),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         Center(
  //           child: SizedBox(
  //             width: screenWidth * 0.6917,
  //             child: Text(
  //               question,
  //               style: const TextStyle(
  //                 fontSize: 20,
  //                 fontWeight: FontWeight.w500,
  //                 fontFamily: 'Pretendard',
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Container QuizOptionsContainer(
  //     double screenWidth, double screenHeight, int option) {
  //   return Container(
  //     decoration: const BoxDecoration(
  //       color: Colors.white,
  //       borderRadius: BorderRadius.only(
  //         bottomLeft: Radius.circular(10),
  //         bottomRight: Radius.circular(10),
  //       ),
  //     ),
  //     child: option == 0
  //         ? Column(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: widget.option == 0
  //                 ? List.generate(
  //                     4,
  //                     (index) => GestureDetector(
  //                       onTap: () {
  //                         selectOption(index + 1);
  //                         print("ddd");
  //                         if (widget.answer ==
  //                             controller.selectedNumber.value) {
  //                           controller.isCorrectAnswer = 1;
  //                           print(controller.isCorrectAnswer);
  //                         } else {
  //                           controller.isCorrectAnswer = 0;
  //                           print(controller.isCorrectAnswer);
  //                         }
  //                       },
  //                       child: quizOptionCard(
  //                         screenWidth,
  //                         screenHeight,
  //                         controller.selectedNumber.value == index + 1
  //                             ? const Color(0xff1eb692)
  //                             : Colors.white,
  //                         controller.selectedNumber.value == index + 1
  //                             ? const Color(0xff1eb692)
  //                             : const Color(0xffd3d3d3),
  //                         index + 1,
  //                         widget.answerOptions![index],
  //                         widget.option,
  //                       ),
  //                     ),
  //                   )
  //                 : List.generate(
  //                     2,
  //                     (index) => GestureDetector(
  //                       onTap: () => selectOption(index + 1),
  //                       child: quizOptionCard(
  //                           screenWidth,
  //                           screenHeight,
  //                           controller.selectedNumber.value == index + 1
  //                               ? const Color(0xff1eb692)
  //                               : Colors.white,
  //                           controller.selectedNumber.value == index + 1
  //                               ? const Color(0xff1eb692)
  //                               : const Color(0xffd3d3d3),
  //                           index + 1,
  //                           oxOption![index],
  //                           widget.option),
  //                     ),
  //                   ),
  //           )
  //         : Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //             children: widget.option == 0
  //                 ? List.generate(
  //                     4,
  //                     (index) => GestureDetector(
  //                       onTap: () {
  //                         selectOption(index + 1);
  //                         // print("tj");
  //                       },
  //                       child: quizOptionCard(
  //                           screenWidth,
  //                           screenHeight,
  //                           controller.selectedNumber.value == index + 1
  //                               ? const Color(0xff1eb692)
  //                               : Colors.white,
  //                           controller.selectedNumber.value == index + 1
  //                               ? const Color(0xff1eb692)
  //                               : const Color(0xffd3d3d3),
  //                           index + 1,
  //                           widget.answerOptions![index],
  //                           widget.option),
  //                     ),
  //                   )
  //                 : List.generate(
  //                     2,
  //                     (index) => GestureDetector(
  //                       onTap: () => selectOption(index + 1),
  //                       child: quizOptionCard(
  //                         138,
  //                         138,
  //                         controller.selectedNumber.value == index + 1
  //                             ? const Color(0xff1eb692)
  //                             : Colors.white,
  //                         controller.selectedNumber.value == index + 1
  //                             ? const Color(0xff1eb692)
  //                             : const Color(0xffd3d3d3),
  //                         index + 1,
  //                         oxOption![index],
  //                         widget.option,
  //                       ),
  //                     ),
  //                   ),
  //           ),
  //   );
  // }

//   Container quizOptionCard(
//     double screenWidth,
//     double screenHeight,
//     Color background,
//     Color border,
//     int number,
//     String text,
//     int option,
//     // Color selectedColor,
//   ) {
//     return Container(
//       width: option == 0 ? screenWidth * 0.75 : 138,
//       height: option == 0 ? screenHeight * 0.08 : 138,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: border,
//           width: controller.selectedNumber.value == number ? 3.0 : 1.0,
//         ),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Row(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: option == 0
//                 ? Container(
//                     width: screenWidth * 0.02,
//                     height: screenHeight * 0.02,
//                     decoration: BoxDecoration(
//                       color: const Color(0xffe5e9ec),
//                       borderRadius: BorderRadius.circular(5),
//                     ),
//                     child: Center(
//                       child: Text(
//                         number.toString(),
//                         style: const TextStyle(
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   )
//                 : null,
//           ),
//           const SizedBox(
//             width: 10,
//           ),
//           Text(
//             text,
//             style: TextStyle(
//               fontSize: option == 0 ? 15 : 60,
//               fontFamily: 'Pretandard',
//               fontWeight: FontWeight.w500,
//               height: 1.1,
//               color: controller.selectedNumber.value == number
//                   ? Colors.black
//                   : Colors.black,
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
  // Container quizOptionCard(
  //   double screenWidth,
  //   double screenHeight,
  //   Color background,
  //   Color border,
  //   int number,
  //   String text,
  //   int option,
  // ) {
  //   bool isSelected = controller.selectedNumber.value == number;
  //   bool isCorrect = widget.answer == number; // 정답 여부 확인

  //   return Container(
  //     width: option == 0 ? screenWidth * 0.75 : 138,
  //     height: option == 0 ? screenHeight * 0.08 : 138,
  //     decoration: BoxDecoration(
  //       color: controller.isCorrectAnswer == 1 &&
  //               isSelected &&
  //               controller.clickCheckBtn
  //           ? const Color(0xffd8eafd)
  //           : controller.isCorrectAnswer == 2 &&
  //                   isSelected &&
  //                   controller.clickCheckBtn
  //               ? const Color(0xFFFFF2F1)
  //               : Colors.white,
  //       border: Border.all(
  //         // color: isCorrect && isSelected
  //         color: controller.isCorrectAnswer == 1 &&
  //                 isSelected &&
  //                 controller.clickCheckBtn
  //             ? const Color(0xff0044cc) // 정답인 경우 파란색 테두리 0xff1eb692
  //             : isSelected &&
  //                     controller.clickCheckBtn &&
  //                     controller.isCorrectAnswer == 2
  //                 ? const Color.fromARGB(255, 252, 38, 38)
  //                 // : const Color(0xffd3d3d3),
  //                 : isSelected && controller.clickCheckBtn != true //0xffd3d3d3
  //                     ? const Color(0xff1eb692)
  //                     : const Color(0xffd3d3d3),
  //         width: isSelected ? 3.0 : 1.0,
  //       ),
  //       borderRadius: BorderRadius.circular(12),
  //     ),
  //     child: Row(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(10),
  //           child: option == 0
  //               ? Container(
  //                   width: screenWidth * 0.02,
  //                   height: screenHeight * 0.02,
  //                   decoration: BoxDecoration(
  //                     color: const Color(0xffe5e9ec),
  //                     borderRadius: BorderRadius.circular(5),
  //                   ),
  //                   child: Center(
  //                     child: Text(
  //                       number.toString(),
  //                       style: const TextStyle(
  //                         fontSize: 12,
  //                         fontWeight: FontWeight.w500,
  //                       ),
  //                     ),
  //                   ),
  //                 )
  //               : null,
  //         ),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Text(
  //           text,
  //           style: TextStyle(
  //             fontSize: option == 0 ? 15 : 60,
  //             fontFamily: 'Pretendard',
  //             fontWeight: FontWeight.w500,
  //             height: 1.1,
  //             color: isCorrect && isSelected && controller.clickCheckBtn
  //                 ? const Color(0xff0044cc) // 파란색 글자
  //                 : Colors.black, // 기본 검정색
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

// class NextButton extends StatelessWidget {
//   const NextButton({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () => {print("onpressed")},
//       style: ElevatedButton.styleFrom(
//         minimumSize: Size(
//           ScreenUtils.getWidth(context, 328),
//           ScreenUtils.getHeight(context, 56),
//         ),
//         backgroundColor: const Color(0x001eb692),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16), // border-radius: 16px
//         ),
//         alignment: Alignment.center, // 텍스트 정렬
//         padding: EdgeInsets.zero,
//       ),
//       child: const Text("다음 문제",
//           style: TextStyle(
//             color: Color(0xFF111111),
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//           )),
//     );
//   }
// }
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
      width: 120,
      height: 120,
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
          textAlign: TextAlign.center,
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
      width: 264,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
          SizedBox(
            width: 190,
            child: Text(
              addZeroWidthJoiner(widget.answerOptions![optionNum - 1]),
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 18,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
