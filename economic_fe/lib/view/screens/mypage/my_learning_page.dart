import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/mypage/level_container.dart';
import 'package:economic_fe/view/widgets/word_list_view.dart';
import 'package:economic_fe/view_model/mypage/my_learning_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLearningPage extends StatefulWidget {
  const MyLearningPage({super.key});

  @override
  State<MyLearningPage> createState() => _MyLearningPageState();
}

class _MyLearningPageState extends State<MyLearningPage> {
  final MyLearningController controller = Get.put(MyLearningController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '나의 학습',
        icon: Icons.arrow_back_ios_new,
        onPress: () => Get.back(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Column(
          children: [
            Container(
              height: 1,
              color: Colors.black,
            ),
            // 탭바
            Container(
              color: Colors.white,
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: const Color(0xff767676),
                indicatorColor: Colors.black,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: '스크랩 한 퀴즈'),
                  Tab(text: '스크랩 한 학습'),
                  Tab(text: '스크랩 한 단어'),
                ],
              ),
            ),
            // 탭 컨텐츠
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  // 스크랩 한 퀴즈 화면
                  _buildScrapQuizzesTab(controller),
                  // 스크랩 한 학습 화면
                  _buildScrapLearningTab(controller),
                  // 스크랩 한 단어 화면
                  WordListView(controller: controller),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _buildScrapQuizzesTab(MyLearningController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 22, left: 15),
        child: Row(
          children: [
            Obx(
              () => LevelContainer(
                level: '초급',
                isSelected: controller.selectedLevel.value == 'BEGINNER',
                onTap: () {
                  controller.updateSelectedLevel('BEGINNER');
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => LevelContainer(
                level: '중급',
                isSelected: controller.selectedLevel.value == 'INTERMEDIATE',
                onTap: () {
                  controller.updateSelectedLevel('INTERMEDIATE');
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => LevelContainer(
                level: '고급',
                isSelected: controller.selectedLevel.value == 'ADVANCED',
                onTap: () {
                  controller.updateSelectedLevel('ADVANCED');
                },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      // 스크랩 한 모든 학습 다시 보기 버튼
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            // "스크랩 한 모든 학습 다시 보기" 버튼 동작 추가 가능
          },
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.buttonText.value,
                      style: const TextStyle(
                        color: Color(0xFF067BD5),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                        letterSpacing: -0.35,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.arrow_circle_right,
                      color: Color(0xff067bd5),
                      size: 15,
                    ),
                  ],
                ),
                Container(
                  width: 185,
                  height: 1,
                  color: const Color(0xff067bd5),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      // 학습 리스트
      Expanded(
        child: Obx(() {
          if (controller.scrapQuizzes.isEmpty) {
            return const Center(
              child: Text(
                '데이터가 없습니다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF767676),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.scrapQuizzes.length,
            itemBuilder: (context, index) {
              final quiz = controller.scrapQuizzes[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            quiz['learningSetName'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            quiz['quizName'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.bookmark,
                          color: Palette.buttonColorGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    ],
  );
}

Widget _buildScrapLearningTab(MyLearningController controller) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.only(top: 22, left: 15),
        child: Row(
          children: [
            Obx(
              () => LevelContainer(
                level: '초급',
                isSelected: controller.selectedLevel.value == 'BEGINNER',
                onTap: () {
                  controller.updateSelectedLevel('BEGINNER');
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => LevelContainer(
                level: '중급',
                isSelected: controller.selectedLevel.value == 'INTERMEDIATE',
                onTap: () {
                  controller.updateSelectedLevel('INTERMEDIATE');
                },
              ),
            ),
            const SizedBox(width: 8),
            Obx(
              () => LevelContainer(
                level: '고급',
                isSelected: controller.selectedLevel.value == 'ADVANCED',
                onTap: () {
                  controller.updateSelectedLevel('ADVANCED');
                },
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 18),
      // 스크랩 한 모든 학습 다시 보기 버튼
      Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            // "스크랩 한 모든 학습 다시 보기" 버튼 동작 추가 가능
          },
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      controller.buttonText.value,
                      style: const TextStyle(
                        color: Color(0xFF067BD5),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 1.40,
                        letterSpacing: -0.35,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.arrow_circle_right,
                      color: Color(0xff067bd5),
                      size: 15,
                    ),
                  ],
                ),
                Container(
                  width: 185,
                  height: 1,
                  color: const Color(0xff067bd5),
                ),
              ],
            ),
          ),
        ),
      ),
      const SizedBox(height: 15),
      // 학습 리스트
      Expanded(
        child: Obx(() {
          if (controller.scrapConcepts.isEmpty) {
            return const Center(
              child: Text(
                '데이터가 없습니다.',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF767676),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.scrapConcepts.length,
            itemBuilder: (context, index) {
              final concept = controller.scrapConcepts[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            concept['LearningSetName'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            concept['name'] ?? '',
                            style: const TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: const Icon(
                          Icons.bookmark,
                          color: Palette.buttonColorGreen,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }),
      ),
    ],
  );
}
