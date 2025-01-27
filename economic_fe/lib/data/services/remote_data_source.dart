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
    String authToken = dotenv.env['AUTHORIZATION_KEY']!; // 환경 변수에서 가져오기
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $authToken',
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
}
