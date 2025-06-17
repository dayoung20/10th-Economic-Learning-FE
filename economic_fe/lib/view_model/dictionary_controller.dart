import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryController extends GetxController {
  final remoteDataSource = RemoteDataSource();

  // UI 상태
  var selectedConsonant = "ㄱ".obs;
  var keyword = "".obs;
  var typeValue = true.obs; // true: 자음 선택, false: 키워드 검색

  // 데이터 상태
  var dictionaryList = <DictionaryModel>[].obs;
  var isLoading = false.obs;

  void getStats() {
    print("Stats initialized!");
  }

  /// 자음 또는 키워드에 따른 용어 데이터 불러오기
  Future<void> fetchDictionary(int page, String text, bool type) async {
    try {
      isLoading.value = true;

      dynamic response;
      if (type) {
        // 자음 기준 검색
        response = await remoteDataSource.getDictionary(page, text);
      } else {
        // 키워드 기준 검색
        response = await remoteDataSource.getKewordResult(page, text);
      }

      final data = response as Map<String, dynamic>;
      final termList = data['results']['termList'] as List;
      dictionaryList.value =
          termList.map((term) => DictionaryModel.fromJson(term)).toList();
    } catch (e) {
      debugPrint('fetchDictionary Error: $e');
      dictionaryList.clear(); // 에러 발생 시 빈 리스트
    } finally {
      isLoading.value = false;
    }
  }

  /// 특정 용어 상세 불러오기 (팝업용)
  Future<void> getTermDetail(int id) async {
    try {
      final response = await remoteDataSource.getDetailTerms(id);
      debugPrint("getTermDetail response: $response");
    } catch (e) {
      debugPrint('getTermDetail Error: $e');
    }
  }

  /// 스크랩 등록
  Future<void> postTermScrap(int id) async {
    try {
      final response = await remoteDataSource.postTermsScrap(id);
      debugPrint("postTermScrap response: $response");
    } catch (e) {
      debugPrint("postTermScrap Error: $e");
    }
  }

  /// 스크랩 삭제
  Future<void> deleteTermScrap(int id) async {
    try {
      final response = await remoteDataSource.deleteScrap(id);
      debugPrint("deleteTermScrap response: $response");
    } catch (e) {
      debugPrint("deleteTermScrap Error: $e");
    }
  }
}
