import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

/// 토큰 검증 함수 (백엔드에 API 요청)
Future<bool> validateAccessToken() async {
  final String? accessToken = await getToken("accessToken");
  //기본 api 엔드포인트
  final String baseUrl = dotenv.env['API_URL']!;

  if (accessToken == null) {
    return false;
  }

  try {
    // 실제 API 엔드포인트를 사용하여 토큰 검증
    final response = await http.get(
      Uri.parse("$baseUrl/api/v1/user/info"), // 예제 엔드포인트
      headers: {"Authorization": "Bearer $accessToken"},
    );

    if (response.statusCode == 200) {
      print("토큰 유효함: $accessToken");
      return true;
    } else if (response.statusCode == 401) {
      print("토큰 만료됨: ${response.statusCode}");
      await logoutUser(); // 자동 로그아웃 실행
      return false;
    } else {
      print("알 수 없는 오류로 인해 토큰 검증 실패: ${response.statusCode}");
      return false;
    }
  } catch (e) {
    print("토큰 검증 실패: $e");
    return false;
  }
}

/// 로그아웃 처리 (토큰 삭제 + 로그인 화면으로 이동)
Future<void> logoutUser() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("accessToken");
  await prefs.setBool("isLoggedIn", false);
  Get.offAllNamed("/login");
}

/// SharedPreferences에서 accessToken을 가져오는 함수
Future<String?> getToken(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
