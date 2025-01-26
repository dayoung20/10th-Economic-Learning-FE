import 'package:economic_fe/data/models/article.dart';
import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleListController extends GetxController {
  var selectedSort = "RECENT".obs; //
  var selectedCate = "FINANCE".obs;

  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(String index) {
    // selectedCategoryIndex.value = idx;
    selectedCate.value = index;
  }

  // 인기순 / 최신순 선택 상태 관리
  Rx<int> selectedOrder = 0.obs;

  // 순서 변경
  void selectOrder(int index) {
    selectedOrder.value = index;
  }

  // 기사 리스트 데이터
  List<Article> articles = List.generate(
    10,
    (index) => Article(
      id: index,
      category: '경기 분석',
      headline: '[속보] 기사 제목 $index',
      publisher: '경기일보',
      uploadTime: '4시간 전',
      isBookmarked: false.obs,
      url:
          'https://www.hankookilbo.com/News/Read/A2022022411300004923', // 임시 기사 링크
    ),
  );

  // 기사 세부페이지로 이동
  void toDetailPage(ArticleModel article) {
    Get.to(() => const ArticleDetailPage(), arguments: article);
  }

  // 북마크 상태 토글 메서드
  void toggleBookmark(int articleId) {
    final article = articles.firstWhere((article) => article.id == articleId);
    article.isBookmarked.value = !article.isBookmarked.value;
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  //뉴스 기사 목록 불러오기
  Future<List<ArticleModel>> getNewsList(
      int page, String sort, String? category) async {
    try {
      print("start");
      dynamic response;

      if (category != null) {
        response = await RemoteDataSource.getNewsList(page, sort, category);
        print("n   $response");
      } else if (category == null || selectedCate == "전체") {
        response = await RemoteDataSource.getNewsList(page, sort, null);
        print("n : $response");
      }

      print(response);
      final data = response as Map<String, dynamic>;
      final newsList = data['results']['newsList'] as List;
      // print(newsList);
      print("Ddd");
      print(newsList.map((news) => ArticleModel.fromJson(news)).toList());
      return newsList.map((news) => ArticleModel.fromJson(news)).toList();
      // for (final news in newsList) {
      //   // final title = news['title'];
      //   // print("뉴스 제목 : $title");
      //   ArticleModel.fromJson(news);
      // }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }
}
