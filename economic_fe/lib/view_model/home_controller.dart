import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class HomeController extends GetxController {
  // 전체 학습 세트 목록 화면으로 전환
  void navigateToLearningList(BuildContext context) {
    context.go('/learning_list');
  }
}
