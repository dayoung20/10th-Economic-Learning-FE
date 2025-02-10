import 'package:economic_fe/data/models/article.dart';
import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookmarkedArticlesController extends GetxController {
  final remoteDataSource = RemoteDataSource();
  var scrapNews = <ArticleModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchScrapedNews();
  }

  // 스크랩한 기사 목록 조회
  Future<void> fetchScrapedNews() async {
    debugPrint("fetchScrapedNews() 실행됨");
    try {
      var news = await remoteDataSource.fetchScrapedNews();
      scrapNews
          .assignAll(news.map((json) => ArticleModel.fromJson(json)).toList());
      debugPrint("fetchScrapedNews() 완료, 데이터 개수: ${scrapNews.length}");
    } catch (e) {
      debugPrint("Error fetching news: $e");
    }
  }

  // 기사 스크랩 삭제
  Future<void> deleteScrapedNews(int id) async {
    debugPrint("deleteScrapedNews() 실행됨");
    try {
      var response = await remoteDataSource.deleteNewsScrap(id);
      if (response) {
        debugPrint("뉴스 스크랩 삭제 완료");
        scrapNews.removeWhere((article) => article.id == id);
      }
    } catch (e) {
      debugPrint("뉴스 스크랩 삭제 실패: $e");
    }
  }

  // 기사 세부페이지로 이동
  void toDetailPage(ArticleModel article) {
    Get.to(() => const ArticleDetailPage(), arguments: article);
  }
}
