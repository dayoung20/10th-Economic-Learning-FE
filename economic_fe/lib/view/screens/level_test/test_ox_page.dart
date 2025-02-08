import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/quiz_card.dart';
import 'package:economic_fe/view/widgets/stop_option_modal.dart';
import 'package:economic_fe/view_model/test/test_ox_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestOxPage extends StatefulWidget {
  const TestOxPage({super.key});

  @override
  State<TestOxPage> createState() => _TestMultipleChoicePageState();
}

class _TestMultipleChoicePageState extends State<TestOxPage> {
  final TestOxController controller = Get.put(TestOxController());
  int? selectedOption;
  late final Map<String, dynamic> args;
  late final List<QuizModel> quizList;

  // 해당하는 index의 문제
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
    // answerModel = args["answer"];
  }

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
        currentIndex: index + 1,
        totalIndex: 9,
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: QuizCard(
              screenHeight: screenHeight,
              screenWidth: screenWidth,
              onPress: () {},
              option: 1, // ox 문제
              question: quiz.question,
              isLast: !(index <= 8),
              isQuiz: false,
              onOptionSelected: (int selected) {
                setState(() {
                  controller.choiceId.value = selected;
                  print("selected : ${controller.choiceId.value}");
                  // controller.addAnswer(
                  //     quiz.id, quiz.choiceList.first.choiceId + selected);
                  print("중간");
                  print("index : $index");
                  controller.clickedNextBtn(context, index, quizList);
                });
              },
            ),
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
                    stopFunc: () => controller.stopBtn(),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
