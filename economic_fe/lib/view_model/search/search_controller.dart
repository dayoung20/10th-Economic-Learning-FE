import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/models/community/post_model.dart';
import 'package:economic_fe/data/models/community/tok_model.dart';
import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  final TextEditingController searchController = TextEditingController();

  var keywords = <String>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var isTextNotEmpty = false.obs;
  var isSearching = false.obs;
  var selectedTabIndex = 0.obs;

  var searchTerms = <DictionaryModel>[].obs;
  var searchPosts = <PostModel>[].obs;
  var searchNews = <ArticleModel>[].obs;
  var searchToks = <TokModel>[].obs;

  // 용어사전 (terms) 페이징 상태
  int currentTermPage = 0;
  bool isTermLastPage = false;

  // 기사 (News) 페이징 상태
  int currentNewsPage = 0;
  bool isNewsLastPage = false;

  // 게시물 (Posts) 페이징 상태
  int currentPostPage = 0;
  bool isPostLastPage = false;

  // 경제톡톡 (Toks) 페이징 상태
  int currentTokPage = 0;
  bool isTokLastPage = false;

  final isTermFetching = false.obs;
  final isNewsFetching = false.obs;
  final isPostFetching = false.obs;
  final isTokFetching = false.obs;

  final List<String> categories = ["통합", "용어사전", "경제 기사", "일반 게시판", "경제 톡톡"];

  @override
  void onInit() {
    super.onInit();
    fetchSearchKeywords();
    searchController.addListener(() {
      isTextNotEmpty.value = searchController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// 검색 실행
  Future<void> search(String keyword) async {
    searchQuery.value = keyword;
    isSearching.value = true;

    // 최근 검색어 목록에 즉시 반영
    if (!keywords.contains(keyword)) {
      keywords.insert(0, keyword);
    }

    // 초기화
    currentTermPage = 1;
    isTermLastPage = false;
    searchTerms.clear();

    currentNewsPage = 1;
    isNewsLastPage = false;
    searchNews.clear();

    currentPostPage = 1;
    isPostLastPage = false;
    searchPosts.clear();

    currentTokPage = 1;
    isTokLastPage = false;
    searchToks.clear();

    // isLoading(true);
    try {
      await Future.wait([
        fetchSearchTermsResults(keyword, currentTermPage),
        fetchSearchPostsResults(keyword, currentPostPage),
        fetchSearchNewsResults(keyword, currentNewsPage),
        fetchSearchToksResults(keyword, currentTokPage),
      ]);
    } catch (e) {
      debugPrint('검색 중 오류 발생: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 탭 선택 변경 시 처리
  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  Future<void> fetchNextTermPage(String keyword) async {
    await fetchSearchTermsResults(keyword, currentTermPage);
  }

  Future<void> fetchNextNewsPage(String keyword) async {
    await fetchSearchNewsResults(keyword, currentNewsPage);
  }

  Future<void> fetchNextPostPage(String keyword) async {
    await fetchSearchPostsResults(keyword, currentPostPage);
  }

  Future<void> fetchNextTokPage(String keyword) async {
    await fetchSearchToksResults(keyword, currentTokPage);
  }

  /// 용어 검색
  Future<void> fetchSearchTermsResults(String keyword, int page) async {
    if (isTermFetching.value || isTermLastPage) return;
    isTermFetching.value = true;

    try {
      final response = await remoteDataSource.searchTermsPaged(keyword, page);
      final List newItems = response['termList'];
      final List<DictionaryModel> models =
          newItems.map((e) => DictionaryModel.fromJson(e)).toList();

      if (models.isEmpty) {
        isTermLastPage = true;
      } else {
        searchTerms.addAll(models);
        currentTermPage++;
      }
    } catch (e) {
      debugPrint("페이징 검색 오류: $e");
    } finally {
      isTermFetching.value = false;
    }
  }

  /// 용어 스크랩 토글
  Future<void> scrapTermToggle(DictionaryModel term) async {
    try {
      if (term.isScraped!) {
        await remoteDataSource.deleteScrap(term.termId!);
      } else {
        await remoteDataSource.postTermsScrap(term.termId!);
      }

      term.isScraped = !term.isScraped!;
      searchTerms.refresh();
    } catch (e) {
      debugPrint("스크랩 토글 중 오류 발생: $e");
    }
  }

  /// 게시판 검색
  Future<void> fetchSearchPostsResults(String keyword, int page) async {
    if (isPostFetching.value || isPostLastPage) return;
    isPostFetching.value = true;

    try {
      final response = await remoteDataSource.searchPostsPaged(keyword, page);
      final List newItems = response['postList'];
      final List<PostModel> models =
          newItems.map((e) => PostModel.fromJson(e)).toList();

      if (models.isEmpty) {
        isPostLastPage = true;
      } else {
        searchPosts.addAll(models);
        currentPostPage++;
      }
    } catch (e) {
      debugPrint('Error fetching posts: $e');
    } finally {
      isPostFetching.value = false;
    }
  }

  /// 경제 뉴스 검색
  Future<void> fetchSearchNewsResults(String keyword, int page) async {
    if (isNewsFetching.value || isNewsLastPage) return;
    isNewsFetching.value = true;

    try {
      final response = await remoteDataSource.searchNewsPaged(keyword, page);
      final List newItems = response['newsList'];
      final List<ArticleModel> models =
          newItems.map((e) => ArticleModel.fromJson(e)).toList();

      if (models.isEmpty) {
        isNewsLastPage = true;
      } else {
        searchNews.addAll(models);
        currentNewsPage++;
      }
    } catch (e) {
      debugPrint('Error fetching articles: $e');
    } finally {
      isNewsFetching.value = false;
    }
  }

  /// 톡톡 게시글 검색
  Future<void> fetchSearchToksResults(String keyword, int page) async {
    if (isTokFetching.value || isTokLastPage) return;
    isTokFetching.value = true;

    try {
      final response = await remoteDataSource.searchTokToksPaged(keyword, page);
      final List newItems = response['tokList'];
      final List<TokModel> models =
          newItems.map((e) => TokModel.fromJson(e)).toList();

      if (models.isEmpty) {
        isTokLastPage = true;
      } else {
        searchToks.addAll(models);
        currentTokPage++;
      }
    } catch (e) {
      debugPrint('Error fetching toktoks: $e');
    } finally {
      isTokFetching.value = false;
    }
  }

  /// 기사 스크랩 토글
  Future<void> scrapNewsToggle(ArticleModel news) async {
    try {
      if (news.isScraped!) {
        await remoteDataSource.deleteNewsScrap(news.id!);
      } else {
        await remoteDataSource.postNewsScrap(news.id!);
      }

      news.isScraped = !news.isScraped!;
      searchNews.refresh();
    } catch (e) {
      debugPrint("스크랩 토글 중 오류 발생: $e");
    }
  }

  /// 최근 검색어 불러오기
  Future<void> fetchSearchKeywords() async {
    isLoading(true);
    try {
      final response = await remoteDataSource.getRecentSearch();
      if (response != null && response['isSuccess']) {
        final searchResults = response['results']['searchKeywords'];
        if (searchResults != null && searchResults is List) {
          keywords.assignAll(
            searchResults
                .map<String>((item) => item['keyword'].toString())
                .toList(),
          );
        }
      } else {
        debugPrint('검색어 데이터가 유효하지 않음');
      }
    } catch (e) {
      debugPrint('Error fetching recent search keywords: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 개별 검색어 삭제
  Future<void> deleteSearchKeyword(String keyword) async {
    bool success = await remoteDataSource.deleteRecentSearch(keyword);
    if (success) {
      keywords.remove(keyword);
    } else {
      debugPrint('검색어 삭제 실패');
    }
  }

  /// 전체 검색어 삭제
  Future<void> deleteSearchKeywordAll() async {
    bool success = await remoteDataSource.deleteRecentSearchAll();
    if (success) {
      keywords.clear();
    } else {
      debugPrint('검색어 전체 삭제 실패');
    }
  }
}
