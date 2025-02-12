import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataSource {
  //기본 api 엔드포인트
  static String baseUrl = dotenv.env['API_URL']!;

  //로그인 전 임시 accessToken
  static String accessToken = dotenv.env['BASE_TOKEN']!;

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// jsonData 포함O
  static Future<dynamic> postApiWithJson(
    String endPoint,
    Map<String, dynamic> jsonData,
  ) async {
    String apiUrl = '$baseUrl/$endPoint';
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

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// jsonData 포함O
  /// 앱에 저장된 accessToken 사용
  Future<dynamic> postApiWithJsonTest(
    String endPoint,
    Map<String, dynamic> jsonData,
  ) async {
    String apiUrl = '$baseUrl/$endPoint';

    String? access = await getToken("accessToken");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access',
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

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// jsonData 포함O
  /// 앱에 저장된 accessToken 사용
  /// statuscode 반환하지 않고 전체 response 반환
  Future<dynamic> postApiWithJsonReturnResponse(
    String endPoint,
    Map<String, dynamic> jsonData,
  ) async {
    String apiUrl = '$baseUrl/$endPoint';

    String? access = await getToken("accessToken");

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        debugPrint('POST 요청 성공');
        return jsonDecode(utf8.decode(response.bodyBytes));
      } else {
        debugPrint('POST 요청 실패: (${response.statusCode}) ${response.body}');
      }

      return response.statusCode;
    } catch (e) {
      debugPrint('POST 요청 중 예외 발생: $e');
      return null;
    }
  }

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// jsonData 포함X
  static Future<dynamic> _postApi(
    String endPoint,
    // Map<String, dynamic> jsonData,
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
        // body: jsonEncode(jsonData),
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

  /// API POST
  ///
  /// 데이터 생성시 사용
  /// jsonData 포함X
  /// 앱에 저장된 accessToken 사용
  Future<dynamic> _postApiTest(
    String endPoint,
  ) async {
    String apiUrl = '$baseUrl/$endPoint';
    String? access = await getToken("accessToken");
    // String authToken = dotenv.env['AUTHORIZATION_KEY']!; // 환경 변수에서 가져오기
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $access',
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        // body: jsonEncode(jsonData),
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
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $accessToken',
    };
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

  /// API GET (token 사용)
  ///
  /// 데이터 받아올 때 사용
  /// 앱에 저장된 accessToken 사용
  Future<dynamic> _getApiWithHeaderTest(
      String endPoint, String accessToken) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('GET 요청: $endPoint');

    String? access = await getToken("accessToken");

    try {
      final headers = {
        'Authorization': 'Bearer $access',
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
      final headers = {
        'Authorization': 'Bearer $accessToken',
        'accept': '*/*',
      };
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

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

  /// API DELETE
  ///
  /// 데이터 삭제시 사용
  /// 앱에 저장된 accessToken 사용
  Future<dynamic> _deleteApiTest(String endPoint) async {
    String apiUrl = '$baseUrl/$endPoint';
    debugPrint('DELETE 요청: $endPoint');
    String? access = await getToken("accessToken");
    try {
      final headers = {
        'Authorization': 'Bearer $access',
        'accept': '*/*',
      };
      final response = await http.delete(
        Uri.parse(apiUrl),
        headers: headers,
      );

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

  // 토큰 저장
  Future<void> saveToken(String sessionKey, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(sessionKey, token);
  }

  // 토큰 불러오기
  Future<String?> getToken(String sessionKey) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(sessionKey);
  }

  // 토큰 삭제
  Future<void> deleteToken(String sessionKey) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(sessionKey);
  }

  /// 개념 학습 세트 조회
  /// api/v1/learning/{learningSetId}/concepts
  Future<dynamic> getLearningConcept(int learningSetId, String level) async {
    dynamic response = await _getApiWithHeaderTest(
        'api/v1/learning/$learningSetId/concepts?level=$level', accessToken);
    print(response);
    return response;
  }

  /// api/v1/learning
  /// 레벨별 학습 세트 조회
  Future<dynamic> postLearningSet() async {
    String endPoint = 'api/v1/learning';

    try {
      final response = await _postApiTest(endPoint); // API 요청
      print("Raw Response: $response");

      if (response is http.Response) {
        final jsonResponse = jsonDecode(response.body); // JSON 변환
        print("Decoded Response: $jsonResponse");
        return jsonResponse;
      }

      return response; // 혹시 다른 데이터 타입일 경우 그대로 반환
    } catch (e) {
      debugPrint("API Error: $e");
      return {}; // 에러 발생 시 빈 Map 반환
    }
  }

  /// 레벨 테스트 퀴즈 목록 조회
  /// api/v1/level-test/quiz
  static Future<dynamic> getLevelTest() async {
    dynamic response = await _getApi('api/v1/level-test/quiz');
    return response;
  }

  /// 뉴스 목록 조회
  /// api/news
  Future<dynamic> getNewsList(int page, String sort, String? category) async {
    dynamic response;
    if (category != null) {
      response = await _getApiWithHeaderTest(
        'api/news?page=$page&sort=$sort&category=$category',
        accessToken,
      );
    } else {
      response = await _getApiWithHeaderTest(
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

  /// api/news/{id}/scrap
  /// 뉴스 스크랩
  Future<dynamic> postNewsScrap(int id) async {
    String endPoint = "api/news/$id/scrap";

    try {
      final response = await _postApiTest(endPoint);

      if (response != null) {
        debugPrint("스크랩 post 성공");
        return true;
      } else {
        debugPrint("스크랩 실패");
        return false;
      }
    } catch (e) {
      debugPrint("scrap Error : $e");
      return false;
    }
  }

  /// 뉴스 스크랩 취소
  /// api/news/{id}/scrap
  Future<dynamic> deleteNewsScrap(int id) async {
    String endPoint = "api/news/$id/scrap";

    try {
      final response = await _deleteApiTest(endPoint);

      if (response != null) {
        debugPrint("스크랩 delete 성공");
        return true;
      } else {
        debugPrint("스크랩 delete 실패");
        return false;
      }
    } catch (e) {
      debugPrint("scrap delete Error : $e");
      return false;
    }
  }

  /// 자음 별 용어 조회
  /// api/v1/terms/search/consonant
  Future<dynamic> getDictionary(int page, String consonant) async {
    dynamic response;

    // 한글 자음을 URL 인코딩
    String encodedConsonant = Uri.encodeComponent(consonant);

    response = await _getApiWithHeaderTest(
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
  Future<dynamic> getDetailTerms(int id) async {
    dynamic response;

    response = await _getApiWithHeaderTest('api/v1/terms/$id', accessToken);

    if (response != null) {
      print("용어 상세 : $response");
    } else {
      print("get 데이터 실패");
    }

    return response;
  }

  /// 키워드 별 용어 조회
  /// api/v1/terms/search/keyword
  Future<dynamic> getKewordResult(int page, String keyword) async {
    dynamic response;

    // 한글을 URL 인코딩
    String encodedkeyword = Uri.encodeComponent(keyword);

    response = await _getApiWithHeaderTest(
        'api/v1/terms/search/keyword?page=$page&keyword=$encodedkeyword',
        accessToken);

    if (response != null) {
      print("키워드 검색 결과 : $response");
    } else {
      print("get 데이터 실패");
    }

    return response;
  }

  /// api/v1/terms/{id}/scrap
  /// 용어 스크랩
  Future<dynamic> postTermsScrap(int id) async {
    String endPoint = "api/v1/terms/$id/scrap";

    try {
      final response = await _postApiTest(endPoint);

      if (response != null) {
        debugPrint("스크랩 post 성공");
        return true;
      } else {
        debugPrint("스크랩 실패");
        return false;
      }
    } catch (e) {
      debugPrint("scrap Error : $e");
      return false;
    }
  }

  /// api/v1/terms/{id}/scrap
  /// 용어 스크랩 취소
  Future<dynamic> deleteScrap(int id) async {
    String endPoint = "api/v1/terms/$id/scrap";

    try {
      final response = await _deleteApiTest(endPoint);

      if (response != null) {
        debugPrint("스크랩 delete 성공");
        return true;
      } else {
        debugPrint("스크랩 delete 실패");
        return false;
      }
    } catch (e) {
      debugPrint("scrap delete Error : $e");
      return false;
    }
  }

  /// 틀린 문제 데이터 요청
  /// api/v1/user/wrong-quizzes
  Future<dynamic> fetchIncorrectQuestions(String level) async {
    String endpoint = 'api/v1/user/wrong-quizzes?level=$level';

    try {
      // final response = await _getApiWithHeaderTest(endpoint, accessToken);
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
  Future<dynamic> fetchQuizById(int quizId) async {
    try {
      // API Endpoint 구성
      String endPoint = 'api/v1/learning/learning/quiz/$quizId';

      // GET 요청 수행
      // final response = await _getApiWithHeaderTest(endPoint, accessToken);
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
  Future<dynamic> fetchScrapedPosts() async {
    const String endPoint = 'api/v1/user/scrap-posts';

    // final response = await _getApiWithHeaderTest(endPoint, accessToken);
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
  Future<dynamic> fetchLikedPosts() async {
    const String endPoint = 'api/v1/user/like-posts';

    // final response = await _getApiWithHeaderTest(endPoint, accessToken);
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
  Future<dynamic> fetchLikedComments() async {
    const String endPoint = 'api/v1/user/like-comments';

    // final response = await _getApiWithHeaderTest(endPoint, accessToken);
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
  Future<dynamic> getScrapConcepts(String level) async {
    String endpoint = 'api/v1/user/scrap-concepts?level=$level';

    try {
      // _getApiWithHeader 호출
      // final response = await _getApiWithHeaderTest(endpoint, accessToken);
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
  Future<dynamic> getScrapQuizzes(String level) async {
    String endpoint = 'api/v1/user/scrap-quizzes?level=$level';

    try {
      // _getApiWithHeader 호출
      // final response = await _getApiWithHeaderTest(endpoint, accessToken);
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
  Future<dynamic> getProgress() async {
    String endpoint = 'api/v1/user/progress';

    try {
      // _getApiWithHeader 호출
      // final response = await _getApiWithHeaderTest(endpoint, accessToken);
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

  /// 사용자 프로필 등록 API
  /// API: api/v1/user/profile
  Future<dynamic> registerUserProfile(Map<String, dynamic> userProfile) async {
    String endpoint = 'api/v1/user/profile';

    try {
      final response = await postApiWithJsonTest(endpoint, userProfile);

      if (response == 200) {
        debugPrint('사용자 프로필 등록 성공');
        return true;
      } else {
        debugPrint('사용자 프로필 등록 실패: $response');
        return false;
      }
    } catch (e) {
      debugPrint('registerUserProfile Error: $e');
      return false;
    }
  }

  /// api/v1/chatbot/list
  /// 대화 내역 조회
  Future<dynamic> getMessageList(int page) async {
    String endPoint = 'api/v1/chatbot/list?page=$page';

    try {
      // _getApiWithHeader 호출
      final response = await _getApiWithHeaderTest(endPoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('대화 내역 조회 성공');
        return response;
      } else {
        debugPrint('대화 내역 조회  실패');
        return null;
      }
    } catch (e) {
      debugPrint('Error: $e');
      return null;
    }
  }

  /// api/v1/chatbot
  /// 챗봇에게 메세지 보내기
  Future<dynamic> postChatbotMessage(String message) async {
    String encodedmsg = Uri.encodeComponent(message);
    String endPoint = "api/v1/chatbot?message=$encodedmsg";
    try {
      final response = await _postApiTest(endPoint);

      if (response != null) {
        debugPrint("대화 전송 성공");
        return response;
      } else {
        debugPrint("대화 전송 실패");
        return null;
      }
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  /// api/v1/chatbot/clear
  /// 대화 내역 초기화
  Future<bool> deleteMessage() async {
    String endPoint = "api/v1/chatbot/clear";

    try {
      final response = await _deleteApiTest(endPoint);

      if (response != null) {
        debugPrint("메시지 delete 성공");
        return true;
      } else {
        debugPrint("메시지 delete 실패");
        return false;
      }
    } catch (e) {
      debugPrint("delete Error : $e");
      return false;
    }
  }

  /// api/v2/auth/login/kakao
  /// 카카오 로그인 (v2)
  static Future<dynamic> getlogin(String accessToken) async {
    String endPoint = "api/v2/auth/login/kakao?accessToken=$accessToken";
    try {
      final response = await _getApi(endPoint);

      if (response != null) {
        debugPrint("성공");
        return response;
      } else {
        debugPrint("실패");
        return null;
      }
    } catch (e) {
      debugPrint('Error : $e');
    }
  }

  /// 게시글 목록 조회
  /// api: api/v1/post
  static Future<List<dynamic>> fetchCategoryPosts(
      String sort, String type) async {
    List<dynamic> categoryPosts = [];
    int currentPage = 0;
    int totalPages = 0; // 초기값 설정

    try {
      while (currentPage <= totalPages) {
        String endPoint;

        if (type == "ALL") {
          // 전체 카테고리일 경우 `type` 파라미터 없이 요청
          endPoint = 'api/v1/post?page=$currentPage&sort=$sort';
        } else {
          // 특정 카테고리 조회 시 `type` 포함
          endPoint = 'api/v1/post?page=$currentPage&sort=$sort&type=$type';
        }

        var response = await _getApiWithHeader(endPoint, accessToken);

        if (response != null && response["isSuccess"] == true) {
          var results = response["results"];
          categoryPosts.addAll(results["postList"]); // 현재 페이지 데이터 추가
          totalPages = results["totalPage"]; // 전체 페이지 수 업데이트
          currentPage++; // 다음 페이지로 이동
        } else {
          debugPrint("게시글 조회 실패: ${response["message"]}");
          break;
        }
      }
    } catch (e) {
      debugPrint("게시글 목록 조회 중 오류 발생: $e");
    }

    return categoryPosts;
  }

  /// 이미지 업로드 API
  /// 서버에 이미지 업로드 후 `imageId` 반환
  /// API: api/v1/image
  static Future<int?> uploadImage(File imageFile) async {
    String apiUrl = '$baseUrl/api/v1/image';
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
      ..headers['Authorization'] = 'Bearer $accessToken'
      ..files.add(await http.MultipartFile.fromPath('file', imageFile.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = jsonDecode(responseBody);
        if (jsonResponse['isSuccess']) {
          return jsonResponse['results']['imageId']; // imageId 반환
        }
      }
      debugPrint('이미지 업로드 실패: ${response.statusCode}');
    } catch (e) {
      debugPrint('이미지 업로드 중 예외 발생: $e');
    }
    return null; // 실패 시 null 반환
  }

  /// 게시물 이미지 삭제 API
  /// API: `DELETE api/v1/image/{imageId}`
  static Future<bool> deleteImage(int imageId) async {
    String endPoint = 'api/v1/image/$imageId';
    int statusCode = await _deleteApi(endPoint);

    if (statusCode == 200) {
      debugPrint('이미지 삭제 성공');
      return true;
    } else {
      debugPrint('이미지 삭제 실패: $statusCode');
      return false;
    }
  }

  /// 게시물 작성 API (`multipart/form-data`)
  /// API: api/v1/post
  static Future<bool> createPost({
    required String title,
    required String content,
    required String type,
    List<int>? imageIds,
  }) async {
    String apiUrl = '$baseUrl/api/v1/post';

    try {
      // `post` JSON 데이터 생성
      Map<String, dynamic> postData = {
        "title": title,
        "content": content,
        "type": type,
        "imageIds": imageIds ?? [],
      };

      // JSON 데이터를 `utf8.encode()`로 변환 후 `MultipartFile.fromBytes()`로 추가
      var postJsonBytes = utf8.encode(jsonEncode(postData));

      var request = http.MultipartRequest('POST', Uri.parse(apiUrl))
        ..headers['Authorization'] = 'Bearer $accessToken'
        ..headers['accept'] = '*/*'
        ..files.add(http.MultipartFile.fromBytes(
          'post',
          postJsonBytes,
          filename: 'post.json',
        ));

      // 요청 보내기
      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      // 응답 처리
      if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint('게시물 작성 성공');
        return true;
      } else {
        debugPrint('게시물 작성 실패: (${response.statusCode}) $responseBody');
        return false;
      }
    } catch (e) {
      debugPrint('createPost Error: $e');
      return false;
    }
  }

  /// 게시글 상세 조회 API
  /// API: api/v1/post/{id}
  static Future<Map<String, dynamic>?> getPostDetail(int postId) async {
    final response =
        await _getApiWithHeader("api/v1/post/$postId", accessToken);

    if (response != null && response["isSuccess"] == true) {
      print("게시글 상세 조회 응답: $response"); // Debugging
      return response["results"]; // "results" 필드만 반환하도록 수정
    } else {
      print("게시글 조회 실패: ${response?["message"]}");
      return null;
    }
  }

  /// 내가 작성한 게시글 조회
  /// API: api/v1/user/posts
  static Future<List<int>> fetchMyPosts() async {
    String endPoint = 'api/v1/user/posts';
    var response = await _getApiWithHeader(endPoint, accessToken);

    if (response != null && response['isSuccess'] == true) {
      List<dynamic> posts = response['results']['postList'];

      List<int> myPostIds = posts.map<int>((post) => post['id']).toList();

      debugPrint("내가 작성한 게시글 ID 리스트: $myPostIds"); // 로그 추가

      return myPostIds; // 내가 작성한 게시글 ID 리스트 반환
    } else {
      debugPrint("내 게시글 조회 실패: ${response?['message']}");
      return [];
    }
  }

  /// 게시물 댓글 추가 API
  /// API: api/v1/post/{id}/comments
  static Future<bool> addComment(int postId, String content) async {
    String endpoint = 'api/v1/post/$postId/comments';
    Map<String, dynamic> jsonData = {
      "content": content,
    };

    try {
      final response = await postApiWithJson(endpoint, jsonData);

      if (response == 200) {
        debugPrint('댓글 추가 성공');
        return true;
      } else {
        debugPrint('댓글 추가 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('댓글 추가 중 예외 발생: $e');
      return false;
    }
  }

  /// 댓글 답글 추가 API
  /// API: api/v1/post/{id}/comments/{commentsId}/reply
  static Future<bool> addReply(
      int postId, int commentsId, String content) async {
    String endpoint = 'api/v1/post/$postId/comments/$commentsId/reply';
    Map<String, dynamic> jsonData = {
      "content": content,
    };

    try {
      final response = await postApiWithJson(endpoint, jsonData);

      if (response == 200) {
        debugPrint('댓글 추가 성공');
        return true;
      } else {
        debugPrint('댓글 추가 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('댓글 추가 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 좋아요 API
  /// API: api/v1/post/{id}/like
  static Future<bool> likePost(int postId) async {
    String endpoint = 'api/v1/post/$postId/like';

    try {
      final response = await _postApi(endpoint);

      if (response == 200) {
        debugPrint('게시물 좋아요');
        return true;
      } else {
        debugPrint('게시물 좋아요 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 좋아요 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 좋아요 취소 API
  /// API: api/v1/post/{id}/like
  static Future<bool> deleteLikedPost(int postId) async {
    String endPoint = 'api/v1/post/$postId/like';

    try {
      final response = await _deleteApi(endPoint);

      if (response == 200) {
        debugPrint('게시물 좋아요 취소');
        return true;
      } else {
        debugPrint('게시물 좋아요 취소 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 좋아요 취소 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 댓글 좋아요 API
  /// API: api/v1/post/{id}/comments/{commentId}/like
  static Future<bool> likeComment(int postId, int commentId) async {
    String endpoint = 'api/v1/post/$postId/comments/$commentId/like';

    try {
      final response = await _postApi(endpoint);

      if (response == 200) {
        debugPrint('게시물 댓글 좋아요');
        return true;
      } else {
        debugPrint('게시물 댓글 좋아요 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 댓글 좋아요 중 예외 발생: $e');
      return false;
    }
  }

  /// 댓글 좋아요 취소 API
  /// API: api/v1/post/{id}/comments/{commentId}/like
  static Future<bool> deleteLikedComment(int postId, int commentId) async {
    String endPoint = 'api/v1/post/$postId/comments/$commentId/like';

    try {
      final response = await _deleteApi(endPoint);

      if (response == 200) {
        debugPrint('댓글 좋아요 취소');
        return true;
      } else {
        debugPrint('댓글 좋아요 취소 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('댓글 좋아요 취소 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 스크랩 API
  /// API: api/v1/post/{id}/scrap
  static Future<bool> scrapPost(int postId) async {
    String endpoint = 'api/v1/post/$postId/scrap';

    try {
      final response = await _postApi(endpoint);

      if (response == 200) {
        debugPrint('게시물 스크랩');
        return true;
      } else {
        debugPrint('게시물 스크랩 좋아요 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 스크랩 좋아요 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 스크랩 취소 API
  /// API: api/v1/post/{id}/scrap
  static Future<bool> deletePostScrap(int postId) async {
    String endPoint = 'api/v1/post/$postId/scrap';

    try {
      final response = await _deleteApi(endPoint);

      if (response == 200) {
        debugPrint('게시물 스크랩 취소');
        return true;
      } else {
        debugPrint('게시물 스크랩 취소 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 스크랩 취소 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 수정 api
  /// API: api/v1/post/{id}
  static Future<bool> editPost(
      int postId, Map<String, dynamic> postData) async {
    String endpoint = 'api/v1/post/$postId';

    try {
      final response = await _patchApi(endpoint, jsonEncode(postData));

      if (response == 200) {
        debugPrint('게시물 수정 성공');
        return true;
      } else {
        debugPrint('게시물 수정 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 수정 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 댓글 수정 api
  /// API: api/v1/post/{id}/comments/{commentId}
  static Future<bool> editComment(
      int postId, int commentId, String content) async {
    String endpoint = 'api/v1/post/$postId/comments/$commentId';
    Map<String, dynamic> jsonData = {
      "content": content,
    };

    try {
      final response = await _patchApi(endpoint, jsonEncode(jsonData));

      if (response == 200) {
        debugPrint('댓글 수정 성공');
        return true;
      } else {
        debugPrint('댓글 수정 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('댓글 수정 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 삭제 api
  /// API: api/v1/post/{id}
  static Future<bool> deletePost(int postId) async {
    String endpoint = 'api/v1/post/$postId';

    try {
      final response = await _deleteApi(endpoint);

      if (response == 200) {
        debugPrint('게시물 삭제 성공');
        return true;
      } else {
        debugPrint('게시물 삭제 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('게시물 삭제 중 예외 발생: $e');
      return false;
    }
  }

  /// 게시물 댓글 삭제 api
  /// API: api/v1/post/{id}/comments/{commentId}
  static Future<bool> deleteComment(int postId, int commentId) async {
    String endpoint = 'api/v1/post/$postId/comments/$commentId';

    try {
      final response = await _deleteApi(endpoint);

      if (response == 200) {
        debugPrint('댓글 삭제 성공');
        return true;
      } else {
        debugPrint('댓글 삭제 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('댓글 삭제 중 예외 발생: $e');
      return false;
    }
  }

  /// 경제톡톡 목록 조회
  /// api: api/v1/post/toktok
  static Future<List<dynamic>> fetchTokLists(String sort) async {
    List<dynamic> tokPosts = [];
    int currentPage = 0;
    // int totalPages = 0; // 초기값 설정

    try {
      String endPoint = 'api/v1/post/toktok?page=$currentPage&sort=$sort';

      var response = await _getApiWithHeader(endPoint, accessToken);

      if (response != null && response["isSuccess"] == true) {
        var results = response["results"];
        tokPosts.addAll(results["toktokPreviewResponseList"]); // 현재 페이지 데이터 추가
        // totalPages = results["totalPage"]; // 전체 페이지 수 업데이트
        // currentPage++; // 다음 페이지로 이동
      } else {
        debugPrint("게시글 조회 실패: ${response["message"]}");
      }
    } catch (e) {
      debugPrint("게시글 목록 조회 중 오류 발생: $e");
    }

    return tokPosts;
  }

  /// 경제톡톡 게시물 상세 조회 API
  /// API: api/v1/post/toktok/{id}
  static Future<Map<String, dynamic>?> getTokDetail(int postId) async {
    final response =
        await _getApiWithHeader("api/v1/post/toktok/$postId", accessToken);

    if (response != null && response["isSuccess"] == true) {
      print("경제톡톡 게시글 상세 조회 응답: $response"); // Debugging
      return response["results"]; // "results" 필드만 반환하도록 수정
    } else {
      print("경제톡톡 게시글 조회 실패: ${response?["message"]}");
      return null;
    }
  }

  /// 오늘의 경제톡톡 주제 조회
  /// API: api/v1/post/toktok-today
  static Future<Map<String, dynamic>?> getTodaysTok() async {
    final response =
        await _getApiWithHeader("api/v1/post/toktok-today", accessToken);

    if (response != null && response["isSuccess"] == true) {
      print("오늘의 경제톡톡 조회 응답: $response"); // Debugging
      return response["results"]; // "results" 필드만 반환하도록 수정
    } else {
      print("오늘의 경제톡톡 조회 실패: ${response?["message"]}");
      return null;
    }
  }

  /// 알림 조회
  /// API: api/v1/notification
  Future<dynamic> getNotification() async {
    String endpoint = 'api/v1/notification';

    try {
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('알림 데이터 로드 성공');
        return response;
      } else {
        debugPrint('알림 데이터 로드 실패');
        return null;
      }
    } catch (e) {
      debugPrint('getNotification Error: $e');
      return null;
    }
  }

  /// 알림 삭제
  /// API: api/v1/notification/{notificationId}
  Future<bool> deleteNotification(int notificationId) async {
    String endpoint = 'api/v1/notification/$notificationId';

    try {
      final response = await _deleteApi(endpoint);

      if (response == 200) {
        debugPrint('알림 삭제 성공');
        return true;
      } else {
        debugPrint('알림 삭제 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('알림 삭제 중 예외 발생: $e');
      return false;
    }
  }

  /// 최근 검색어 조회
  /// API: api/v1/notification
  Future<dynamic> getRecentSearch() async {
    String endpoint = 'api/v1/search/recent';

    try {
      final response = await _getApiWithHeader(endpoint, accessToken);

      if (response != null && response is Map<String, dynamic>) {
        debugPrint('최근 검색어 데이터 로드 성공');
        return response;
      } else {
        debugPrint('최근 검색어 데이터 로드 실패');
        return null;
      }
    } catch (e) {
      debugPrint('getRecentSearch Error: $e');
      return null;
    }
  }

  /// 검색어 삭제
  /// API: api/v1/search/recent
  Future<bool> deleteRecentSearch(String keyword) async {
    String endpoint = 'api/v1/search/recent?keyword=$keyword';

    try {
      final response = await _deleteApi(endpoint);

      if (response == 200) {
        debugPrint('검색어 삭제 성공');
        return true;
      } else {
        debugPrint('검색어 삭제 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('검색어 삭제 중 예외 발생: $e');
      return false;
    }
  }

  /// 검색어 전체 삭제
  /// API: api/v1/search/recent/all
  Future<bool> deleteRecentSearchAll() async {
    String endpoint = 'api/v1/search/recent/all';

    try {
      final response = await _deleteApi(endpoint);

      if (response == 200) {
        debugPrint('검색어 전체 삭제 성공');
        return true;
      } else {
        debugPrint('검색어 전체 삭제 실패: (${response.statusCode} ${response.body})');
        return false;
      }
    } catch (e) {
      debugPrint('검색어 전체 삭제 중 예외 발생: $e');
      return false;
    }
  }

  /// 용어 검색
  /// api: api/v1/search/terms
  Future<List<dynamic>> searchTerms(String keyword) async {
    List<dynamic> searchResults = [];
    int currentPage = 0;
    int totalPages = 0; // 초기값 설정

    try {
      while (currentPage <= totalPages) {
        String endPoint =
            'api/v1/search/terms?keyword=$keyword&page=$currentPage';

        var response = await _getApiWithHeader(endPoint, accessToken);

        if (response != null && response["isSuccess"] == true) {
          var results = response["results"];
          searchResults.addAll(results["termList"]); // 현재 페이지 데이터 추가
          totalPages = results["totalPage"]; // 전체 페이지 수 업데이트
          currentPage++; // 다음 페이지로 이동
        } else {
          debugPrint("용어 검색 실패: ${response["message"]}");
          break;
        }
      }
    } catch (e) {
      debugPrint("용어 검색 중 오류 발생: $e");
    }

    return searchResults;
  }

  /// 게시글 검색
  /// api: api/v1/search/posts
  Future<List<dynamic>> searchPosts(String keyword) async {
    List<dynamic> searchResults = [];
    int currentPage = 0;
    int totalPages = 0; // 초기값 설정

    try {
      while (currentPage <= totalPages) {
        String endPoint =
            'api/v1/search/posts?keyword=$keyword&page=$currentPage';

        var response = await _getApiWithHeader(endPoint, accessToken);

        if (response != null && response["isSuccess"] == true) {
          var results = response["results"];
          searchResults.addAll(results["postList"]); // 현재 페이지 데이터 추가
          totalPages = results["totalPage"]; // 전체 페이지 수 업데이트
          currentPage++; // 다음 페이지로 이동
        } else {
          debugPrint("게시글 검색 실패: ${response["message"]}");
          break;
        }
      }
    } catch (e) {
      debugPrint("게시글 검색 중 오류 발생: $e");
    }

    return searchResults;
  }

  /// 뉴스 검색
  /// api: api/v1/search/news
  Future<List<dynamic>> searchNews(String keyword) async {
    List<dynamic> searchResults = [];
    int currentPage = 0;
    int totalPages = 0; // 초기값 설정

    try {
      while (currentPage <= totalPages) {
        String endPoint =
            'api/v1/search/news?keyword=$keyword&page=$currentPage';

        var response = await _getApiWithHeader(endPoint, accessToken);

        if (response != null && response["isSuccess"] == true) {
          var results = response["results"];
          searchResults.addAll(results["newsList"]); // 현재 페이지 데이터 추가
          totalPages = results["totalPage"]; // 전체 페이지 수 업데이트
          currentPage++; // 다음 페이지로 이동
        } else {
          debugPrint("기사 검색 실패: ${response["message"]}");
          break;
        }
      }
    } catch (e) {
      debugPrint("기사 검색 중 오류 발생: $e");
    }

    return searchResults;
  }

  /// api/v1/level-test/quiz
  /// 레벨 테스트 퀴즈 목록 조회
  Future<dynamic> getLevelTestQuizList() async {
    dynamic response;
    String endPoint = "api/v1/level-test/quiz";

    response = await _getApi(endPoint);

    if (response != null) {
      print("응답 데이터 : $response");
    } else {
      print("get 데이터 실패");
    }
    return response;
  }

  /// api/v1/level-test/result
  /// 레벨 테스트 결과 제출
  Future<dynamic> postLevelTestResult(
      List<Map<String, dynamic>> answersJson) async {
    String endPoint = "api/v1/level-test/result";
    Map<String, dynamic> requestBody = {
      "answers": answersJson,
    };

    print("post 안 : ${jsonEncode(requestBody)}");

    try {
      // API 요청 실행
      dynamic response =
          await postApiWithJsonReturnResponse(endPoint, requestBody);

      if (response != null) {
        debugPrint("레벨테스트 POST 성공: $response");
        return response; // 성공하면 응답 반환
      } else {
        debugPrint("레벨테스트 POST 실패");
      }
    } catch (e) {
      debugPrint("Error 발생: $e");
    }

    return null; // 실패 시 null 반환
  }
}
