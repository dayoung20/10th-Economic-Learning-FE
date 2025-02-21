import 'package:economic_fe/view/widgets/finish_layout.dart';
import 'package:economic_fe/view_model/finish/finish_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FinishPageController controller = Get.put(FinishPageController());

    final arguments = Get.arguments as Map<String, dynamic>;
    final contents = arguments['contents'];
    final number = arguments['number'];
    final category = arguments['category'];
    final level = arguments['level'];
    final isQuiz = arguments['isQuiz'] ?? false;
    controller.isQuiz.value = isQuiz;

    return Obx(() {
      if (controller.isLoading.value) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      }

      if (controller.shouldShowFinishLayout.value) {
        return FinishLayout(
          contents: contents,
          number: number,
          category: category,
          level: level,
        );
      } else if (isQuiz) {
        return FinishLayout(
          contents: contents,
          number: number,
          category: category,
          level: level,
        );
      } else {
        // 모든 학습이 완료되었을 경우 다른 화면으로 이동
        return Scaffold(
          backgroundColor: const Color(0xffDEF7F1),
          appBar: AppBar(
            forceMaterialTransparency: true,
            automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () => Get.toNamed('/home'),
              child: const Icon(Icons.close),
            ),
          ),
          body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/finish_icon.png',
                  width: 80,
                ),
                const SizedBox(
                  height: 17,
                ),
                const Text(
                  '일일 퀘스트가 완료되었어요.\n정말 대단해요!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.45,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    });
  }
}
