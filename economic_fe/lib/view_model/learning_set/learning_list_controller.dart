import 'package:get/get.dart';

class LearningListController extends GetxController {
  // 각 아이템의 클릭 여부를 저장할 상태 변수
  var selectedItemIndex = (-1).obs; // 초기값으로 -1을 설정하여 아무 것도 선택되지 않음을 나타냄

  // 아이템 클릭 시 선택된 아이템의 인덱스를 업데이트
  void toggleItemSelection(int index) {
    if (selectedItemIndex.value == index) {
      selectedItemIndex.value = -1; // 다시 선택을 취소하면 -1로 초기화
    } else {
      selectedItemIndex.value = index; // 선택된 아이템의 인덱스를 저장
    }
  }
}
