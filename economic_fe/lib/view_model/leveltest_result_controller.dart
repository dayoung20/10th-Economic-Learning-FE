import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class LevelTestResultController extends GetxController {
  late BuildContext context;
  // 사용자 이름
  var name = '리플'.obs;

  // 레벨 테스트 결과 (영어)
  var level = 'Intermediate'.obs;

  // 레벨 테스트 결과 (한국어)
  var levelKor = '중급'.obs;

  // 맞춘 문제 개수
  var correctNum = 5.obs;

  // 카카오 로그인 화면으로 전환
  void navigateToLogin(BuildContext context) {
    context.go('/login');
  }
}
