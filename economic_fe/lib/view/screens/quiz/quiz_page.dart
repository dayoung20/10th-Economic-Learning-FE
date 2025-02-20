import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view/widgets/stop_option_modal.dart';
import 'package:economic_fe/view_model/quiz/quiz_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizPageController controller = Get.put(QuizPageController());
  late final int quizId;
  late final String? learningSetName;
  late final bool isMultiQuizMode;
  late final int currentIndex;
  late final int totalIndex;
  late final List<dynamic>? quizzes;

  @override
  void initState() {
    super.initState();

    // `Get.arguments`에서 안전하게 값 가져오기
    quizId = Get.arguments['quizId'] ?? 0;
    learningSetName = Get.arguments['learningSetName'] ?? "퀴즈";
    isMultiQuizMode = Get.arguments['isMultiQuizMode'] ?? false;
    currentIndex = Get.arguments['currentIndex'] ?? 1;
    totalIndex = Get.arguments['totalIndex'] ?? 1;
    quizzes = Get.arguments['quizzes'];

    // 단일 퀴즈 및 연속 퀴즈 모두 정상 작동하도록 fetchQuizById() 실행
    controller.resetQuizState();
    controller.fetchQuizById(quizId);
  }

  void goToNextQuiz() {
    if (isMultiQuizMode && quizzes != null && currentIndex < totalIndex - 1) {
      print("다음 퀴즈로 이동: ${currentIndex + 1} / 총 $totalIndex 개");

      Get.off(
        () => const QuizPage(),
        arguments: {
          'quizId': quizzes![currentIndex + 1]['id'],
          'learningSetName': quizzes![currentIndex + 1]['category'],
          'isMultiQuizMode': true,
          'currentIndex': currentIndex + 1,
          'totalIndex': totalIndex,
          'quizzes': quizzes,
        },
        preventDuplicates: false, // 중복 방지 해제
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      print("퀴즈 종료: 총 $totalIndex 개 완료");
      Get.offNamed('/mypage/wrong'); // 퀴즈 종료 후 WrongQuizPage로 이동
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: learningSetName ?? '퀴즈',
        icon: Icons.close,
        onPress: () => controller.showModal(),
        currentIndex: isMultiQuizMode ? currentIndex : null, // 진행률 표시 여부
        totalIndex: isMultiQuizMode ? totalIndex : null,
      ),
      body: Obx(() {
        if (controller.quizData.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        final question = controller.quizData['question'] ?? '';
        final List<dynamic> choiceList =
            controller.quizData['choiceList']?['choiceList'] ?? [];
        final List<String> answerOptions =
            choiceList.map((choice) => choice['content'].toString()).toList();

        final correctAnswerIndex = answerOptions
            .indexWhere((option) => option == controller.quizData['answer']);

        final quizType = controller.quizData['type'] ?? '';
        final option = (quizType == "OX") ? 1 : 0;

        return Stack(
          children: [
            QuizCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onPress: () {},
              option: option,
              question: question,
              answerOptions: answerOptions,
              isLast: !isMultiQuizMode ||
                  currentIndex ==
                      totalIndex, // 단일 퀴즈이므로 true로 설정하여 "퀴즈 종료" 버튼 표시
              isQuiz: true,
              answer: correctAnswerIndex,
              isCorrectQuiz: controller.isCorrect.value,
              quizId: quizId,
              onOptionSelected: (int selectedIndex) {
                controller.selectedIndex.value = selectedIndex;
                controller.isNextButtonEnabled.value = true;
                goToNextQuiz(); // 정답 여부와 상관없이 다음 문제로 이동
              },
              onNextQuizBtn: isMultiQuizMode ? goToNextQuiz : null,
              onFinishTest: controller.finishQuiz,
            ),
            Obx(() {
              return controller.isModalVisible.value
                  ? StopOptionModal(
                      closeModal: () => controller.hideModal(),
                      contents: '정말 퀴즈를 중단하시겠어요?',
                      keepBtnText: '계속할래요',
                      stopBtnText: '그만할래요',
                      keepFunc: () => controller.hideModal(),
                      stopFunc: () => Get.offNamed('/mypage/wrong'),
                    )
                  : const SizedBox();
            }),
          ],
        );
      }),
    );
  }
}
