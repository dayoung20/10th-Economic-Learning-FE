import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/finish_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningConceptController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  var conceptName = "개념 학습".obs;
  var currentStepIdx = 0.obs; // 현재 개념 학습 인덱스
  var selectedLevelIndex = 0.obs; // 선택된 레벨 인덱스 (초급: 0, 중급: 1, 고급: 2)
  var conceptList = <Map<String, dynamic>>[].obs; // 개념 학습 리스트
  var scrapConceptList = <int>[].obs; // 스크랩한 개념 학습 ID 목록
  var isLoading = true.obs; // 로딩 상태
  var learningSetId = 0.obs; // 학습 세트 ID
  List<String> levelOptions = ["초급", "중급", "고급"]; // UI에 표시할 레벨 목록
  List<String> apiLevelOptions = [
    "BEGINNER",
    "INTERMEDIATE",
    "ADVANCED"
  ]; // API에서 사용하는 레벨 값

  @override
  void onInit() {
    super.onInit();

    print("Get.arguments: ${Get.arguments}"); // 전달된 arguments 확인

    // Get.arguments가 null인지 확인 후 학습 세트 ID와 개념 이름 가져오기
    if (Get.arguments != null) {
      learningSetId.value = Get.arguments?["learningSetId"] ?? 0;
      conceptName.value = Get.arguments?["name"] ?? "개념 학습";
    } else {
      learningSetId.value = 0;
      conceptName.value = "개념 학습"; // 기본값 설정
    }

    // 기본 레벨은 "초급"으로 설정
    selectedLevelIndex.value = 0;

    // 개념 학습 데이터 불러오기 + 스크랩된 목록 불러오기
    fetchLearningConcepts();
    fetchScrapConcepts();
  }

  /// 현재 선택된 레벨을 API에서 요구하는 값으로 변환
  String getApiLevel() {
    return apiLevelOptions[selectedLevelIndex.value]; // 예: 초급(0) → "BEGINNER"
  }

  /// 개념 학습 데이터 불러오기 (레벨 변경 시마다 호출)
  Future<void> fetchLearningConcepts() async {
    try {
      isLoading.value = true;

      String selectedApiLevel = getApiLevel(); // API에서 사용할 레벨 값 가져오기

      print("API 요청 - 학습 세트 ID: ${learningSetId.value}, 레벨: $selectedApiLevel");

      var response = await _remoteDataSource.fetchLearningConcepts(
          learningSetId.value, selectedApiLevel);

      if (response.isNotEmpty) {
        conceptList.assignAll(response);
        currentStepIdx.value = 0; // 데이터 갱신 시 첫 번째 개념으로 이동
        print("개념 학습 데이터 로드 성공: ${conceptList.length}개");
      } else {
        print("개념 학습 데이터가 없습니다.");
      }
    } catch (e) {
      debugPrint("fetchLearningConcepts() 오류 발생: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 현재 사용자가 스크랩한 개념 학습 목록 가져오기
  Future<void> fetchScrapConcepts() async {
    try {
      String selectedApiLevel = getApiLevel();
      var response = await _remoteDataSource.getScrapConcepts(selectedApiLevel);

      print("스크랩 데이터 응답: $response"); // 응답 데이터 확인

      if (response != null && response["results"] != null) {
        List<dynamic> scrapedConcepts = response["results"]["scrapConceptList"];

        // 각 개념의 conceptId만 추출하여 List<int>로 변환
        scrapConceptList
            .assignAll(scrapedConcepts.map((e) => e["id"] as int).toList());

        print("스크랩된 개념 학습 ID 목록: $scrapConceptList");
      }
    } catch (e) {
      debugPrint("fetchScrapConcepts() 오류 발생: $e");
    }
  }

  /// 🔹 스크랩 여부 확인
  bool isConceptScrapped(int conceptId) {
    return scrapConceptList.contains(conceptId);
  }

  /// 개념 학습 세트 스크랩 & 스크랩 취소 (토글 기능)
  Future<void> toggleScrapConcept(int conceptId) async {
    if (isConceptScrapped(conceptId)) {
      // 스크랩 취소
      bool success = await _remoteDataSource.deleteConceptScrap(conceptId);
      if (success) {
        scrapConceptList.remove(conceptId);
        print("스크랩 취소 성공: $conceptId");
      }
    } else {
      // 스크랩 추가
      bool success = await _remoteDataSource.scrapLearningConcept(conceptId);
      if (success) {
        scrapConceptList.add(conceptId);
        print("스크랩 성공: $conceptId");
      }
    }
  }

  /// 레벨 변경 메서드 (모달에서 선택 시 호출)
  void changeLevel(int index) {
    if (index != selectedLevelIndex.value) {
      selectedLevelIndex.value = index;
      currentStepIdx.value = 0; // 첫 번째 개념으로 초기화
      fetchLearningConcepts(); // 새 레벨에 맞는 데이터 로드
    }
  }

  /// 다음 개념 학습으로 이동
  void nextConcept() {
    if (currentStepIdx.value < conceptList.length - 1) {
      currentStepIdx.value++;
    } else {
      clickedFinishBtn();
    }
  }

  /// 이전 개념 학습으로 이동
  void prevConcept() {
    if (currentStepIdx.value > 0) {
      currentStepIdx.value--;
    } else {
      clickedCloseBtn();
    }
  }

  /// 학습 완료 시 종료 화면으로 이동
  void clickedFinishBtn() {
    Get.to(() => const FinishPage(), arguments: {
      'contents': '학습 주제',
      'number': 1,
      'category': 0,
      'level': getApiLevel(),
    });
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }

  void clickedCloseBtn() {
    Get.offNamed('/learning_list');
  }

  // 학습 중단 확인창 표시 여부 관리
  var isModalVisible = false.obs;

  void showModal() {
    isModalVisible.value = true;
  }

  void hideModal() {
    isModalVisible.value = false;
  }
}
