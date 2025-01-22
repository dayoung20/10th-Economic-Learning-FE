import 'package:economic_fe/view/widgets/finish_layout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FinishPage extends StatelessWidget {
  const FinishPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final contents = arguments['contents'];
    final number = arguments['number'];
    final category = arguments['category'];
    final level = arguments['level'];

    return FinishLayout(
      contents: contents,
      number: number,
      category: category,
      level: level,
    );
  }
}
