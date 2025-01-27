import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart'; // GoRouter import

class DictionaryController extends GetxController {
  late BuildContext context;

  var selectedConsonant = "ㄱ".obs;

  void getStats() {
    // 통계 데이터 로드 또는 초기화 작업
    print("Stats initialized!");
  }

  //용어 사전 데이터 불러오기
  Future<List<DictionaryModel>> getDictionaryList(
      int page, String consonant) async {
    try {
      print("start");
      dynamic response;

      response = await RemoteDataSource.getDictionary(page, consonant);
      print("response :: $response");

      final data = response as Map<String, dynamic>;
      final termList = data['results']['termList'] as List;
      return termList.map((term) => DictionaryModel.fromJson(term)).toList();
    } catch (e) {
      debugPrint('Error: $e');
      return [];
    }
  }

  //특정 용어 상세 보기
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
}
