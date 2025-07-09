import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ArticleListController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  var selectedSort = "RECENT".obs;
  var selectedCate = "전체".obs;
  Rx<int> selectedCategoryIndex = 0.obs;
  Rx<int> selectedOrder = 1.obs;

  // 페이징 상태
  var currentPage = 0.obs;
  var totalPage = 1.obs;
  var isLoading = false.obs;
  var isFetchingMore = false.obs;

  RxList<ArticleModel> newsList = <ArticleModel>[].obs;

  // 페이징 초기화
  void resetPaging() {
    currentPage.value = 0;
    totalPage.value = 1;
    newsList.clear();
  }

  void selectCategory(String index) {
    selectedCate.value = index;
  }

  void selectOrder(int index) {
    selectedOrder.value = index;
    selectedSort.value = selectedOrder.value == 0 ? "POPULAR" : "RECENT";
  }

  void toDetailPage(ArticleModel article) {
    Get.to(() => const ArticleDetailPage(), arguments: article);
  }

  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  /// 첫 페이지 로딩
  Future<void> fetchNewsInitial(int page, String sort, String? category) async {
    resetPaging();
    await getNewsList(page, sort, category);
  }

  Future<void> getNewsList(int page, String sort, String? category) async {
    try {
      isLoading.value = page == 1;
      isFetchingMore.value = page != 1;

      dynamic response = await remoteDataSource.getNewsList(
          page, sort, category == "전체" ? null : category);

      final data = response as Map<String, dynamic>;
      final list = data['results']['newsList'] as List;
      final total = data['results']['totalPage'] as int;

      final articles = list.map((news) => ArticleModel.fromJson(news)).toList();

      if (page == 1) {
        newsList.value = articles;
      } else {
        newsList.addAll(articles);
      }

      totalPage.value = total;
      currentPage.value = page;
    } catch (e) {
      debugPrint('getNewsList Error: $e');
      if (page == 1) newsList.clear();
    } finally {
      isLoading.value = false;
      isFetchingMore.value = false;
    }
  }

  Future<void> loadMoreIfNeeded() async {
    if (isFetchingMore.value || currentPage.value >= totalPage.value) return;

    await getNewsList(currentPage.value + 1, selectedSort.value,
        selectedCate.value == "전체" ? null : selectedCate.value);
  }

  Future<void> postNewsScrap(int id, {ArticleModel? article}) async {
    try {
      final response = await remoteDataSource.postNewsScrap(id);
      if (response == true && article != null) {
        article.isScraped = true;
        newsList.refresh(); // 상태 갱신
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> deleteNewsScrap(int id, {ArticleModel? article}) async {
    try {
      final response = await remoteDataSource.deleteNewsScrap(id);
      if (response == true && article != null) {
        article.isScraped = false;
        newsList.refresh();
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  Future<void> getNewsDetail(int id) async {
    try {
      final response = await remoteDataSource.getNewsDetail(id);
      print("getNewsDetail response : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }
}
