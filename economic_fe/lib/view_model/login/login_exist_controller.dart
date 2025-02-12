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

  final String clientId = dotenv.env['CLIENT_ID']!;
  final String redirectUri = dotenv.env['REDIRECT_URI']!;

  void login() async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        User user = await UserApi.instance.me();
        OAuthToken token = await UserApi.instance.loginWithKakaoTalk();
        print("토큰${token.accessToken}");

        getlogin(token.accessToken);

        // toArticle();
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

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
