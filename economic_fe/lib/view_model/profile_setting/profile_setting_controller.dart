import 'dart:developer';

import 'package:economic_fe/view_model/profile_setting/basic_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class ProfileSettingController extends GetxController {
  late BuildContext context;

  // 저장하기 버튼이 클릭되었는지 확인하는 값
  var saveButtonClicked = false.obs;

  // 기본 정보 설정 화면으로 전환
  void navigateToBasic(BuildContext context) {
    context.go('/profile_setting/basic');
  }

  // 저장하기 버튼 클릭 여부를 업데이트하는 메서드
  void updateSaveButtonClicked() {
    // Get.find로 이미 생성된 BasicController 인스턴스를 가져옴
    saveButtonClicked.value =
        Get.find<BasicController>().saveButtonClicked.value;
    log('${saveButtonClicked.value}');
  }
}
