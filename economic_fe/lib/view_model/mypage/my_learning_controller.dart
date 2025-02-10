import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  final remoteDataSource = RemoteDataSource();

  late TabController tabController;

  var selectedConsonant = "ㄱ".obs;
  var keyword = "".obs;
  var typeValue = true.obs; //false : 검색
  var selectedLevel = 'BEGINNER'.obs; // 초기값 설정
  var scrapConcepts = <Map<String, dynamic>>[].obs; // 스크랩한 개념 학습 목록
  var scrapQuizzes = <Map<String, dynamic>>[].obs; // 스크랩한 퀴즈 목록
  var scrapTerms = <DictionaryModel>[].obs; // 스크랩한 용어 목록

  final List<String> consonants = [
    'ㄱ',
    'ㄴ',
    'ㄷ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅅ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];

  // 버튼 텍스트
  RxString buttonText = '스크랩 한 모든 퀴즈 다시 풀기'.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    // 초기 데이터 설정
    updateCurrentData(0);
    fetchScrapConcepts();
    fetchScrapQuizzes();
    fetchScrapedTerms();

    // 탭 변경 시 데이터와 버튼 텍스트 업데이트
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        updateCurrentData(tabController.index);
      }
    });
  }

  void updateCurrentData(int index) {
    switch (index) {
      case 0:
        buttonText.value = '스크랩 한 모든 퀴즈 다시 풀기';
        break;
      case 1:
        buttonText.value = '스크랩 한 모든 학습 다시 보기';
        break;
    }
  }

  void updateSelectedLevel(String level) {
    selectedLevel.value = level;
    fetchScrapConcepts(); // 레벨 변경 시 데이터 로드
    fetchScrapQuizzes();
  }

  Future<void> fetchScrapConcepts() async {
    try {
      final response =
          await remoteDataSource.getScrapConcepts(selectedLevel.value);
      if (response != null && response['isSuccess'] == true) {
        final List<dynamic> rawConcepts =
            response['results']['scrapConceptList'] ?? [];
        scrapConcepts.value = rawConcepts.map((concept) {
          return Map<String, dynamic>.from(concept);
        }).toList();
      } else {
        scrapConcepts.clear();
        debugPrint('fetchScrapConcepts 실패: ${response?['message']}');
      }
    } catch (e) {
      debugPrint('fetchScrapConcepts Error: $e');
      scrapConcepts.clear();
    }
  }

  Future<void> fetchScrapQuizzes() async {
    try {
      final response =
          await remoteDataSource.getScrapQuizzes(selectedLevel.value);
      if (response != null && response['isSuccess'] == true) {
        final List<dynamic> rawQuizzes =
            response['results']['scrapQuizList'] ?? [];
        scrapQuizzes.value = rawQuizzes.map((concept) {
          return Map<String, dynamic>.from(concept);
        }).toList();
      } else {
        scrapQuizzes.clear();
        debugPrint('fetchScrapQuizzes 실패: ${response?['message']}');
      }
    } catch (e) {
      debugPrint('fetchScrapQuizzes Error: $e');
      scrapQuizzes.clear();
    }
  }

  Future<void> fetchScrapedTerms() async {
    debugPrint("fetchScrapedTerms() 실행됨");
    try {
      var terms = await remoteDataSource.fetchScrapedTerms(null);
      scrapTerms.assignAll(
          terms.map((json) => DictionaryModel.fromJson(json)).toList());
      debugPrint("fetchScrapedTerms() 완료, 데이터 개수: ${scrapTerms.length}");
    } catch (e) {
      debugPrint("Error fetching terms: $e");
    }
  }

  /// 자음으로 단어 검색하기
  Future<void> searchScrapedTermsByInitial(String initial) async {
    debugPrint("searchScrapedTermsByInitial() 실행됨");
    try {
      var terms = await remoteDataSource.fetchScrapedTerms(initial);
      scrapTerms.assignAll(
          terms.map((json) => DictionaryModel.fromJson(json)).toList());
      debugPrint(
          "searchScrapedTermsByInitial() 완료, 데이터 개수: ${scrapTerms.length}");
    } catch (e) {
      debugPrint("Error searching terms by initial: $e");
    }
  }

  /// 키워드로 단어 검색하기
  Future<void> searchScrapedTermsByKeyword() async {
    debugPrint("searchScrapedTermsByKeyword() 실행됨");
    try {
      var terms = await remoteDataSource.searchScrapedTerms(keyword.value);
      scrapTerms.assignAll(
          terms.map((json) => DictionaryModel.fromJson(json)).toList());
      debugPrint(
          "searchScrapedTermsByKeyword() 완료, 데이터 개수: ${scrapTerms.length}");
    } catch (e) {
      debugPrint("Error searching terms by keyword: $e");
    }
  }

  // 특정 용어 상세 보기
  Future<void> getTermDetail(int id) async {
    try {
      print("start");

      dynamic response;

      response = await remoteDataSource.getDetailTerms(id);
      print("respose : $response");
    } catch (e) {
      debugPrint('Error: $e');
    }
  }
}
