import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
        child: CustomButton(
            text: '학습 세트 목록 (임시)',
            onPress: () {
              controller.navigateToLearningList(context);
            },
            bgColor: Palette.buttonColorBlue),
      ),
    );
  }
}
