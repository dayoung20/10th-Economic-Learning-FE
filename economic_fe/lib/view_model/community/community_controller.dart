import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  RxBool isModalVisible = false.obs;
  Rx<int> selectedCategoryIndex = 0.obs;
  Rx<int> selectedOrder = 0.obs;
  RxBool isLoading = false.obs;
  var postList = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchPosts(); // 초기 데이터 로드

    // 페이지가 다시 활성화될 때마다 새로고침
    ever(Get.currentRoute.obs, (route) {
      if (route == '/community') {
        fetchPosts();
      }
    });
  }

  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  void toChatPage() {
    Get.toNamed('/chatbot');
  }

  void toTalkDetailPage() {
    Get.toNamed('/community/talk_detail');
  }

  void toDetailPage(int postId) {
    Get.toNamed('/community/detail', arguments: postId);
  }

  void toNewPost() {
    Get.toNamed('/community/new_post');
  }

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

  Future<void> fetchPosts() async {
    isLoading.value = true;
    String sort = selectedOrder.value == 0 ? "POPULAR" : "RECENT";

    try {
      var posts =
          await RemoteDataSource.fetchCategoryPosts(sort, selectedCategoryType);
      postList.assignAll(posts);
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void selectCategory(int index) {
    if (selectedCategoryIndex.value != index) {
      selectedCategoryIndex.value = index;
      fetchPosts();
    }
  }

  void selectOrder(int index) {
    if (selectedOrder.value != index) {
      selectedOrder.value = index;
      fetchPosts();
    }
  }
}
