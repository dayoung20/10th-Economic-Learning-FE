import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TestController extends GetxController {
  late BuildContext context;
  static TestController get to => Get.find();
  void getStats() {
    print("Stats initialized!");
  }

  void clickedTestBtn(BuildContext context) {
    Get.toNamed('/test');
  }

  void clickedTestMultiBtn(BuildContext context) {
    Get.toNamed('/test/multi');
  }

  void clickedAfterBtn() {
    Get.toNamed('/login_exist');
  }

  Future<void> getLevelTest() async {
    try {
      print("start");
      final response = await RemoteDataSource.getLevelTest();
      print("response ::: $response");
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
