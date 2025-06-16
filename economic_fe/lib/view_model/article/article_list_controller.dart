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
  Rx<int> selectedOrder = 0.obs;

  RxList<ArticleModel> newsList = <ArticleModel>[].obs;

  void selectCategory(String index) {
    selectedCate.value = index;
  }

  void selectOrder(int index) {
    selectedOrder.value = index;
  }

  void toDetailPage(ArticleModel article) {
    Get.to(() => const ArticleDetailPage(), arguments: article);
  }

  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  Future<void> getNewsList(int page, String sort, String? category) async {
    try {
      dynamic response;
      if (category == null || category == "전체") {
        response = await remoteDataSource.getNewsList(page, sort, null);
      } else {
        response = await remoteDataSource.getNewsList(page, sort, category);
      }

      final data = response as Map<String, dynamic>;
      final list = data['results']['newsList'] as List;
      newsList.value = list.map((news) => ArticleModel.fromJson(news)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      newsList.clear();
    }
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
