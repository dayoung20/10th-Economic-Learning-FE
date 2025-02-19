import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/data/models/quiz_test_model.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view_model/quiz/quiz_test_controller.dart';
import 'package:economic_fe/view_model/test/level_test_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

// 레벨테스트 문제 9개 전체

class QuizTestPage extends StatefulWidget {
  const QuizTestPage({super.key});

  @override
  State<QuizTestPage> createState() => _QuizTestPageState();
}

class _QuizTestPageState extends State<QuizTestPage> {
  final QuizTestController controller = Get.put(QuizTestController());
  // late final Map<String, dynamic> args;
  late final List<QuizTestModel> quizList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizList = controller.quizList;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight), // 기본 높이 설정
          child: Obx(() => CustomAppBar(
                title: '레벨선택',
                icon: Icons.close,
                onPress: () {
                  Navigator.pop(context);
                  controller.currentQuizIdx.value = 0;
                },
                currentIndex: controller.currentQuizIdx.value + 1,
                totalIndex:
                    controller.quizList.length, // ✅ quizList도 Obx 안에서 접근해야 함
              ))),
      body: Stack(
        children: [
          Obx(() {
            return Align(
                alignment: Alignment.topCenter,
                child: quizList[controller.currentQuizIdx.value]
                            .choiceList
                            .length ==
                        2
                    ? QuizCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        onPress: () {},
                        option: 1, // ox 문제
                        question:
                            quizList[controller.currentQuizIdx.value].question,
                        isLast: !(controller.currentQuizIdx.value < 8),
                        isQuiz: true,
                        isCorrectQuiz: controller.isCorrect.value,
                        quizId:
                            quizList[controller.currentQuizIdx.value].quizId,
                        onOptionSelected: (int selected) {
                          setState(() {
                            // // 선택한 답안 저장
                            // controller.levelTestAnswers.add(
                            //   LevelTestAnswerModel(
                            //     quizId:
                            //         quizList[controller.currentQuizIdx.value]
                            //             .id,
                            //     answer:
                            //         quizList[controller.currentQuizIdx.value]
                            //             .choiceList[selected]
                            //             .content, // 선택한 옵션의 ID 저장
                            //   ),
                            // );
                            // print(
                            //     "selected answer : ${controller.levelTestAnswers}");
                            // print(
                            //     "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");
                            // print("현재 idx : ${controller.currentQuizIdx}");
                            // controller.postSubmitQuiz(
                            //     quizList[controller.currentQuizIdx.value]
                            //         .quizId,
                            //     selected);
                            controller.currentQuizIdx++;
                            print("select : $selected");
                          });
                        },
                        onNextQuizBtn: () {
                          controller.currentQuizIdx++;
                        },
                      )
                    : QuizCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        onPress: () {},
                        option: 0,
                        answerOptions: quizList[controller.currentQuizIdx.value]
                            .choiceList
                            .map((choice) => choice.content)
                            .toList(),
                        question:
                            quizList[controller.currentQuizIdx.value].question,
                        isQuiz: true,
                        isLast: controller.currentQuizIdx.value == 8,
                        isCorrectQuiz: controller.isCorrect.value,
                        onOptionSelected: (int selected) {
                          setState(() {
                            // // 선택한 답안 저장
                            // controller.levelTestAnswers.add(
                            //   LevelTestAnswerModel(
                            //     quizId:
                            //         quizList[controller.currentQuizIdx.value]
                            //             .id,
                            //     answer:
                            //         quizList[controller.currentQuizIdx.value]
                            //             .choiceList[selected]
                            //             .content, // 선택한 옵션의 ID 저장
                            //   ),
                            // );

                            // print(
                            //     "selected answer : ${controller.levelTestAnswers}");

                            // print(
                            //     "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");
                            // print("현재 idx : ${controller.currentQuizIdx}");
                            controller.postSubmitQuiz(
                                quizList[controller.currentQuizIdx.value]
                                    .quizId,
                                selected);
                            // controller.currentQuizIdx++;
                            print("select : $selected");
                          });
                        },
                        onNextQuizBtn: () {
                          controller.currentQuizIdx++;
                        },
                        onFinishTest: () {
                          // controller.clickedToKaKao(quizList);
                        },
                      ));
          }),
        ],
      ),
    );
  }
}
