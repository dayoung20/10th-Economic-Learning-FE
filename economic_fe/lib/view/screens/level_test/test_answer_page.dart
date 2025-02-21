import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/test/test_answer_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  late final List<QuizModel> quizList;

  @override
  void initState() {
    super.initState();
    final arguments = Get.arguments as Map<String, dynamic>;
    response = arguments['response'];
    answers = arguments['answer'];
    quizList = arguments['quizList'];
  }

  @override
  Widget build(BuildContext context) {
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
            // onTap: controller.showModal,
            onTap: () => showAnswerModal(context),
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
                  TabBar(
                    indicator: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 3.w,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelStyle: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: -0.35,
                    ),
                    unselectedLabelStyle: TextStyle(
                      color: const Color(0xFF767676),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.35,
                    ),
                    tabs: [
                      Tab(
                        text: '문제',
                        height: 44.h,
                      ),
                      Tab(
                        text: '해설',
                        height: 44.h,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 29.h,
                  ),
                  // 문제 탭 내용
                  Expanded(
                    child: TabBarView(
                      children: [
                        Obx(() {
                          return // 문제
                              Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 16.h),
                            child: ListView(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 32.w,
                                  padding: EdgeInsets.only(
                                    top: 28.h,
                                    left: 40.w,
                                    right: 40.w,
                                    bottom: 24.h,
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
                                    '${controller.currentQuestionIndex.value + 1}. ${response["results"]["answerResponses"][controller.currentQuestionIndex.value]["question"]}',
                                    style: TextStyle(
                                      color: const Color(0xFF111111),
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w500,
                                      height: 1.70,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                ),
                                // 선지
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width - 32.w,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 32.w, vertical: 24.h),
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
                                    children: List.generate(
                                        quizList[controller
                                                .currentQuestionIndex.value]
                                            .choiceList
                                            .length, (index) {
                                      final isSelected = answers[controller
                                                  .currentQuestionIndex.value]
                                              .answer ==
                                          quizList[controller
                                                  .currentQuestionIndex.value]
                                              .choiceList[index]
                                              .content;
                                      final isCorrect = response["results"]
                                              ["answerResponses"][
                                          controller.currentQuestionIndex
                                              .value]["isCorrect"];
                                      print("isCorrect : $isCorrect");
                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: 16.h), // 선지 간 간격
                                        width:
                                            MediaQuery.of(context).size.width -
                                                96.w,
                                        padding: const EdgeInsets.all(16),
                                        decoration: ShapeDecoration(
                                          color: isSelected
                                              ? isCorrect
                                                  ? const Color(
                                                      0xffE1F6FF) // 정답
                                                  : const Color(
                                                      0xffFFF2F1) // 오답
                                              : Colors.white, // 기본 배경 색상
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              width:
                                                  isSelected ? 3 : 1, // 테두리 두께
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
                                              width: 24.w,
                                              height: 24.h,
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
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.40,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            SizedBox(
                                              width: 190.w,
                                              child: Text(
                                                quizList[controller
                                                        .currentQuestionIndex
                                                        .value]
                                                    .choiceList[index]
                                                    .content, // 선지 내용
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF111111),
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.40,
                                                  letterSpacing: -0.45,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                        Obx(() {
                          return // 해설
                              Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              '${response["results"]["answerResponses"][controller.currentQuestionIndex.value]["explanation"]}',
                              style: TextStyle(
                                color: const Color(0xFF111111),
                                fontSize: 16.sp,
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
        ],
      ),
    );
  }

  void showAnswerModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: 500.h,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 24.h,
                      left: 24.w,
                      right: 24.w,
                      bottom: 20.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '문제 번호',
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.20,
                            letterSpacing: -0.45,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.close,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Obx(() {
                    return Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 9.h, left: 24.w, right: 24.w, bottom: 24.h),
                          child: Column(
                            children: List.generate(
                              // controller.answers.length,
                              answers.length,
                              (index) {
                                final isSelected =
                                    controller.currentQuestionIndex.value ==
                                        index;
                                final isCorrect =
                                    // controller.answers[index];
                                    response["results"]["answerResponses"]
                                        [index]["isCorrect"];
                                print(response["results"]["answerResponses"]
                                    [index]["isCorrect"]);
                                return GestureDetector(
                                  onTap: () {
                                    print("sele : $index");
                                    controller.selectQuestion(index);
                                    Navigator.pop(context);
                                    print("sele : $index");
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15.h), // Row 간 간격
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              isCorrect
                                                  ? Icons.circle_outlined
                                                  : Icons.close,
                                              size: 15,
                                              color: isSelected
                                                  ? Palette.buttonColorBlue
                                                  : const Color(0xff767676),
                                            ),
                                            const SizedBox(
                                              width: 8.5,
                                            ),
                                            Text(
                                              '${index + 1}번', // 번호 표시
                                              style: TextStyle(
                                                color: isSelected
                                                    ? const Color(0xFF2AD6D6)
                                                    : const Color(0xff767676),
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.w600,
                                                height: 1.40,
                                                letterSpacing: -0.40,
                                              ),
                                            ),
                                          ],
                                        ),
                                        isSelected
                                            ? Icon(
                                                Icons.check_circle,
                                                size: 20.w,
                                                color: Palette.buttonColorBlue,
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
                      ),
                    );
                  }),
                ],
              ),
            );
          });
        });
  }
}
