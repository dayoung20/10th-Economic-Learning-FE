import 'package:economic_fe/data/models/quiz_test_model.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view/widgets/stop_option_modal.dart';
import 'package:economic_fe/view_model/quiz/quiz_test_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 레벨테스트 문제 9개 전체

class QuizTestPage extends StatefulWidget {
  const QuizTestPage({super.key});

  @override
  State<QuizTestPage> createState() => _QuizTestPageState();
}

class _QuizTestPageState extends State<QuizTestPage> {
  final QuizTestController controller = Get.put(QuizTestController());
  // late final Map<String, dynamic> args;
  // late final List<QuizTestModel> quizList;
  @override
  void initState() {
    super.initState();
    // quizList = controller.quizList;

    // 화면 진입 시마다 퀴즈 새로 요청
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchQuizList();
    });
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
                title: controller.conceptName.value,
                icon: Icons.close,
                onPress: controller.showModal,
                currentIndex: controller.currentQuizIdx.value + 1,
                totalIndex: controller.quizList.length,
              ))),
      body: Stack(
        children: [
          Obx(() {
            if (controller.quizList.isEmpty) {
              return const Center(child: CircularProgressIndicator()); // 로딩 표시
            }
            return Align(
                alignment: Alignment.topCenter,
                child: controller.quizList[controller.currentQuizIdx.value]
                            .choiceList.length ==
                        2
                    ? QuizCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        onPress: () {},
                        option: 1, // ox 문제
                        question: controller
                            .quizList[controller.currentQuizIdx.value].question,
                        isLast: (controller.currentQuizIdx.value + 1 ==
                            controller.quizList.length),
                        isQuiz: true,
                        isCorrectQuiz: controller.isCorrect.value,
                        quizId: controller
                            .quizList[controller.currentQuizIdx.value].quizId,
                        onOptionSelected: (int selected) {
                          setState(() {
                            controller.currentQuizIdx++;
                            print("select : $selected");
                          });
                        },
                        onNextQuizBtn: () {
                          controller.currentQuizIdx++;
                        },
                        onFinishTest: () {
                          controller.postQuizFinish(
                              controller.learningSetId.value,
                              controller.level.value);
                          controller.finishQuiz();
                        },
                      )
                    : QuizCard(
                        screenHeight: screenHeight,
                        screenWidth: screenWidth,
                        onPress: () {},
                        option: 0,
                        answerOptions: controller
                            .quizList[controller.currentQuizIdx.value]
                            .choiceList
                            .map((choice) => choice.content)
                            .toList(),
                        question: controller
                            .quizList[controller.currentQuizIdx.value].question,
                        isQuiz: true,
                        isLast: (controller.currentQuizIdx.value + 1 ==
                            controller.quizList.length),
                        isCorrectQuiz: controller.isCorrect.value,
                        quizId: controller
                            .quizList[controller.currentQuizIdx.value].quizId,
                        onOptionSelected: (int selected) {
                          setState(() {
                            controller.currentQuizIdx++;
                            print("select : $selected");
                          });
                        },
                        onNextQuizBtn: () {
                          controller.currentQuizIdx++;
                        },
                        onFinishTest: () {
                          controller.postQuizFinish(
                              controller.learningSetId.value,
                              controller.level.value);
                          controller.finishQuiz();
                        },
                      ));
          }),
          Obx(() {
            return controller.isModalVisible.value
                ? StopOptionModal(
                    closeModal: controller.hideModal,
                    contents: '정말 퀴즈를 중단하시겠어요?',
                    keepBtnText: '계속할래요',
                    stopBtnText: '그만할래요',
                    keepFunc: controller.hideModal,
                    stopFunc: controller.clickedCloseBtn,
                    isFinishPage: false,
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
