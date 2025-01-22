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

  final question = 'Q. 다음 중 복리 효과가 경제적 결과로 나타날 수 있는 상황으로 적절한 것은?';
  // int answer =
  final List<String> options = [
    '단기간 대출을 받은 경우',
    '장기간 투자한 예금 계좌의 이자가 점점 커지는 경우',
    '정기적으로 단리로 계산된 이자만 지급되는 경우',
    '원금만 같아도 되는 상황'
  ];
  @override
  Widget build(BuildContext context) {
    int? selectedOption;
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(80),
      //   child: AppBar(
      //     automaticallyImplyLeading: false, // 기본 뒤로가기 버튼 제거
      //     elevation: 0,
      //     backgroundColor: Colors.white, // AppBar 배경색
      //     flexibleSpace: SafeArea(
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.stretch,
      //         children: [
      //           // 상단 앱바
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 16),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 IconButton(
      //                   icon: const Icon(Icons.close, color: Colors.black),
      //                   onPressed: () {
      //                     Navigator.pop(context);
      //                   },
      //                 ),
      //                 const Text(
      //                   "고급퀴즈",
      //                   style: TextStyle(
      //                     fontSize: 18,
      //                     fontWeight: FontWeight.bold,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //                 const Text(
      //                   "1/3",
      //                   style: TextStyle(
      //                     fontSize: 16,
      //                     fontWeight: FontWeight.w500,
      //                     color: Colors.black,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           // 진행 바
      //           const LinearProgressIndicator(
      //             value: 0.1, // 진행 퍼센트 (0.0 ~ 1.0)
      //             backgroundColor: Color(0xffe0e0e0),
      //             color: Color(0xff1eb692), // 진행 바 색상
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
      appBar: CustomAppBar(
        title: '고급퀴즈', // 레벨에 따른 이름 변경 필요
        icon: Icons.close,
        onPress: () => controller.showModal(),
        currentIndex: 1,
        totalIndex: 3,
      ),
      body: Stack(
        children: [
          QuizCard(
            screenHeight: screenHeight,
            screenWidth: screenWidth,
            onPress: () {},
            option: 0,
            question: question,
            answerOptions: options,
            isLast: false,
            isQuiz: true,
            answer: 2,
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
      ),
    );
  }
}
