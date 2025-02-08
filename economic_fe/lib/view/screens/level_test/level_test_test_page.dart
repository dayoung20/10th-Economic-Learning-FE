import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view_model/test/level_test_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LevelTestTestPage extends StatefulWidget {
  const LevelTestTestPage({super.key});

  @override
  State<LevelTestTestPage> createState() => _LevelTestTestPageState();
}

class _LevelTestTestPageState extends State<LevelTestTestPage> {
  final LevelTestTestController controller = Get.put(LevelTestTestController());
  late final Map<String, dynamic> args;
  late final List<QuizModel> quizList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizList = Get.arguments ?? [];
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // 기본 높이 설정
        child: Obx(() {
          return CustomAppBar(
            title: '레벨테스트',
            icon: Icons.close,
            onPress: () => controller.showModal(),
            currentIndex: controller.currentQuizIdx.value + 1,
            totalIndex: 9,
          );
        }),
      ),
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
                        // option: quizList[controller.currentQuizIdx.value]
                        //             .choiceList
                        //             .length ==
                        //         2
                        //     ? 1
                        //     : 0,
                        question:
                            quizList[controller.currentQuizIdx.value].question,
                        isLast: !(controller.currentQuizIdx.value < 8),
                        isQuiz: false,
                        onOptionSelected: (int selected) {
                          setState(() {
                            // controller.choiceId.value = selected;
                            // print("selected : ${controller.choiceId.value}");
                            // controller.addAnswer(
                            //     quiz.id, quiz.choiceList.first.choiceId + selected);
                            // print("중간");
                            // print("index : $index");
                            // controller.clickedNextBtn(context, index, quizList);

                            // 선택한 답안 저장
                            controller.levelTestAnswers.add(
                              LevelTestAnswerModel(
                                quizId:
                                    quizList[controller.currentQuizIdx.value]
                                        .id,
                                answer:
                                    quizList[controller.currentQuizIdx.value]
                                        .choiceList[selected]
                                        .choiceId, // 선택한 옵션의 ID 저장
                              ),
                            );

                            print(
                                "selected answer : ${controller.levelTestAnswers}");

                            print(
                                "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");

                            controller.currentQuizIdx++;
                          });
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
                        isQuiz: false,
                        isLast: controller.currentQuizIdx.value + 1 == 9,
                        onOptionSelected: (int selected) {
                          setState(() {
                            controller.levelTestAnswers.add(
                              LevelTestAnswerModel(
                                quizId:
                                    quizList[controller.currentQuizIdx.value]
                                        .id,
                                answer:
                                    quizList[controller.currentQuizIdx.value]
                                        .choiceList[selected]
                                        .choiceId, // 선택한 옵션의 ID 저장
                              ),
                            );

                            print(
                                "selected answer : ${controller.levelTestAnswers}");

                            print(
                                "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");

                            controller.currentQuizIdx++;
                          });
                        },
                      ));
          }),
        ],
      ),
    );
  }
}
