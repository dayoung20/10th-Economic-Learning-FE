import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LoginExistController extends GetxController {
  // var levelTestAnswers = <LevelTestAnswerModel>[].obs;
  List<LevelTestAnswerModel> levelTestAnswers = [];

  // 카카오 앱 클라이언트 ID
  // String nativeAppKey = dotenv.env['NATIVE_APP_KEY']!;
  final String clientId = dotenv.env['CLIENT_ID']!;
  final String redirectUri = dotenv.env['REDIRECT_URI']!;

  // 1. 카카오 로그인 페이지로 리디렉션
  Future<void> openKakaoLogin() async {
    final url =
        'https://kauth.kakao.com/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUri&response_type=code';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // 2. 인증 코드로 액세스 토큰 요청
  Future<void> fetchAccessToken(String code) async {
    const tokenUrl = 'https://kauth.kakao.com/oauth/token';

    final response = await http.post(
      Uri.parse(tokenUrl),
      body: {
        'grant_type': 'authorization_code',
        'client_id': clientId,
        'redirect_uri': redirectUri,
        'code': code,
      },
    );

    if (response.statusCode == 200) {
      print('Access Token: ${response.body}');
      // 추가: 토큰 저장 및 활용 로직
    } else {
      print('Failed to fetch access token: ${response.body}');
    }
  }

  void login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        User user = await UserApi.instance.me();
        // print(
        //     '사용자 정보 요청 성공${user.id} ${user.kakaoAccount?.profile?.nickname} ${user.kakaoAccount?.email}');
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("토큰${token.accessToken}");

        // Get.toNamed('/', arguments: levelTestAnswers);

        getlogin(token.accessToken);

        // toArticle();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } else {
      try {
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  }

  // 4. 리디렉션된 URL에서 인증 코드 추출
  Future<String?> _getAuthorizationCodeFromRedirectUri() async {
    String? authorizationCode;

    // WebViewController 초기화
    final webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted) // 자바스크립트 허용
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.contains('code=')) {
              final Uri uri = Uri.parse(request.url);
              authorizationCode = uri.queryParameters['code'];
              Get.back(); // WebView 닫기
              return NavigationDecision.prevent; // 탐색 중단
            }
            return NavigationDecision.navigate; // 계속 탐색
          },
        ),
      )
      ..loadRequest(
          Uri.parse('http://localhost:3030/kakao/callback')); // 리디렉션 URL 로드

    // WebView 표시
    await Get.dialog(
      Scaffold(
        appBar: AppBar(
          title: const Text('카카오 로그인'),
        ),
        body: WebViewWidget(controller: webViewController),
      ),
    );

    return authorizationCode; // 추출된 인증 코드 반환
  }

  // 백엔드에서 토큰 받아오기
  Future<void> getlogin(String accessToken) async {
    try {
      print("start");

      dynamic response;

      response = await RemoteDataSource.getlogin(accessToken);
      print("response :::: ${response['results']}");
      await saveToken("accessToken", response['results']);
      // String? access = await getToken("accessToken");
      // print(access);
    } catch (e) {
      debugPrint("Error : $e");
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

  // 테스트용
  void toArticle() {
    Get.toNamed('/article');
  }
}
