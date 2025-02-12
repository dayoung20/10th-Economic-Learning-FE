import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view/widgets/stop_option_modal.dart';
import 'package:economic_fe/view_model/test/test_multiple_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class TestMultipleChoicePage extends StatefulWidget {
  const TestMultipleChoicePage({super.key});

  @override
  State<TestMultipleChoicePage> createState() => _TestMultipleChoicePageState();
}

class _TestMultipleChoicePageState extends State<TestMultipleChoicePage> {
  int? selectedOption;
  late final Map<String, dynamic> args;
  late final List<QuizModel> quizList;

  // 해당하는 index의 문제제
  late final QuizModel quiz;

  // 레벨테스트 문제들 중 몇번째 문제인지
  late final index;
  // late final LevelTestAnswerModel answerModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    args = Get.arguments ?? {};
    quizList = args["quizList"] ?? [];
    index = args['index'];
    quiz = quizList[index];
    // answerModel = args["answeranswer"];
  }

  final TestMultipleController controller = Get.put(TestMultipleController());

  final question = 'Q. 다음 중 복리 효과가 경제적 결과로 나타날 수 있는 상황으로 적절한 것은?';
  final List<String> options = [
    '단기간 대출을 받은 경우',
    '장기간 투자한 예금 계좌의 이자가 점점 커지는 경우',
    '정기적으로 단리로 계산된 이자만 지급되는 경우',
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
      appBar: CustomAppBar(
        title: '레벨테스트',
        icon: Icons.close,
        onPress: () => controller.showModal(),
        currentIndex: 9,
        totalIndex: 9,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: QuizCard(
                  screenHeight: screenHeight,
                  screenWidth: screenWidth,
                  onPress: () {},
                  option: 0, // 다중 선택
                  question: question,
                  answerOptions: options,
                  isLast: !(index <= 8),
                  isQuiz: false,
                  onOptionSelected: (int selected) {
                    setState(() {
                      controller.choiceId.value = selected;
                      print("selected : ${controller.choiceId.value}");
                      controller.addAnswer(
                          quiz.id, quiz.choiceList.first.choiceId + selected);
                      controller.clickedNextBtn(context, index, quizList);
                    });
                  },
                ),
              ),
            ],
          ),
          // 모달창
          Obx(() {
            return controller.isModalVisible.value
                ? StopOptionModal(
                    closeModal: () => controller.hideModal(),
                    contents: '정말 레벨테스트를 중단하시겠어요?',
                    keepBtnText: '계속할래요',
                    stopBtnText: '그만할래요',
                    keepFunc: () => controller.hideModal(),
                    stopFunc: () => controller.stopLevelTestBtn(),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
