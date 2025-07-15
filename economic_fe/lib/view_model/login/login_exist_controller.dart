import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/login/base_login_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginExistController extends BaseLoginController {
  @override
  void onLoginSuccess() async {
    final userInfo = await RemoteDataSource().fetchUserInfoByToken();
    final isProfileSet = userInfo.isNotEmpty;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.offAllNamed(isProfileSet ? '/home' : '/profile_setting');
    });
  }
}
