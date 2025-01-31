import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class RemoteDataSource {
  //기본 api 엔드포인트
  static String baseUrl = dotenv.env['API_URL']!;

  //로그인 전 임시 accessToken
  static String accessToken = dotenv.env['BASE_TOKEN']!;

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// authToken을 포함하도록 수정
  static Future<dynamic> postApi(
    String endPoint,
    Map<String, dynamic> jsonData,
  ) async {
    String apiUrl = '$baseUrl/$endPoint';
    // String authToken = dotenv.env['AUTHORIZATION_KEY']!; // 환경 변수에서 가져오기
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        debugPrint('POST 요청 성공');
        return response.statusCode;
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode}) ${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('POST 요청 중 예외 발생: $e');
      return null;
    }
  }

  /// API PATCH
  ///
  /// 데이터 일부 수정시 사용
  static Future<dynamic> _patchApi(String endPoint, String? jsonData) async {
    String apiUrl = '$baseUrl/$endPoint';
    Map<String, String> headers = {'Content-Type': 'application/json'};
    // String requestBody = jsonData;
    debugPrint('PATCH 요청: $endPoint');

    try {
      final response =
          await http.patch(Uri.parse(apiUrl), headers: headers, body: jsonData);
      if (response.statusCode == 200) {
        debugPrint('PATCH 요청 성공');
      } else {
        debugPrint('PATCH 요청 실패: (${response.statusCode})${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('PATCH 요청 중 예외 발생: $e');
      return;
    }
  }

  /// API GET (token 없이 사용)
  ///
  /// 데이터 받아올 때 사용
  static Future<dynamic> _getApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');
        return jsonDecode(response.body);
      } else {
        debugPrint('GET 요청 실패: (${response.statusCode})${response.body}');
        return response;
      }
    } catch (e) {
      debugPrint('GET 요청 중 예외 발생: $e');
      return;
    }
  }

  /// API GET (token 사용)
  ///
  /// 데이터 받아올 때 사용
  static Future<dynamic> _getApiWithHeader(
      String endPoint, String accessToken) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    try {
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'accept': '*/*',
      };
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: headers,
      );

      if (response.statusCode == 200) {
        debugPrint('GET 요청 성공');

        // return jsonDecode(response.body);
        // 한글 깨지지 않도록 설정
        final decodedResponse = jsonDecode(utf8.decode(response.bodyBytes));
        return decodedResponse;
      } else {
        debugPrint('GET 요청 실패: (${response.statusCode})${response.body}');
        return response;
      }
    } catch (e) {
      debugPrint('GET 요청 중 예외 발생: $e');
      return;
    }
  }

  /// API DELETE
  ///
  /// 데이터 삭제시 사용
  static Future<dynamic> _deleteApi(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('DELETE 요청: $endPoint');

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        debugPrint('DELETE 요청 성공');
      } else {
        debugPrint('DELETE 요청 실패: (${response.statusCode})${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('DELETE 요청 중 예외 발생: $e');
      return;
    }
  }

  /// 개념 학습 세트 조회
  /// api/v1/learning/{learningSetId}/concepts
  static Future<dynamic> getLearningConcept(
      int learningSetId, String level) async {
    dynamic response =
        await _getApi('api/v1/learning/$learningSetId/concepts?level=$level');
    print(response);
    return response;
  }

  /// api/v1/level-test/quiz 레벨 테스트 퀴즈 목록 조회
  static Future<dynamic> getLevelTest() async {
    dynamic response = await _getApi('api/v1/level-test/quiz');
    return response;
  }

  /// 뉴스 목록 조회
  /// api/news
  static Future<dynamic> getNewsList(
      int page, String sort, String? category) async {
    dynamic response;
    if (category != null) {
      response = await _getApiWithHeader(
        'api/news?page=$page&sort=$sort&category=$category',
        accessToken,
      );
    } else {
      response = await _getApiWithHeader(
        'api/news?page=$page&sort=$sort',
        accessToken,
      );
    }

    if (response != null) {
      print('응답 데이터 : $response');
    } else {
      print('데이터 get 실패');
    }
    return response;
  }

  /// 자음 별 용어 조회
  /// api/v1/terms/search/consonant
  static Future<dynamic> getDictionary(int page, String consonant) async {
    dynamic response;

    // 한글 자음을 URL 인코딩
    String encodedConsonant = Uri.encodeComponent(consonant);

    response = await _getApiWithHeader(
        'api/v1/terms/search/consonant?page=$page&consonant=$encodedConsonant',
        accessToken);

    if (response != null) {
      print("용어사전 응답 데이터 : $response");
    } else {
      print("get 데이터 실패");
    }
    return response;
  }

  /// 용어 상세 조회
  /// api/v1/terms/{id}
  static Future<dynamic> getDetailTerms(int id) async {
    dynamic response;

    response = await _getApiWithHeader('api/v1/terms/$id', accessToken);

    if (response != null) {
      print("용어 상세 : $response");
    } else {
      print("get 데이터 실패");
    }

    return response;
  }

  /// 키워드 별 용어 조회
  /// api/v1/terms/search/keyword
  static Future<dynamic> getKewordResult(int page, String keyword) async {
    dynamic response;

    // 한글을 URL 인코딩
    String encodedkeyword = Uri.encodeComponent(keyword);

    response = await _getApiWithHeader(
        'api/v1/terms/search/keyword?page=$page&keyword=$encodedkeyword',
        accessToken);

    if (response != null) {
      print("키워드 검색 결과 : $response");
    } else {
      print("get 데이터 실패");
    }

    return response;
  }

  /// 틀린 문제 데이터 요청
  /// api/v1/user/wrong-quizzes
  static Future<dynamic> fetchIncorrectQuestions(String level) async {
    String endpoint = 'api/v1/user/wrong-quizzes?level=$level';

    try {
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response['isSuccess'] == true) {
        debugPrint('틀린 문제 데이터 요청 성공');
        return response;
      } else {
        debugPrint('데이터 요청 실패: ${response?['message'] ?? '알 수 없는 에러'}');
        return null;
      }
    } catch (e) {
      debugPrint('요청 중 예외 발생: $e');
      return null;
    }
  }

  /// 개별 퀴즈 조회
  /// API: api/v1/learning/learning/quiz/{quizId}
  static Future<dynamic> fetchQuizById(int quizId) async {
    try {
      // API Endpoint 구성
      String endPoint = 'api/v1/learning/learning/quiz/$quizId';

      // GET 요청 수행
      final response = await _getApiWithHeader(endPoint, accessToken);

      // 응답 데이터 처리
      if (response != null) {
        print("퀴즈 데이터 응답: $response");
        return response;
      } else {
        print("퀴즈 데이터 요청 실패");
        return null;
      }
    } catch (e) {
      print("fetchQuizById 요청 중 예외 발생: $e");
      return null;
    }
  }

  /// 스크랩 한 게시물 조회
  /// API: api/v1/user/scrap-posts
  static Future<dynamic> fetchScrapedPosts() async {
    const String endPoint = 'api/v1/user/scrap-posts';

    final response = await _getApiWithHeader(endPoint, accessToken);

    if (response != null && response['isSuccess']) {
      debugPrint("스크랩 게시글 목록 응답: ${response['results']}");
      return response['results'];
    } else {
      debugPrint("스크랩 게시글 목록 가져오기 실패");
      return null;
    }
  }

  /// 좋아요 한 게시물 조회
  /// API: api/v1/user/like-posts
  static Future<dynamic> fetchLikedPosts() async {
    const String endPoint = 'api/v1/user/like-posts';

    final response = await _getApiWithHeader(endPoint, accessToken);

    if (response != null && response['isSuccess']) {
      debugPrint("좋아요 게시글 목록 응답: ${response['results']}");
      return response['results'];
    } else {
      debugPrint("좋아요 게시글 목록 가져오기 실패");
      return null;
    }
  }

  /// 좋아요 한 댓글 조회
  /// API: api/v1/user/like-comments
  static Future<dynamic> fetchLikedComments() async {
    const String endPoint = 'api/v1/user/like-comments';

    final response = await _getApiWithHeader(endPoint, accessToken);

    if (response != null && response['isSuccess']) {
      debugPrint("좋아요 댓글 목록 응답: ${response['results']}");
      return response['results'];
    } else {
      debugPrint("좋아요 댓글 목록 가져오기 실패");
      return null;
    }
  }

  /// 스크랩 한 개념 학습 조회
  /// API: api/v1/user/scrap-concepts
  static Future<dynamic> getScrapConcepts(String level) async {
    String endpoint = 'api/v1/user/scrap-concepts?level=$level';

    try {
      // _getApiWithHeader 호출
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('스크랩한 학습 데이터 로드 성공');
        return response;
      } else {
        debugPrint('스크랩한 학습 데이터 로드 실패');
        return null;
      }
    } catch (e) {
      debugPrint('getScrapConcepts Error: $e');
      return null;
    }
  }

  /// 스크랩 한 퀴즈 조회
  /// API: api/v1/user/scrap-quizzes
  static Future<dynamic> getScrapQuizzes(String level) async {
    String endpoint = 'api/v1/user/scrap-quizzes?level=$level';

    try {
      // _getApiWithHeader 호출
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('스크랩한 퀴즈 데이터 로드 성공');
        return response;
      } else {
        debugPrint('스크랩한 퀴즈 데이터 로드 실패');
        return null;
      }
    } catch (e) {
      debugPrint('getScrapConcepts Error: $e');
      return null;
    }
  }

  /// 레벨별 학습 진도율 조회
  /// API: api/v1/user/progress
  static Future<dynamic> getProgress() async {
    String endpoint = 'api/v1/user/progress';

    try {
      // _getApiWithHeader 호출
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('학습 진도율 데이터 로드 성공');
        return response;
      } else {
        debugPrint('학습 진도율 데이터 로드 실패');
        return null;
      }
    } catch (e) {
      debugPrint('getProgress Error: $e');
      return null;
    }
  }
}
