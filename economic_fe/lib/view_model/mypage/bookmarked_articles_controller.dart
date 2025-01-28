import 'package:economic_fe/data/models/article.dart';
import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:get/get.dart';

class BookmarkedArticlesController extends GetxController {
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
}
