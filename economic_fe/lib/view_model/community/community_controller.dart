import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/community/detail_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CommunityController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  RxBool isModalVisible = false.obs;
  Rx<int> selectedCategoryIndex = 0.obs;
  Rx<int> selectedOrder = 1.obs;
  Rx<int> selectedTokOrder = 1.obs;
  RxBool isLoading = false.obs;
  RxMap<String, dynamic> todaysTokDetail = <String, dynamic>{}.obs;

  // 일반 게시글용
  var postList = <dynamic>[].obs;
  var currentPostPage = 0.obs;
  var totalPostPage = 1.obs;
  var isFetchingPost = false.obs;

// 경제톡톡 게시글용
  var tokPostList = <dynamic>[].obs;
  var currentTokPage = 0.obs;
  var totalTokPage = 1.obs;
  var isFetchingTok = false.obs;

  @override
  void onInit() {
    super.onInit();

    // 최초 데이터 로딩
    fetchTodaysTok();
    fetchPosts();
    fetchTokPosts();

    // 라우트 복귀 시 새로고침
    ever(Get.currentRoute.obs, (route) {
      if (route == '/community') {
        resetPostList();
        resetTokList();
        fetchTodaysTok();
        fetchPosts();
        fetchTokPosts();
      }
    });
  }

  bool isInitialized = false;

  // @override
  // void onReady() {
  //   super.onReady();
  //   if (!isInitialized) {
  //     fetchPosts();
  //     fetchTokPosts();
  //     fetchTodaysTok();
  //     isInitialized = true;
  //   }
  // }

  void resetPostList() {
    postList.clear();
    currentPostPage.value = 0;
    totalPostPage.value = 1;
  }

  void resetTokList() {
    tokPostList.clear();
    currentTokPage.value = 0;
    totalTokPage.value = 1;
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
    Get.delete<DetailController>(); // 이전 컨트롤러 삭제
    Get.toNamed('/community/detail', arguments: postId); // 새 컨트롤러로 이동
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

  Future<void> fetchPosts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isFetchingPost.value || currentPostPage.value >= totalPostPage.value)
        return;
    }

    if (!isLoadMore) {
      isLoading.value = true;
      resetPostList();
    }

    isFetchingPost.value = true;
    String sort = selectedOrder.value == 0 ? "POPULAR" : "RECENT";
    String type = selectedCategoryType;

    try {
      final results = await remoteDataSource.fetchCategoryPosts(
        page: currentPostPage.value,
        sort: sort,
        type: type,
      );

      if (results["postPreviewList"] != null) {
        postList.addAll(results["postPreviewList"]);
        totalPostPage.value = results["totalPage"] ?? 1;
        currentPostPage.value++;
      }
    } catch (e) {
      debugPrint("Error fetching posts: $e");
    } finally {
      isFetchingPost.value = false;
      isLoading.value = false;
    }
  }

  /// 경제톡톡 목록 조회
  Future<void> fetchTokPosts({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isFetchingTok.value || currentTokPage.value >= totalTokPage.value)
        return;
    }

    if (!isLoadMore) {
      isLoading.value = true;
      resetTokList();
    }

    isFetchingTok.value = true;
    String sort = selectedTokOrder.value == 0 ? "POPULAR" : "RECENT";

    try {
      final results = await remoteDataSource.fetchTokLists(
        page: currentTokPage.value,
        sort: sort,
      );

      if (results["postPreviewList"] != null) {
        tokPostList.addAll(results["postPreviewList"]);
        totalTokPage.value = results["totalPage"] ?? 1;
        currentTokPage.value++;
      }
    } catch (e) {
      debugPrint("Error fetching tokPosts: $e");
    } finally {
      isFetchingTok.value = false;
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
      resetPostList(); // 페이지 초기화 추가
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
