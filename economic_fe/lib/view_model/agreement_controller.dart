import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AgreementController extends GetxController {
  late BuildContext context;
  var check = false.obs;
  static AgreementController get to => Get.find();
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  void clickedDetailBtn(BuildContext context) {
    // context.go('/login');
    Get.toNamed('/login/agreement/detail');
  }

  void clickedAllowBtn(BuildContext context) {
    check = true.obs;
    Navigator.pop(context);
  }
}
