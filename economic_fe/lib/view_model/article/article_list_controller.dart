import 'package:economic_fe/data/models/article.dart';
import 'package:get/get.dart';

class ArticleListController extends GetxController {
  // 현재 선택된 카테고리 인덱스
  Rx<int> selectedCategoryIndex = 0.obs;

  // 카테고리 탭 클릭 시 선택된 카테고리 인덱스 업데이트
  void selectCategory(int index) {
    selectedCategoryIndex.value = index;
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
      isBookmarked: false.obs, // 북마크 상태를 관리
    ),
  );

  // 북마크 상태 토글 메서드
  void toggleBookmark(int articleId) {
    final article = articles.firstWhere((article) => article.id == articleId);
    article.isBookmarked.value = !article.isBookmarked.value;
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }
}
