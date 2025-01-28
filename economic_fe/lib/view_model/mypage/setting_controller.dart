import 'package:get/get.dart';

class SettingController extends GetxController {
  // 알림 토글 관리
  var isToggled = true.obs;

  void toggle() {
    isToggled.value = !isToggled.value;
  }
}
