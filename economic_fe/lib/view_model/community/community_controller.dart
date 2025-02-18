import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  RxBool isModalVisible = false.obs;
  Rx<int> selectedCategoryIndex = 0.obs;
  Rx<int> selectedOrder = 0.obs;
  Rx<int> selectedTokOrder = 0.obs;
  RxBool isLoading = false.obs;
  var postList = <dynamic>[].obs;
  var tokPostList = <dynamic>[].obs;
  RxMap<String, dynamic> todaysTokDetail = <String, dynamic>{}.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTodaysTok();
    fetchPosts(); // 초기 데이터 로드
    fetchTokPosts();

    // 페이지가 다시 활성화될 때마다 새로고침
    ever(Get.currentRoute.obs, (route) {
      if (route == '/community') {
        fetchTodaysTok();
        fetchPosts();
        fetchTokPosts();
      }
    });
  }

  void toggleModal() {
    isModalVisible.value = !isModalVisible.value;
  }

  void toChatPage() {
    Get.toNamed('/chatbot');
  }

  void toTalkDetailPage(int tokPostId) {
    Get.toNamed('/community/talk_detail', arguments: tokPostId);
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
          await remoteDataSource.fetchCategoryPosts(sort, selectedCategoryType);
      postList.assignAll(posts);
    } catch (e) {
      print("Error fetching posts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 경제톡톡 목록 조회
  Future<void> fetchTokPosts() async {
    isLoading.value = true;
    String sort = selectedOrder.value == 0 ? "POPULAR" : "RECENT";

    try {
      var tokPosts = await remoteDataSource.fetchTokLists(sort);
      tokPostList.assignAll(tokPosts);
    } catch (e) {
      print("Error fetching tokPosts: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 오늘의 경제톡톡 주제 조회
  Future<void> fetchTodaysTok() async {
    try {
      isLoading(true);
      final todaysTok = await remoteDataSource.getTodaysTok();

      if (todaysTok != null) {
        todaysTokDetail.value = todaysTok;
      }
    } catch (e) {
      print('오늘의 경제톡톡 주제 조회 중 오류 발생: $e');
    } finally {
      isLoading(false);
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

  void selectTokOrder(int index) {
    if (selectedTokOrder.value != index) {
      selectedTokOrder.value = index;
      fetchTokPosts();
    }
  }
}
