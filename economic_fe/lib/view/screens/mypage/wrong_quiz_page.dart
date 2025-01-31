import 'package:economic_fe/view/screens/quiz/quiz_page.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/mypage/level_container.dart';
import 'package:economic_fe/view_model/mypage/wrong_quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WrongQuizPage extends StatefulWidget {
  const WrongQuizPage({super.key});

  @override
  State<WrongQuizPage> createState() => _WrongQuizPageState();
}

class _WrongQuizPageState extends State<WrongQuizPage> {
  final WrongQuizController controller = Get.put(WrongQuizController());

  void initState() {
    super.initState();
    controller.fetchIncorrectQuestions(); // 초기 데이터 로드
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '틀린 문제 다시 풀기',
        icon: Icons.arrow_back_ios_new,
        onPress: () => Get.back(),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 22, left: 15),
            child: Row(
              children: [
                Obx(
                  () => LevelContainer(
                    level: '초급',
                    isSelected: controller.selectedLevel.value == 'BEGINNER',
                    onTap: () => controller.updateSelectedLevel('초급'),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => LevelContainer(
                    level: '중급',
                    isSelected:
                        controller.selectedLevel.value == 'INTERMEDIATE',
                    onTap: () => controller.updateSelectedLevel('중급'),
                  ),
                ),
                const SizedBox(width: 8),
                Obx(
                  () => LevelContainer(
                    level: '고급',
                    isSelected: controller.selectedLevel.value == 'ADVANCED',
                    onTap: () => controller.updateSelectedLevel('고급'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          // 버튼
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: GestureDetector(
              onTap: () {
                // 버튼 클릭 시 동작
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Text(
                        '틀린 모든 문제 다시 풀기',
                        style: TextStyle(
                          color: Color(0xFF067BD5),
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          height: 1.40,
                          letterSpacing: -0.35,
                        ),
                      ),
                      SizedBox(width: 3),
                      Icon(
                        Icons.arrow_circle_right,
                        color: Color(0xff067bd5),
                        size: 15,
                      ),
                    ],
                  ),
                  Container(
                    width: 158,
                    height: 1,
                    color: const Color(0xff067bd5),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          // 탭별 데이터 리스트
          Expanded(
            child: Obx(
              () => controller.incorrectQuestions.isEmpty
                  ? const Text('틀린 문제가 없습니다.')
                  : ListView.builder(
                      itemCount: controller.incorrectQuestions.length,
                      itemBuilder: (context, index) {
                        final item = controller.incorrectQuestions[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              // 개별 퀴즈 화면으로 이동
                              Get.to(
                                const QuizPage(),
                                arguments: {
                                  'quizId': item['id'],
                                }, // 전달할 quizId
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFD9D9D9),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['category']!,
                                    style: const TextStyle(
                                      color: Color(0xFF767676),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    item['title']!,
                                    style: const TextStyle(
                                      color: Color(0xFF404040),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
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
  }
}
