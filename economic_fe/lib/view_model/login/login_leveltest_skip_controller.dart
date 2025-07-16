import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/login/base_login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';

class LoginLevelTestSkipController extends BaseLoginController {
  @override
  void onLoginSuccess() async {
    await RemoteDataSource().fetchUserInfoByToken();

    if (Platform.isIOS) {
      Get.offAllNamed("/login/agreement", arguments: {'from': 'skip'});
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed("/login/agreement", arguments: {'from': 'skip'});
      });
    }
  }
}
