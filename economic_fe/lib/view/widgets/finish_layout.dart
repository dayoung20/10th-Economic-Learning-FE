import 'package:economic_fe/view/widgets/stop_option_modal.dart';
import 'package:economic_fe/view_model/finish/finish_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FinishLayout extends StatelessWidget {
  final String contents;
  final String level;
  final int number;
  final int category; // 0 => 학습 / 1 => 퀴즈

  const FinishLayout({
    super.key,
    required this.contents,
    required this.number,
    required this.category,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final FinishController controller = Get.put(FinishController());

    return Scaffold(
      backgroundColor: const Color(0xffDEF7F1),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            child: Padding(
              padding: EdgeInsets.only(top: 54.h, left: 16.w),
              child: GestureDetector(
                onTap: () => Get.toNamed('/home'),
                child: const Icon(Icons.close),
              ),
            ),
          ),
          Positioned(
            top: 300.h,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/icon.png',
                    width: 65.34.w,
                    height: 77.87.h,
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            width: 1.w, color: const Color(0xFFA2A2A2)),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      '$contents - $level',
                      style: TextStyle(
                        color: const Color(0xFF767676),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 17.h,
                  ),
                  // 서버에서 가져온 학습/퀴즈 완료 갯수 적용
                  Obx(() {
                    int completedCount = category == 0
                        ? controller.totalConceptCompletedCount.value
                        : controller.quizCount.value;

                    return Text(
                      category == 0
                          ? '$completedCount번째 학습 완료'
                          : '$completedCount번째 퀴즈 완료',
                      style: TextStyle(
                        color: const Color(0xFF111111),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.45,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          StopOptionModal(
            closeModal: () {},
            isFinishPage: true,
            contents: category == 0
                ? '오늘 공부한 $contents에 대한\n경제 퀴즈를 풀어볼까요?'
                : '퀴즈를 풀었으니 이번엔\n경제 기사를 읽으며 학습해볼까요?',
            keepBtnText: '오늘은 그만할래요',
            stopBtnText: category == 0 ? '지금 바로 풀어볼게요!' : '지금 바로 읽어볼게요!',
            keepFunc: () => controller.toLearningList(),
            stopFunc: () =>
                category == 0 ? controller.toQuiz() : controller.toArticle(),
          ),
        ],
      ),
    );
  }
}
