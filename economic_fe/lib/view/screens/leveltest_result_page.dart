import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/leveltest_result_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeveltestResultPage extends StatelessWidget {
  const LeveltestResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final LevelTestResultController controller =
        Get.put(LevelTestResultController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
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
                Stack(
                  alignment: Alignment.center, // Stack 내 위젯을 중앙에 배치
                  children: [
                    CustomPaint(
                      size: const Size(155, 155), // 원형 차트의 크기
                      painter: CirclePainter(progress: 3 / 18), // 점수 / 총점(18)
                    ),
                    // 원형 차트의 중앙에 텍스트 추가
                    const Column(
                      children: [
                        Text(
                          '내 레벨',
                          style: TextStyle(
                            color: Color(0xFFA2A2A2),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.20,
                            letterSpacing: -0.35,
                          ),
                        ),
                        SizedBox(
                          height: 9,
                        ),
                        // 레벨
                        Text(
                          '초급',
                          style: TextStyle(
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
                  onTap: controller.showModal, // 모달창 열기
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                          const SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 레벨에 따른 텍스트 변경 필요
                                Text(
                                  '축하합니다! 🎉\n당신은 초급 단계입니다!',
                                  style: TextStyle(
                                    color: Color(0xFF111111),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    height: 1.50,
                                    letterSpacing: -0.50,
                                  ),
                                ),
                                SizedBox(
                                  height: 19,
                                ),
                                Text(
                                  '경제를 처음 시작하려는 당신에게 딱 맞는 학습이 준비되어 있어요.\n\n초급 단계에서는 어렵고 복잡하게 느껴질 수 있는 경제를 친근하게 다가갈 수 있도록 구성했어요. 기초적인 용어와 개념부터 차근차근 배우면서 경제의 기본기를 탄탄히 다질 수 있습니다.\n\n배운 내용을 퀴즈로 복습하며 자신감을 쌓아보세요! 오늘부터 경제의 첫걸음을 가볍게 시작해 보세요! 😊',
                                  style: TextStyle(
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
                    // 문제 및 해설 버튼
                    GestureDetector(
                      onTap: () {
                        controller.toAnswer();
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
                        controller.toHome();
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
          // 모달창
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
                                            onTap: controller.hideModal,
                                            child: const Icon(
                                              Icons.close,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 9,
                                          left: 24,
                                          right: 24,
                                          bottom: 24),
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
                                              text:
                                                  '- 중급(Intermediate): 7~12점\n',
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
                                                fontFamily:
                                                    'Pretendard Variable',
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                                letterSpacing: -0.40,
                                              ),
                                            ),
                                          ],
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
