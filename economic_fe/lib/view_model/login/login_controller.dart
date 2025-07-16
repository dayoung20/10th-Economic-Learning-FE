import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/data/storage/level_test_storage.dart';
import 'package:economic_fe/view_model/login/base_login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';

class LoginController extends BaseLoginController {
  @override
  Future<void> onLoginSuccess() async {
    await RemoteDataSource().fetchUserInfoByToken();

    final (answers, quizList) = await LevelTestStorage.loadLevelTestData();

    print('[onLoginSuccess] 불러온 answers: $answers');
    print('[onLoginSuccess] 불러온 quizList: $quizList');

    if (Platform.isIOS) {
      Get.offAllNamed('/login/agreement', arguments: {
        'from': 'login',
        'levelTestAnswers': answers,
        'quizList': quizList,
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/login/agreement', arguments: {
          'from': 'login',
          'levelTestAnswers': answers,
          'quizList': quizList,
        });
      });
    }
  }
}
