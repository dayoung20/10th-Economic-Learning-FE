import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/models/community/post_model.dart';
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

    isLoading(true);
    try {
      await Future.wait([
        fetchSearchTermsResults(keyword),
        fetchSearchPostsResults(keyword),
        fetchSearchNewsResults(keyword),
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

  /// 용어 검색
  Future<void> fetchSearchTermsResults(String keyword) async {
    isLoading(true);
    try {
      final response = await remoteDataSource.searchTerms(keyword);
      searchTerms.assignAll(
          response.map((json) => DictionaryModel.fromJson(json)).toList());
    } catch (e) {
      debugPrint('Error fetching terms: $e');
    } finally {
      isLoading(false);
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
  Future<void> fetchSearchPostsResults(String keyword) async {
    isLoading(true);
    try {
      final response = await remoteDataSource.searchPosts(keyword);
      searchPosts
          .assignAll(response.map((json) => PostModel.fromJson(json)).toList());
    } catch (e) {
      debugPrint('Error fetching posts: $e');
    } finally {
      isLoading(false);
    }
  }

  /// 경제 뉴스 검색
  Future<void> fetchSearchNewsResults(String keyword) async {
    isLoading(true);
    try {
      final response = await remoteDataSource.searchNews(keyword);
      searchNews.assignAll(
          response.map((json) => ArticleModel.fromJson(json)).toList());
    } catch (e) {
      debugPrint('Error fetching articles: $e');
    } finally {
      isLoading(false);
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
