import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPageController extends GetxController {
  final RemoteDataSource remoteDataSource = RemoteDataSource();

  var keywords = <String>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchSearchKeywords();
  }

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
