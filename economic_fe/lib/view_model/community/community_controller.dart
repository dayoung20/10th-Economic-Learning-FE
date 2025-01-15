import 'package:get/get.dart';

class CommunityController extends GetxController {
  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
  }

  // 인기순 / 최신순 선택 상태 관리
  Rx<int> selectedOrder = 0.obs;

  // 순서 변경
  void selectOrder(int index) {
    selectedOrder.value = index;
  }

  // 플로팅 버튼 클릭 시 옵션 창을 보여주는 상태 관리
  RxBool isModalVisible = false.obs;

  // 옵션 창 표시/숨기기
  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  // 챗봇 화면으로 이동
  void toChatPage() {
    Get.toNamed('/chatbot');
  }

  // 경제톡톡 상세 페이지로 이동
  void toTalkDetailPage() {
    Get.toNamed('/community/talk_detail');
  }
}
