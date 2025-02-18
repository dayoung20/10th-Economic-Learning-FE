import 'dart:convert';

import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class QuizTestController extends GetxController {
  late BuildContext context;
  final remoteDataSource = RemoteDataSource();
  QuizTestController get to => Get.find();

  var learningSetId = 0.obs; // 학습 세트 ID
  var conceptName = "개념 학습".obs;
  var level = "BEGINNER".obs;

  void getStats() {
    print("Stats initialized!");
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      learningSetId.value = Get.arguments?["learningSetId"] ?? 0;
      conceptName.value = Get.arguments?["name"] ?? "개념 학습";
      level.value = Get.arguments?["level"] ?? "BEGINNER";
    }
  }
}
