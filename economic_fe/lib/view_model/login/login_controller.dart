import 'dart:convert';

import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/data/services/remote_data_source.dart';
import 'package:economic_fe/view_model/notification/push_notification_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // late BuildContext context;
  // static LoginController get to => Get.find();

  // void getStats() {
  //   // 통계 데이터 로드 또는 초기화 작업
  //   print("Stats initialized!");
  // }

  // void clickedLoginBtn() {
  //   //context.go('/test');
  //   Get.toNamed('/login/agreement');
  // }

  // var levelTestAnswers = <LevelTestAnswerModel>[].obs;
  List<LevelTestAnswerModel> levelTestAnswers = [];
  final arguments = Get.arguments as Map<String, dynamic>;
  List<LevelTestAnswerModel> answers = [];
  List<QuizModel> quizList = [];

  @override
  void onInit() {
    super.onInit();

    answers = arguments['levelTestAnswers'];
    quizList = arguments['quizList'];
  }

  // final String clientId = dotenv.env['CLIENT_ID']!;
  // final String redirectUri = dotenv.env['REDIRECT_URI']!;

  Future<void> login() async {
    try {
      // 카카오톡 또는 계정 로그인
      OAuthToken token;
      if (await isKakaoTalkInstalled()) {
        token = await UserApi.instance.loginWithKakaoTalk();
      } else {
        token = await UserApi.instance.loginWithKakaoAccount();
      }

      String kakaoAccessToken = token.accessToken;
      print("카카오 로그인 성공, accessToken: $kakaoAccessToken");

      // 백엔드에 카카오 토큰 전송 후 서버 인증 토큰 받아오기
      await getlogin(kakaoAccessToken);
    } catch (error) {
      print("카카오 로그인 실패: $error");
    }
  }

  // 백엔드에서 토큰 받아오기
  Future<void> getlogin(String accessToken) async {
    try {
      print("백엔드 로그인 요청 시작");

      // HTTP GET 요청 실행
      http.Response? response = await RemoteDataSource.getlogin(accessToken);

      if (response == null) {
        print("백엔드 응답 없음 (로그인 실패)");
        Get.snackbar("로그인 실패", "서버와의 연결이 원활하지 않습니다.");
        return;
      }

      // 응답 상태 코드 확인
      if (response.statusCode == 200) {
        // response.body를 JSON으로 변환 후 Map 형태로 저장
        Map<String, dynamic> responseData = jsonDecode(response.body);

        // 서버 응답이 성공적인지 확인
        if (responseData["isSuccess"] == true &&
            responseData.containsKey("results")) {
          String serverToken = responseData["results"]; // 실제 accessToken

          // 토큰 저장 (자동 로그인 유지)
          await saveToken("accessToken", serverToken);
          await saveLoginState(true);

          print("백엔드 인증 성공, 저장된 accessToken: $serverToken");

          // 로그인 성공 후 다음 화면으로 이동
          Get.toNamed("login/agreement", arguments: {
            'levelTestAnswers': answers,
            'quizList': quizList,
          });
        } else {
          print("백엔드 인증 실패: ${responseData["message"] ?? "응답 데이터 없음"}");
          Get.snackbar("로그인 실패", responseData["message"] ?? "알 수 없는 오류 발생");
        }
      } else {
        print("로그인 실패: ${response.statusCode}, 응답 본문: ${response.body}");
        Get.snackbar("로그인 실패", "서버 응답 오류: ${response.statusCode}");
      }
    } catch (e) {
      debugPrint("백엔드 로그인 요청 실패: $e");
      Get.snackbar("로그인 오류", "네트워크 오류가 발생했습니다.");
    }
  }

  // 로그인 상태 저장
  Future<void> saveLoginState(bool isLoggedIn) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLoggedIn", isLoggedIn);
  }

  // 자동 로그인 상태 확인
  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }

  /// 로그아웃 (토큰 삭제 + SSE 해제)
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("accessToken");
    await prefs.setBool("isLoggedIn", false);

    // SSE 연결 해제
    // Get.find<PushNotificationController>().disconnectSse();

    // 로그인 화면으로 이동
    Get.offAllNamed("/login");
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
