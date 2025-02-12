import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class AgreementController extends GetxController {
  late BuildContext context;
  final remoteDataSource = RemoteDataSource();

  // 체크박스 상태 관리
  RxBool isCheckedAll = false.obs; // '모두 동의합니다.' 체크 상태
  RxBool isCheckedOne = false.obs; // '리플 서비스 이용 약관' 체크 상태
  RxBool isCheckedTwo = false.obs; // '개인정보 수집・이용 동의' 체크 상태
  RxBool isCheckedThree = false.obs; // '만 14세 이상입니다.' 체크 상태

  static AgreementController get to => Get.find();
  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  // 카카오로 시작하기 화면으로 돌아가기
  void clickedBackBtn() {
    Get.toNamed('/login');
  }

  void clickedDetailBtn(BuildContext context) {
    // context.go('/login');
    Get.toNamed('/login/agreement/detail');
  }

  // 확인 버튼 클릭
  void clickedConfirmBtn(List<LevelTestAnswerModel> answers) async {
    List<Map<String, dynamic>> answersJson =
        answers.map((e) => e.toJson()).toList();

    try {
      print("start");
      dynamic response =
          await remoteDataSource.postLevelTestResult(answersJson);

      print("response : $response");

      // Get.toNamed('/leveltest_result', arguments: response);
      Get.toNamed(
        '/leveltest_result',
        arguments: {
          'response': response,
          'answer': answers,
        },
      );
    } catch (e) {
      debugPrint("error : $e");
    }
  }

  // '모두 동의합니다.' 체크박스를 눌렀을 때의 동작
  void toggleAllCheckbox() {
    if (isCheckedAll.value) {
      isCheckedAll.value = false;
      isCheckedOne.value = false;
      isCheckedTwo.value = false;
      isCheckedThree.value = false;
    } else {
      isCheckedAll.value = true;
      isCheckedOne.value = true;
      isCheckedTwo.value = true;
      isCheckedThree.value = true;
    }
  }

  // 개별 체크박스를 눌렀을 때의 동작
  void toggleOneCheckbox() {
    isCheckedOne.value = !isCheckedOne.value;
    _updateAllCheckboxStatus();
  }

  void toggleTwoCheckbox() {
    isCheckedTwo.value = !isCheckedTwo.value;
    _updateAllCheckboxStatus();
  }

  void toggleThreeCheckbox() {
    isCheckedThree.value = !isCheckedThree.value;
    _updateAllCheckboxStatus();
  }

  // 개별 체크박스 상태에 따라 '모두 동의합니다.' 체크박스 상태를 업데이트
  void _updateAllCheckboxStatus() {
    // 하나라도 체크가 해제되면 isCheckedAll을 해제
    if (!isCheckedOne.value || !isCheckedTwo.value || !isCheckedThree.value) {
      isCheckedAll.value = false;
    } else {
      // 모든 개별 체크박스가 체크되면 isCheckedAll을 체크
      if (isCheckedOne.value && isCheckedTwo.value && isCheckedThree.value) {
        isCheckedAll.value = true;
      }
    }
  }
}
