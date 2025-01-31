import 'dart:ffi';

import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class DictionaryController extends GetxController {
  late BuildContext context;

  var selectedConsonant = "ㄱ".obs;
  var keyword = "".obs;
  var typeValue = true.obs; //false : 검색

  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  //용어 사전 데이터 불러오기
  Future<List<DictionaryModel>> getDictionaryList(
      int page, String text, bool type) async {
    // type = true : 그 외 init, false : 검색
    try {
      print("start");
      dynamic response;

      if (type) {
        response = await RemoteDataSource.getDictionary(page, text);
        print("response :: $response");

        final data = response as Map<String, dynamic>;
        final termList = data['results']['termList'] as List;
        return termList.map((term) => DictionaryModel.fromJson(term)).toList();
      } else {
        print("검색");
        response = await RemoteDataSource.getKewordResult(page, text);
        print("response : $response");

        final data = response as Map<String, dynamic>;
        final termList = data['results']['termList'] as List;
        return termList.map((term) => DictionaryModel.fromJson(term)).toList();
      }
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  // 키워드로 검색하기
  Future<void> getKewordResult(int page, String keyword) async {
    try {
      print("start");

      dynamic response;

      response = await RemoteDataSource.getKewordResult(page, keyword);
      print("response : $response");
      // final data = response as Map<String, dynamic>;
    } catch (e) {
      debugPrint("Error : $e");
    }
  }

  // 특정 용어 상세 보기
  Future<void> getTermDetail(int id) async {
    try {
      print("start");

      dynamic response;

      response = await RemoteDataSource.getDetailTerms(id);
      print("respose : $response");
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  // 특정 용어 스크랩 하기
  Future<void> postTermScrap(int id) async {
    try {
      print("start");

      dynamic response;
      response = await RemoteDataSource.postTermsScrap(id);
      print("scrap response : $response");
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  // 특정 용어 스크랩 취소하기
  Future<void> deleteTermScrap(int id) async {
    try {
      print("start");

      dynamic response;
      response = await RemoteDataSource.deleteScrap(id);
      print("scrap delete response : $response");
    } catch (e) {
      debugPrint("Error : $e");
    }
  }
}
