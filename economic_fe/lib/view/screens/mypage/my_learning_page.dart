import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
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
                tabs: const [
                  Tab(text: '스크랩 한 퀴즈'),
                  Tab(text: '스크랩 한 학습'),
                  Tab(text: '틀린 문제'),
                ],
              ),
            ),
            // 레벨 선택
            Padding(
              padding: const EdgeInsets.only(top: 22, left: 15),
              child: Row(
                children: [
                  Obx(
                    () => LevelContainer(
                      level: '초급',
                      isSelected: controller.selectedLevel.value == '초급',
                      onTap: () => controller.updateSelectedLevel('초급'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(
                    () => LevelContainer(
                      level: '중급',
                      isSelected: controller.selectedLevel.value == '중급',
                      onTap: () => controller.updateSelectedLevel('중급'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Obx(
                    () => LevelContainer(
                      level: '고급',
                      isSelected: controller.selectedLevel.value == '고급',
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
                        width: controller.buttonText.value == '틀린 모든 문제 다시 풀기'
                            ? 158
                            : 185,
                        height: 1,
                        color: const Color(0xff067bd5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // 탭별 데이터 리스트
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemCount: controller.currentData.length,
                  itemBuilder: (context, index) {
                    final item = controller.currentData[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
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
                                  item['category']!,
                                  style: const TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                const SizedBox(height: 8),
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
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LevelContainer extends StatelessWidget {
  final String level;
  final bool isSelected;
  final Function() onTap;

  const LevelContainer({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF1DB691) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isSelected
                    ? Palette.buttonColorGreen
                    : const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          level,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xffa2a2a2),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.50,
            letterSpacing: -0.35,
          ),
        ),
      ),
    );
  }
}
