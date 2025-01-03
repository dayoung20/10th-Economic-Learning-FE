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
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 62,
              ),
              _buildLevelButton(
                label: 'Beginner(초급)',
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
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                label: 'Intermediate(중급)',
                isSelected: _selectedLevel == 'Intermediate',
                onTap: () {
                  setState(() {
                    print("Intermediate 클릭");
                    _selectedLevel = 'Intermediate';
                    controller.selectedLevel = _selectedLevel;
                    controller.clickedQuizBtn(context);
                  });
                },
              ),
              const SizedBox(height: 16),
              _buildLevelButton(
                label: 'Advanced(고급)',
                isSelected: _selectedLevel == 'Advanced',
                onTap: () {
                  setState(() {
                    print("advanced 클릭");
                    _selectedLevel = 'Advanced';
                    controller.selectedLevel = _selectedLevel;
                    controller.clickedQuizBtn(context);
                  });
                },
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
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 294,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF1EB692)
              : Colors.white, // 선택 여부에 따라 색상 변경
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 18,
            color:
                isSelected ? Colors.white : Colors.black, // 선택 여부에 따라 텍스트 색상 변경
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
