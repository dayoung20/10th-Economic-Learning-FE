import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapLearningSetController extends GetxController {
  final RemoteDataSource _remoteDataSource = RemoteDataSource();

  var isLoading = true.obs;
  var concept = <String, dynamic>{}.obs;
  var conceptId = 0.obs;
  var learningSetName = "개념 학습".obs;
  var isScrapped = true.obs; // 기본값을 true로 설정 (처음엔 스크랩된 상태)

  @override
  void onInit() {
    super.onInit();

    // Get.arguments에서 conceptId 가져오기
    if (Get.arguments != null && Get.arguments is Map<String, dynamic>) {
      conceptId.value = Get.arguments["conceptId"] ?? 0;
      learningSetName.value = Get.arguments["learningSetName"] ?? "개념 학습";
    }

    // 개념 학습 데이터 가져오기
    fetchSingleConcept();
  }

  /// 개별 개념 학습 데이터 불러오기
  Future<void> fetchSingleConcept() async {
    if (conceptId.value == 0) {
      debugPrint("유효하지 않은 conceptId");
      return;
    }

    try {
      isLoading.value = true;
      var response =
          await _remoteDataSource.fetchSingleConcept(conceptId.value);

      if (response.isNotEmpty) {
        concept.assignAll(response);
        // 개별 개념 학습 데이터 로드 후, 스크랩 상태도 확인
        fetchScrapStatus();
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
  Future<void> fetchScrapStatus() async {
    try {
      // API에서 요구하는 레벨 값 가져오기 (예: "BEGINNER", "INTERMEDIATE", "ADVANCED")
      String level = concept["level"];
      var response = await _remoteDataSource.getScrapConcepts(level);

      if (response != null && response["isSuccess"] == true) {
        List<dynamic> scrapConcepts = response["results"]["scrapConceptList"];

        // 현재 conceptId가 스크랩 목록에 있는지 확인
        isScrapped.value =
            scrapConcepts.any((item) => item["id"] == conceptId.value);

        debugPrint("스크랩 상태 조회 성공: ${isScrapped.value}");
      } else {
        debugPrint("스크랩 상태 조회 실패");
      }
    } catch (e) {
      debugPrint("fetchScrapStatus() 오류 발생: $e");
    }
  }

  /// 스크랩 토글 기능
  Future<void> toggleScrapStatus() async {
    if (isScrapped.value) {
      // 스크랩 취소
      bool success =
          await _remoteDataSource.deleteConceptScrap(conceptId.value);
      if (success) {
        isScrapped.value = false;
        debugPrint("스크랩 취소 성공");
      } else {
        debugPrint("스크랩 취소 실패");
      }
    } else {
      // 스크랩 추가
      bool success =
          await _remoteDataSource.scrapLearningConcept(conceptId.value);
      if (success) {
        isScrapped.value = true;
        debugPrint("스크랩 성공");
      } else {
        debugPrint("스크랩 실패");
      }
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
