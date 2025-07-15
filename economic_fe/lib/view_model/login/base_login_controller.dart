import 'dart:convert';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_auth/kakao_flutter_sdk_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/data/services/sse_manager.dart';

abstract class BaseLoginController extends GetxController {
  late final AppLinks _appLinks;
  bool _isRedirectHandled = false;

  final String redirectUri = 'kakao${dotenv.env['NATIVE_APP_KEY']}://oauth';

  @override
  void onInit() {
    super.onInit();
    _appLinks = AppLinks();
    _listenToAppLinks();
  }

  /// 로그인 시작 (authorize + token 발급)
  Future<void> login() async {
    try {
      final authCode = await AuthCodeClient.instance.authorize(
        redirectUri: redirectUri,
      );
      debugPrint('인가코드 발급 성공: $authCode');

      final token = await AuthApi.instance.issueAccessToken(
        authCode: authCode,
        redirectUri: redirectUri,
      );
      debugPrint('토큰 발급 성공: ${token.accessToken}');

      await _loginToBackend(token.accessToken);
    } catch (e) {
      debugPrint('로그인 실패: $e');
    }
  }

  void _listenToAppLinks() async {
    // cold start 시에도 URI 가져오기
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null && !_isRedirectHandled) {
      debugPrint("초기 앱 링크 수신: $initialUri");
      _isRedirectHandled = true;
      await _handleRedirectUri(initialUri);
    }

    // 이후 URI 수신 스트림 구독
    _appLinks.uriLinkStream.listen((uri) async {
      debugPrint("앱 링크 수신: $uri");
      if (_isRedirectHandled) return;

      if (uri.scheme.startsWith("kakao") &&
          uri.host == "oauth" &&
          uri.queryParameters.containsKey("code")) {
        _isRedirectHandled = true;
        await _handleRedirectUri(uri);
      }
    });
  }

  Future<void> _handleRedirectUri(Uri uri) async {
    try {
      final code = uri.queryParameters['code'];
      if (code == null) return;

      final token = await AuthApi.instance.issueAccessToken(
        authCode: code,
        redirectUri: redirectUri,
      );
      debugPrint('리디렉션 토큰 발급 성공: ${token.accessToken}');

      await _loginToBackend(token.accessToken);
    } catch (e) {
      debugPrint("리디렉션 처리 실패: $e");
    }
  }

  Future<void> _loginToBackend(String kakaoAccessToken) async {
    try {
      debugPrint("백엔드 로그인 요청");

      final response = await RemoteDataSource.getlogin(kakaoAccessToken);
      if (response == null || response.statusCode != 200) {
        debugPrint("로그인 실패: 서버 응답 없음");
        return;
      }

      final data = jsonDecode(response.body);
      if (data["isSuccess"] != true || !data.containsKey("results")) {
        debugPrint("로그인 실패: 응답 이상");
        return;
      }

      final serverToken = data["results"];
      await _saveToken("accessToken", serverToken);
      await _saveLoginState(true);

      await SSEManager().connectIfNeeded();

      onLoginSuccess(); // 🔁 추상 메서드
    } catch (e) {
      debugPrint("서버 로그인 오류: $e");
    }
  }

  /// 개별 화면마다 성공 후 동작 정의
  void onLoginSuccess();

  Future<void> _saveLoginState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", value);
  }

  Future<void> _saveToken(String key, String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, token);
  }

  /// 로그아웃 (선택적 사용)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.setBool("isLoggedIn", false);
    await SSEManager().dispose();
    Get.offAllNamed("/login");
  }
}
