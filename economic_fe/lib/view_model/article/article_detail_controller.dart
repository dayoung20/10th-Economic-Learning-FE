import 'package:get/get.dart';

class ArticleDetailController extends GetxController {
  // 뒤로 가기
  void goBack() {
    Get.back();
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }
}
