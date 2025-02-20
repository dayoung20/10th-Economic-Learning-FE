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
  late final int? quizId;

  @override
  void initState() {
    super.initState();
    quizId = Get.arguments['quizId']; // Get.arguments에서 quizId 가져오기
    controller.fetchQuizById(quizId!); // 서버에서 퀴즈 데이터 로드
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: quizId == null
          ? CustomAppBar(
              title: '고급퀴즈', // 레벨에 따른 이름 변경 필요
              icon: Icons.close,
              onPress: () => controller.showModal(),
              currentIndex: 1,
              totalIndex: 3,
            )
          : CustomAppBar(
              title: '학습 세트 이름', // 수정 필요
              icon: Icons.close,
              onPress: () => controller.showModal(),
            ),
      body: Obx(() {
        // 서버에서 받아온 퀴즈 데이터가 없고 quizId도 없는 경우
        if (quizId == null && controller.quizData.isEmpty) {
          // 예시 데이터 사용
          const question = 'Q. 다음 중 복리 효과가 경제적 결과로 나타날 수 있는 상황으로 적절한 것은?';
          const options = [
            '단기간 대출을 받은 경우',
            '장기간 투자한 예금 계좌의 이자가 점점 커지는 경우',
            '정기적으로 단리로 계산된 이자만 지급되는 경우',
            '원금만 같아도 되는 상황'
          ];
          const int option = 0; // 기본값으로 설정
          const int correctAnswerIndex = 1; // 예시 데이터의 정답 인덱스

          return Stack(
            children: [
              QuizCard(
                screenHeight: screenHeight,
                screenWidth: screenWidth,
                onPress: () {},
                option: option,
                question: question,
                answerOptions: options,
                isLast: false,
                isQuiz: true,
                answer: correctAnswerIndex,
              ),
              // 모달창
              Obx(() {
                return controller.isModalVisible.value
                    ? StopOptionModal(
                        closeModal: () => controller.hideModal(),
                        contents: '정말 퀴즈를 중단하시겠어요?',
                        keepBtnText: '계속할래요',
                        stopBtnText: '그만할래요',
                        keepFunc: () => controller.hideModal(),
                        stopFunc: () => controller.stopBtn(),
                      )
                    : const SizedBox();
              }),
            ],
          );
        }

        // 서버에서 받아온 퀴즈 데이터가 있는 경우
        if (controller.quizData.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // 서버에서 가져온 퀴즈 데이터
        final question = controller.quizData['question'] ?? '';

        // choiceList 처리
        final List<dynamic> choiceList =
            controller.quizData['choiceList']?['choiceList'] ?? [];
        final List<String> answerOptions = choiceList
            .map((choice) => choice['content'].toString()) // 명시적으로 String 변환
            .toList();

        // 정답 인덱스 계산
        final correctAnswerIndex = answerOptions
            .indexWhere((option) => option == controller.quizData['answer']);

        // 퀴즈 타입에 따른 옵션 설정
        final quizType = controller.quizData['type'] ?? '';
        final option = (quizType == "OX") ? 1 : 2;

        return Stack(
          children: [
            QuizCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onPress: () {},
              option: option, // 타입에 따른 옵션 값 전달
              question: question,
              answerOptions: answerOptions,
              isLast: false,
              isQuiz: true,
              answer: correctAnswerIndex,
            ),
            // 모달창
            Obx(() {
              return controller.isModalVisible.value
                  ? StopOptionModal(
                      closeModal: () => controller.hideModal(),
                      contents: '정말 퀴즈를 중단하시겠어요?',
                      keepBtnText: '계속할래요',
                      stopBtnText: '그만할래요',
                      keepFunc: () => controller.hideModal(),
                      stopFunc: () => controller.stopBtn(),
                    )
                  : const SizedBox();
            }),
          ],
        );
      }),
    );
  }
}
