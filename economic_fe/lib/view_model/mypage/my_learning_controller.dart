import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLearningController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;

  // 탭별 데이터
  final List<Map<String, dynamic>> quizzes = [
    {'category': '금융', 'title': '저축과 이자'},
    {'category': '경제', 'title': '수요와 공급'},
  ];

  final List<Map<String, dynamic>> learningMaterials = [
    {'category': '금융', 'title': '주식의 기초'},
    {'category': '경제', 'title': '물가와 환율'},
  ];

  var selectedConsonant = "ㄱ".obs;
  var keyword = "".obs;
  var typeValue = true.obs; //false : 검색

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

  // 스크랩한 단어 리스트 (임시 데이터 포함)
  var scrapedWords = <DictionaryModel>[
    DictionaryModel(
      termName: "인플레이션",
      termDescription: "물가 상승을 의미합니다.",
    ),
    DictionaryModel(
      termName: "GDP",
      termDescription: "국내총생산으로 한 국가에서 일정 기간 동안 생산된 총 상품과 서비스의 시장 가치입니다.",
    ),
    DictionaryModel(
      termName: "환율",
      termDescription: "다른 나라 화폐와의 교환 비율을 나타냅니다.",
    ),
    DictionaryModel(
      termName: "금리",
      termDescription: "돈을 빌리거나 맡길 때의 이자 비율을 의미합니다.",
    ),
    DictionaryModel(
      termName: "리세션",
      termDescription: "경제 활동이 줄어들고 경제 성장률이 감소하는 경기 후퇴를 뜻합니다.",
    ),
  ].obs;

  // 현재 선택된 탭 데이터
  RxList<Map<String, dynamic>> currentData = <Map<String, dynamic>>[].obs;

  // 현재 선택된 레벨
  RxString selectedLevel = '초급'.obs;

  // 버튼 텍스트
  RxString buttonText = '스크랩 한 모든 퀴즈 다시 풀기'.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);

    // 초기 데이터 설정
    updateCurrentData(0);

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
        currentData.assignAll(quizzes);
        buttonText.value = '스크랩 한 모든 퀴즈 다시 풀기';
        break;
      case 1:
        currentData.assignAll(learningMaterials);
        buttonText.value = '스크랩 한 모든 학습 다시 보기';
        break;
    }
  }

  void updateSelectedLevel(String level) {
    selectedLevel.value = level;
  }
}
