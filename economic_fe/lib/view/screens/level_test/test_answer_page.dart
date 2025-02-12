import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/test/test_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TestAnswerPage extends StatefulWidget {
  const TestAnswerPage({super.key});

  @override
  State<TestAnswerPage> createState() => _TestAnswerPageState();
}

class _TestAnswerPageState extends State<TestAnswerPage> {
  final TestAnswerController controller = Get.put(TestAnswerController());
  late final Map<String, dynamic> response;
  late final List<LevelTestAnswerModel> answers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    response = arguments['response'];
    answers = arguments['answer'];
  }

  @override
  Widget build(BuildContext context) {
    // final TestAnswerController controller = Get.put(TestAnswerController());

    // 선지 데이터 (예제)
    final options = [
      '선지 1 내용',
      '선지 2 내용',
      '선지 3 내용',
      '선지 4 내용',
    ];
    const selectedOptionIndex = 1; // 선택된 선지 (예제)

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: controller.close,
          child: const Icon(Icons.close),
        ),
        centerTitle: true,
        title: Obx(() {
          return GestureDetector(
            onTap: controller.showModal,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${controller.currentQuestionIndex.value + 1}번',
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.50,
                  ),
                ),
                const Icon(Icons.keyboard_arrow_down),
              ],
            ),
          );
        }),
      ),
      body: Stack(
        children: [
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  const TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: -0.35,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.35,
                    ),
                    tabs: [
                      Tab(
                        text: '문제',
                        height: 44,
                      ),
                      Tab(
                        text: '해설',
                        height: 44,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  // 문제 탭 내용
                  Expanded(
                    child: TabBarView(
                      children: [
                        Obx(() {
                          return // 문제
                              Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width - 32,
                                padding: const EdgeInsets.only(
                                  top: 28,
                                  left: 40,
                                  right: 40,
                                  bottom: 24,
                                ),
                                decoration: const ShapeDecoration(
                                  color: Color(0xFFF2F3F5),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  '${controller.currentQuestionIndex.value + 1}. 문제',
                                  style: const TextStyle(
                                    color: Color(0xFF111111),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    height: 1.70,
                                    letterSpacing: -0.50,
                                  ),
                                ),
                              ),
                              // 선지
                              Container(
                                width: MediaQuery.of(context).size.width - 32,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 24),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                  ),
                                  border: Border(
                                    left: BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    right: BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    bottom: BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                  ),
                                ),
                                child: Column(
                                  children:
                                      List.generate(options.length, (index) {
                                    final isSelected =
                                        selectedOptionIndex == index + 1;
                                    final isCorrect = controller.answers[
                                        controller.currentQuestionIndex.value];
                                    return Container(
                                      margin: const EdgeInsets.only(
                                          bottom: 16), // 선지 간 간격
                                      width: MediaQuery.of(context).size.width -
                                          96,
                                      padding: const EdgeInsets.all(16),
                                      decoration: ShapeDecoration(
                                        color: isSelected
                                            ? isCorrect
                                                ? const Color(0xffE1F6FF) // 정답
                                                : const Color(0xffFFF2F1) // 오답
                                            : Colors.white, // 기본 배경 색상
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: isSelected ? 3 : 1, // 테두리 두께
                                            color: isSelected
                                                ? isCorrect
                                                    ? const Color(
                                                        0xff067BD5) // 정답
                                                    : const Color(
                                                        0xffFF5468) // 오답
                                                : const Color(
                                                    0xFFD9D9D9), // 기본 테두리 색상
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: ShapeDecoration(
                                              color: isSelected
                                                  ? isCorrect
                                                      ? const Color(
                                                          0xff067BD5) // 정답
                                                      : const Color(
                                                          0xffFF5468) // 오답
                                                  : const Color(
                                                      0xFFF2F3F5), // 기본 번호 배경색
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '${index + 1}', // 선지 번호
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors
                                                          .white // 선택된 번호 텍스트 색상
                                                      : const Color(
                                                          0xFF111111), // 기본 번호 텍스트 색상
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.40,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            options[index], // 선지 내용
                                            style: const TextStyle(
                                              color: Color(0xFF111111),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              height: 1.40,
                                              letterSpacing: -0.45,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          );
                        }),
                        Obx(() {
                          return // 해설
                              Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              '${controller.currentQuestionIndex.value + 1}번 문제 해설 내용',
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.70,
                                letterSpacing: -0.40,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 문제 번호 선택 모달창
          Obx(() {
            return controller.isModalVisible.value
                ? Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: controller.hideModal, // 모달창 닫기
                      child: Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black.withOpacity(0.5), // 어두운 배경
                        child: GestureDetector(
                          onTap: () {}, // 모달창 배경 클릭 방지
                          child: DraggableScrollableSheet(
                            initialChildSize: 0.7,
                            minChildSize: 0.2,
                            maxChildSize: 0.8,
                            builder: (context, scrollController) {
                              return Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 24,
                                        left: 24,
                                        right: 24,
                                        bottom: 20,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text(
                                            '문제 번호',
                                            style: TextStyle(
                                              color: Color(0xFF111111),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              height: 1.20,
                                              letterSpacing: -0.45,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: controller.hideModal,
                                            child: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 9,
                                          left: 24,
                                          right: 24,
                                          bottom: 24),
                                      child: Column(
                                        children: List.generate(
                                          controller.answers.length,
                                          (index) {
                                            final isSelected = controller
                                                    .currentQuestionIndex
                                                    .value ==
                                                index;
                                            final isCorrect =
                                                controller.answers[index];
                                            return GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectQuestion(index);
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical:
                                                            15), // Row 간 간격
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Icon(
                                                          isCorrect
                                                              ? Icons
                                                                  .circle_outlined
                                                              : Icons.close,
                                                          size: 15,
                                                          color: isSelected
                                                              ? Palette
                                                                  .buttonColorBlue
                                                              : const Color(
                                                                  0xff767676),
                                                        ),
                                                        const SizedBox(
                                                          width: 8.5,
                                                        ),
                                                        Text(
                                                          '${index + 1}번', // 번호 표시
                                                          style: TextStyle(
                                                            color: isSelected
                                                                ? const Color(
                                                                    0xFF2AD6D6)
                                                                : const Color(
                                                                    0xff767676),
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            height: 1.40,
                                                            letterSpacing:
                                                                -0.40,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    isSelected
                                                        ? const Icon(
                                                            Icons.check_circle,
                                                            size: 20,
                                                            color: Palette
                                                                .buttonColorBlue,
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
