import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  // // 현재 선택된 카테고리 인덱스
  // Rx<int> selectedCategoryIndex = 0.obs;

  // // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  // void selectCategory(int index) {
  //   selectedCategoryIndex.value = index;
  // }

  // // 인기순 / 최신순 선택 상태 관리
  // Rx<int> selectedOrder = 0.obs;

  // // 순서 변경
  // void selectOrder(int index) {
  //   selectedOrder.value = index;
  // }

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

  // 일반 게시판 상세 페이지로 이동
  void toDetailPage() {
    Get.toNamed('/community/detail');
  }

  // 글쓰기 화면으로 이동
  void toNewPost() {
    Get.toNamed('/community/new_post');
  }

  // 게시글 목록 저장
  var postList = <dynamic>[].obs;

  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 인기순/최신순 선택 상태 관리
  Rx<int> selectedOrder = 0.obs;

  // 데이터 불러오기 상태
  RxBool isLoading = false.obs;

  // API에서 받아올 카테고리 타입
  String get selectedCategoryType {
    List<String> categoryTypes = [
      "ALL",
      "FREE",
      "QUESTION",
      "BOOK_RECOMMENDATION",
      "INFORMATION"
    ];
    return categoryTypes[selectedCategoryIndex.value];
  }

  // 게시글 목록 가져오기
  Future<void> fetchPosts() async {
    isLoading.value = true;

    // 선택된 정렬 방식 (인기순/최신순)
    String sort = selectedOrder.value == 0 ? "POPULAR" : "RECENT";

    // API 호출
    var posts =
        await RemoteDataSource.fetchAllPosts(sort, selectedCategoryType);

    postList.assignAll(posts);
    isLoading.value = false;
  }

  // 카테고리 선택
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
    fetchPosts();
  }

  // 정렬 순서 변경
  void selectOrder(int index) {
    selectedOrder.value = index;
    fetchPosts();
  }
}
