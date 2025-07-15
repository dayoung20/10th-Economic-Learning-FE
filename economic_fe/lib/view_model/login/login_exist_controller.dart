import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/login/base_login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:io';

class LoginExistController extends BaseLoginController {
  @override
  void onLoginSuccess() async {
    final userInfo = await RemoteDataSource().fetchUserInfoByToken();
    final isProfileSet = userInfo.isNotEmpty;

    if (Platform.isIOS) {
      // iOS는 즉시 라우팅
      Get.offAllNamed(isProfileSet ? '/home' : '/profile_setting');
    } else {
      // Android는 프레임 이후 라우팅
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(isProfileSet ? '/home' : '/profile_setting');
      });
    }
  }
}
