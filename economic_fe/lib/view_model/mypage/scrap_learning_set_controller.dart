import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view/screens/mypage/scrap_learning_set_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapLearningSetController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  var isLoading = true.obs;
  var concept = <String, dynamic>{}.obs;
  // var conceptId = 0.obs;
  // var learningSetName = "개념 학습".obs;
  var isScrapped = true.obs; // 기본값을 true로 설정 (처음엔 스크랩된 상태)

  /// 개별 개념 학습 데이터 불러오기
  Future<void> fetchSingleConcept(int conceptId) async {
    debugPrint("fetchSingleConcept() 호출됨 - conceptId: $conceptId");

    if (conceptId == 0) {
      debugPrint("유효하지 않은 conceptId");
      return;
    }

    try {
      isLoading.value = true;
      var response = await _remoteDataSource.fetchSingleConcept(conceptId);

      if (response.isNotEmpty) {
        concept.assignAll(response);
        debugPrint("개념 학습 데이터 로드 완료: ${concept['name']}");
        // 개별 개념 학습 데이터 로드 후, 스크랩 상태도 확인
        fetchScrapStatus(conceptId);
      } else {
        debugPrint("개별 개념 학습 데이터를 찾을 수 없습니다.");
      }
    } catch (e) {
      debugPrint("개별 개념 학습 조회 중 오류 발생: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// 개념 학습 스크랩 상태 조회
  Future<void> fetchScrapStatus(int conceptId) async {
    debugPrint("fetchScrapStatus() 호출됨 - conceptId: $conceptId");
    try {
      // API에서 요구하는 레벨 값 가져오기 (예: "BEGINNER", "INTERMEDIATE", "ADVANCED")
      String level = concept["level"];
      var response = await _remoteDataSource.getScrapConcepts(level);

      if (response != null && response["isSuccess"] == true) {
        List<dynamic> scrapConcepts = response["results"]["scrapConceptList"];

        // 현재 conceptId가 스크랩 목록에 있는지 확인
        isScrapped.value = scrapConcepts.any((item) => item["id"] == conceptId);

        debugPrint("스크랩 상태 조회 성공: ${isScrapped.value}");
      } else {
        debugPrint("스크랩 상태 조회 실패");
      }
    } catch (e) {
      debugPrint("fetchScrapStatus() 오류 발생: $e");
    }
  }

  /// 스크랩 토글 기능
  Future<void> toggleScrapStatus(int conceptId) async {
    if (isScrapped.value) {
      // 스크랩 취소
      bool success = await _remoteDataSource.deleteConceptScrap(conceptId);
      if (success) {
        isScrapped.value = false;
        debugPrint("스크랩 취소 성공");
      } else {
        debugPrint("스크랩 취소 실패");
      }
    } else {
      // 스크랩 추가
      bool success = await _remoteDataSource.scrapLearningConcept(conceptId);
      if (success) {
        isScrapped.value = true;
        debugPrint("스크랩 성공");
      } else {
        debugPrint("스크랩 실패");
      }
    }
  }

  /// 다음 학습 세트로 이동
  void goToNextLearningSet({
    required bool isMultiLearningMode,
    required List<dynamic> learningSets,
    required int currentIndex,
    required int totalIndex,
  }) {
    debugPrint("goToNextLearningSet() 호출됨");
    debugPrint("현재 Index: $currentIndex / 총 개수: $totalIndex");

    if (isMultiLearningMode &&
        learningSets.isNotEmpty &&
        currentIndex < totalIndex) {
      int nextConceptId = learningSets[currentIndex]['id'];
      debugPrint("다음 학습 세트로 이동 - conceptId: $nextConceptId");

      Get.off(
        () => const ScrapLearningSetPage(),
        arguments: {
          'learningSetId': nextConceptId,
          'isMultiLearningMode': true,
          'currentIndex': currentIndex + 1,
          'totalIndex': totalIndex,
          'learningSets': learningSets,
          'learningSetName': learningSets[currentIndex]['learningSetName'],
        },
        transition: Transition.fadeIn,
        duration: const Duration(milliseconds: 300),
      );
    } else {
      debugPrint("학습 완료: 총 $totalIndex 개 학습 완료");
      Get.offNamed('/mypage/learning');
    }
  }

  /// 레벨 변환 (API 레벨 → 한글 레벨)
  String convertLevel(String? level) {
    switch (level) {
      case "BEGINNER":
        return "초급";
      case "INTERMEDIATE":
        return "중급";
      case "ADVANCED":
        return "고급";
      default:
        return "알 수 없음";
    }
  }

  // 챗봇 화면으로 이동
  void toChatbot() {
    Get.toNamed('/chatbot');
  }
}
