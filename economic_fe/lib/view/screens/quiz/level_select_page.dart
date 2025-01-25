import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/onboarding_card_controller.dart';
import 'package:economic_fe/view_model/quiz/level_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LevelSelectPage extends StatefulWidget {
  const LevelSelectPage({super.key});

  @override
  State<LevelSelectPage> createState() => _LevelSelectPageState();
}

class _LevelSelectPageState extends State<LevelSelectPage> {
  late final LevelSelectController controller;

  String _selectedLevel = ''; // 선택된 레벨을 저장할 변수

  @override
  void initState() {
    super.initState();
    controller = Get.put(LevelSelectController()..getStats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const CustomAppBar(
        title: "레벨선택",
        icon: Icons.arrow_back_ios_new,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 62,
              ),
              _buildLevelButton(
                label: '초급',
                isSelected: _selectedLevel == 'Beginner',
                onTap: () {
                  setState(() {
                    print("Beginner 클릭");
                    _selectedLevel = 'Beginner';
                    controller.selectedLevel = _selectedLevel;
                    controller.clickedQuizBtn(context);
                    // print(controller.selectedLevel);
                  });
                },
                isCompleted: true,
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                label: '중급',
                isSelected: _selectedLevel == 'Intermediate',
                onTap: () {
                  setState(() {
                    print("Intermediate 클릭");
                    _selectedLevel = 'Intermediate';
                    controller.selectedLevel = _selectedLevel;
                    controller.clickedQuizBtn(context);
                  });
                },
                isCompleted: false,
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                label: '고급',
                isSelected: _selectedLevel == 'Advanced',
                onTap: () {
                  setState(() {
                    print("advanced 클릭");
                    _selectedLevel = 'Advanced';
                    controller.selectedLevel = _selectedLevel;
                    controller.clickedQuizBtn(context);
                  });
                },
                isCompleted: false,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLevelButton({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required bool isCompleted,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 64,
        padding: const EdgeInsets.all(24),
        decoration: ShapeDecoration(
          color: isSelected ? Palette.buttonColorGreen : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected
                  ? Palette.buttonColorGreen
                  : const Color(0xFFD9D9D9),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF111111),
                fontSize: 20,
                fontWeight: FontWeight.w500,
                height: 1.50,
                letterSpacing: -0.50,
              ),
            ),
            Icon(
              isCompleted ? Icons.check_circle : Icons.check_circle_outline,
              color: isCompleted
                  ? Palette.buttonColorGreen
                  : const Color(0xffa2a2a2),
            )
          ],
        ),
      ),
    );
  }
}
