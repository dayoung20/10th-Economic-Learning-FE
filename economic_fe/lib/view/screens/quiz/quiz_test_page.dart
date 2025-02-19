import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
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
  // late final List<QuizModel> quizList;

  // @override
  // void initState() {
  //   super.initState();
  //   quizList = Get.arguments ?? [];
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight), // 기본 높이 설정
          child: CustomAppBar(
            title: '레벨테스트',
            icon: Icons.close,
            onPress: () {
              Navigator.pop(context);
            },
            // currentIndex: controller.currentQuizIdx.value + 1,
            totalIndex: 9,
          )),
      body: const Stack(
        children: [
          // Text(controller.learningSetId.value.toString()),
          // Text(controller.conceptName.value),
          // Text(controller.learningSetId.value.toString()),
          // Obx(() {
          //   return Align(
          //       alignment: Alignment.topCenter,
          //       child: quizList[controller.currentQuizIdx.value]
          //                   .choiceList
          //                   .length ==
          //               2
          //           ? QuizCard(
          //               screenHeight: screenHeight,
          //               screenWidth: screenWidth,
          //               onPress: () {},
          //               option: 1, // ox 문제
          //               question:
          //                   quizList[controller.currentQuizIdx.value].question,
          //               isLast: !(controller.currentQuizIdx.value < 8),
          //               isQuiz: false,
          //               onOptionSelected: (int selected) {
          //                 setState(() {
          //                   // 선택한 답안 저장
          //                   controller.levelTestAnswers.add(
          //                     LevelTestAnswerModel(
          //                       quizId:
          //                           quizList[controller.currentQuizIdx.value]
          //                               .id,
          //                       answer:
          //                           quizList[controller.currentQuizIdx.value]
          //                               .choiceList[selected]
          //                               .content, // 선택한 옵션의 ID 저장
          //                     ),
          //                   );

          //                   print(
          //                       "selected answer : ${controller.levelTestAnswers}");

          //                   print(
          //                       "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");
          //                   print("현재 idx : ${controller.currentQuizIdx}");
          //                   controller.currentQuizIdx++;
          //                 });
          //               },
          //             )
          //           : QuizCard(
          //               screenHeight: screenHeight,
          //               screenWidth: screenWidth,
          //               onPress: () {},
          //               option: 0,
          //               answerOptions: quizList[controller.currentQuizIdx.value]
          //                   .choiceList
          //                   .map((choice) => choice.content)
          //                   .toList(),
          //               question:
          //                   quizList[controller.currentQuizIdx.value].question,
          //               isQuiz: false,
          //               isLast: controller.currentQuizIdx.value == 8,
          //               onOptionSelected: (int selected) {
          //                 setState(() {
          //                   controller.levelTestAnswers.add(
          //                     LevelTestAnswerModel(
          //                       quizId:
          //                           quizList[controller.currentQuizIdx.value]
          //                               .id,
          //                       answer:
          //                           quizList[controller.currentQuizIdx.value]
          //                               .choiceList[selected]
          //                               .content,
          //                     ),
          //                   );

          //                   print(
          //                       "selected answer : ${controller.levelTestAnswers}");

          //                   print(
          //                       "선택한 답변 리스트: ${controller.levelTestAnswers.map((e) => e.toJson()).toList()}");
          //                   print("현재 idx : ${controller.currentQuizIdx}");
          //                   controller.currentQuizIdx++;
          //                 });
          //               },
          //               onFinishTest: () => controller.clickedToKaKao(quizList),
          //             ));
          // }),
        ],
      ),
    );
  }
}
