import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/test/leveltest_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeveltestResultPage extends StatefulWidget {
  const LeveltestResultPage({super.key});

  @override
  State<LeveltestResultPage> createState() => _LeveltestResultPageState();
}

class _LeveltestResultPageState extends State<LeveltestResultPage> {
  final LevelTestResultController controller =
      Get.put(LevelTestResultController());
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
    // GetX 컨트롤러 가져오기

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const SizedBox(
                    height: 34,
                  ),
                  const Text(
                    '레벨 테스트 결과',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      height: 1.30,
                      letterSpacing: -0.50,
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomPaint(
                        size: const Size(155, 155),
                        painter: CirclePainter(progress: 3 / 8), // 점수 / 총점(18)
                      ),
                      // 원형 차트의 중앙에 텍스트 추가
                      Column(
                        children: [
                          const Text(
                            '내 레벨',
                            style: TextStyle(
                              color: Color(0xFFA2A2A2),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 1.20,
                              letterSpacing: -0.35,
                            ),
                          ),
                          const SizedBox(
                            height: 9,
                          ),
                          // 레벨
                          Text(
                            response["results"]["level"] == "BEGINNER"
                                ? "초급"
                                : response["results"]["level"] == "INTERMEDIATE"
                                    ? "중급"
                                    : response["results"]["level"] == "ADVANCED"
                                        ? "고급"
                                        : "알 수 없음",
                            style: const TextStyle(
                              color: Color(0xFF111111),
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              height: 1.20,
                              letterSpacing: -0.80,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // 점수 해설 더보기창 버튼
                  GestureDetector(
                    // onTap: controller.showModal, // 모달창 열기
                    onTap: () => showCategoryModal(context),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 13.5,
                        ),
                        Text(
                          '리플이 점수를 계산하는 방법',
                          style: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.20,
                            letterSpacing: -0.35,
                          ),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xFFD9D9D9),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 13.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      height: 387,
                      padding: const EdgeInsets.only(
                        top: 24,
                        left: 24,
                        right: 24,
                        bottom: 20,
                      ),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(
                              width: 1, color: Color(0xFFA2A2A2)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: SizedBox(
                        height: 387 - 44,
                        child: Stack(
                          children: [
                            // 스크롤 가능한 영역
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // 레벨에 따른 텍스트 변경 필요
                                  Text(
                                    '${response["results"]["level"] == "BEGINNER" ? "축하합니다!" : response["results"]["level"] == "INTERMEDIATE" ? "잘했어요!" : response["results"]["level"] == "ADVANCED" ? "대단합니다!" : "알 수 없음"} 🎉\n당신은 ${response["results"]["level"] == "BEGINNER" ? "초급" : response["results"]["level"] == "INTERMEDIATE" ? "중급" : response["results"]["level"] == "ADVANCED" ? "고급" : "알 수 없음"} 단계입니다!',
                                    style: const TextStyle(
                                      color: Color(0xFF111111),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      height: 1.50,
                                      letterSpacing: -0.50,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 19,
                                  ),
                                  Text(
                                    response["results"]["level"] == "BEGINNER"
                                        ? "경제를 처음 시작하려는 당신에게 딱 맞는 학습이 준비되어 있어요. 초급 단계에서는 어렵고 복잡하게 느껴질 수 있는 경제를 친근하게 다가갈 수 있도록 구성했어요. 기초적인 용어와 개념부터 차근차근 배우면서 경제의 기본기를 탄탄히 다질 수 있습니다. 배운 내용을 퀴즈로 복습하며 자신감을 쌓아보세요! 오늘부터 경제의 첫걸음을 가볍게 시작해 보세요! 😊"
                                        : response["results"]["level"] ==
                                                "INTERMEDIATE"
                                            ? "경제를 이해하고 활용하고자 하는 당신에게 적합한 수준이에요. 중급 단계에서는 경제가 일상 속에서 어떻게 작동하는지 다양한 사례와 함께 배우게 됩니다. 더 나아가, 경제 기사를 읽고 분석하며 복잡한 상황에서도 올바른 결정을 내릴 수 있는 능력을 기를 수 있습니다. 이 단계는 당신이 경제적 통찰력을 키우고 실생활에 적용할 수 있는 중요한 과정이에요. 이제 한층 더 깊이 있는 경제 학습을 시작해보세요!** 💪"
                                            : response["results"]["level"] ==
                                                    "ADVANCED"
                                                ? "이미 탄탄한 경제 지식을 바탕으로 더욱 심화된 학습을 시작할 준비가 되었어요! 고급 단계에서는 복잡한 경제 이론과 글로벌 트렌드를 심도 있게 다루며, 경제적 관점을 확장할 수 있습니다. 경제를 분석하고 깊이 있는 통찰력을 통해 한발 앞서 나가는 힘을 기를 수 있어요. 당신은 이제 경제 분야에서 전문가 수준으로 도약할 수 있는 준비가 되어 있습니다. 오늘부터 심화된 학습으로 경제 지식을 한 단계 더 높여보세요! 🚀"
                                                : "알 수 없음",
                                    style: const TextStyle(
                                      color: Color(0xFF111111),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.50,
                                      letterSpacing: -0.40,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // 하단 그림자
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 20, // 그림자 높이
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                      Colors.white, // 배경색
                                      Colors.white.withOpacity(0), // 투명
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      // 문제 및 해설 버튼
                      GestureDetector(
                        onTap: () {
                          controller.toAnswer(response, answers, quizList);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Palette.buttonColorGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '문제 및 해설',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      // 학습 시작하기 버튼
                      GestureDetector(
                        onTap: () {
                          controller.toProfileSetting();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 32,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Palette.buttonColorBlue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              '학습 시작하기',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 34,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCategoryModal(BuildContext context) {
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
              height: 500,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          '점수 계산 방법',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 18,
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
                  const Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 9, left: 24, right: 24, bottom: 24),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '✔️ 문제 구성 및 점수 배분\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '- 초급(OX 문제, 3개): 각 문제 1점\n- 중급(사지선다 단답, 3개): 각 문제 2점\n- 고급(사지선다 문장 답, 3개): 각 문제 3점\n\t→ 총점: 0~18점\n\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text: '✔️ 단계 구분 기준\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text: '- 초급(Beginner): 0~6점\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '\t\t\t\t- 초급 문제를 모두 맞히지 못하거나 일부만 맞힌 경우.\n\t\t\t\t- 기본 경제 개념 이해가 부족하거나, \n\t\t\t\t\t\t처음 학습 단계에 해당.\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text: '- 중급(Intermediate): 7~12점\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '\t\t\t\t- 초급 문제를 대부분 맞히고 중급 문제를 일부\n\t\t\t\t\t 맞힌 경우.\n\t\t\t\t- 경제의 기본 원리를 이해하며, 특정 주제에 대한 \n\t\t\t\t\t 개념이 존재함.\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text: '- 고급(Advanced): 13~18점\n',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '\t\t\t\t- 중급 문제를 대부분 맞히고 고급 문제도 상당 부분 \n\t\t\t\t\t 맞힌 경우.\n\t\t\t\t- 복잡한 경제 원리와 실생활 적용 능력이 있음.',
                                style: TextStyle(
                                  color: Color(0xFF111111),
                                  fontSize: 16,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.40,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress; // 0.0에서 1.0까지의 값 (진행 비율)

  CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grayPaint = Paint()
      ..color = const Color(0x33111111)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18; // 원의 테두리 두께

    final Paint greenPaint = Paint()
      ..color = const Color(0xFF2BD6D6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18;

    // 원형 차트의 배경 원을 그린다 (회색)
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, grayPaint);

    // 원형 차트의 진행 부분을 그린다 (초록색)
    double sweepAngle = 2 * 3.14159265359 * progress; // 진행 비율에 따라 각도 계산
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -3.14159265359 / 2, // 시작 각도 (위에서 시작)
      sweepAngle, // 진행 각도
      false,
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false; // 차트가 고정적이라 다시 그릴 필요 없음
  }
}
