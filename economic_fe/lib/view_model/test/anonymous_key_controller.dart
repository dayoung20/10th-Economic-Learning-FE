import 'package:get/get.dart';

class AnonymousKeyController extends GetxController {
  RxString anonymousKey = ''.obs;

  void setKey(String key) {
    anonymousKey.value = key;
  }

  String get key => anonymousKey.value;
}
