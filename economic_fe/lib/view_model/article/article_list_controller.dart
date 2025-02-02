import 'package:economic_fe/data/models/article.dart';
import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleListController extends GetxController {
  final remoteDataSource = RemoteDataSource();
  var selectedSort = "RECENT".obs;
  var selectedCate = "전체".obs;

  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(String index) {
    selectedCate.value = index;
  }

  // 인기순 / 최신순 선택 상태 관리
  Rx<int> selectedOrder = 0.obs;

  // 순서 변경
  void selectOrder(int index) {
    selectedOrder.value = index;
  }

  // 기사 세부페이지로 이동
  void toDetailPage(ArticleModel article) {
    Get.to(() => const ArticleDetailPage(), arguments: article);
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  //뉴스 기사 목록 불러오기
  Future<List<ArticleModel>> getNewsList(
      int page, String sort, String? category) async {
    // final remoteDataSource = RemoteDataSource();

    try {
      print("start");
      dynamic response;

      if (category != null) {
        response = await remoteDataSource.getNewsList(page, sort, category);
        print("category != null $response");
      } else if (category == null || selectedCate == "전체") {
        response = await remoteDataSource.getNewsList(page, sort, null);
        print("n : $response");
      }

      final data = response as Map<String, dynamic>;
      final newsList = data['results']['newsList'] as List;
      return newsList.map((news) => ArticleModel.fromJson(news)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  // 뉴스 스크랩
  Future<void> postNewsScrap(int id) async {
    try {
      print("start");
      dynamic response;

      response = await RemoteDataSource.postNewsScrap(id);
      print("뉴스 스크랩 : $response");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // 특정 용어 스크랩 취소하기
  Future<void> deleteNewsScrap(int id) async {
    try {
      print("start");

      dynamic response;
      response = await RemoteDataSource.deleteNewsScrap(id);
      print("scrap delete response : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }
}
