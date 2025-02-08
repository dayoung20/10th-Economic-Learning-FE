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
  // final question = 'Q. 다음 중 복리 효과가 경제적 결과로 나타날 수 있는 상황으로 적절한 것은?';
  late final QuizModel quiz;
  late final index;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    args = Get.arguments ?? {};
    quizList = args["quizList"] ?? [];
    index = args['index'];
    quiz = quizList[index];
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
        currentIndex: 1,
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
              option: 1,
              question: quiz.question,
              isLast: false,
              isQuiz: false,
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
