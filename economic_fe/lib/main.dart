import 'package:economic_fe/data/services/user_router.dart';
import 'package:economic_fe/view_model/notification/push_notification_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: '.env');
  String nativeAppKey = dotenv.env['NATIVE_APP_KEY']!;
  KakaoSdk.init(nativeAppKey: nativeAppKey);

  String? accessToken = await getToken("accessToken");

  runApp(RippleApp(accessToken: accessToken));
}

class RippleApp extends StatelessWidget {
  final String? accessToken;

  const RippleApp({super.key, required this.accessToken});

  @override
  Widget build(BuildContext context) {
    // 앱 실행 시 PushNotificationController를 전역적으로 실행 (SSE 연결 유지)
    if (accessToken != null) {
      Get.put(PushNotificationController(), permanent: true);
    }

    return GetMaterialApp(
      title: 'Ripple',
      initialRoute: accessToken != null ? '/home' : '/',
      getPages: UserRouter.getPages(),
    );
  }
}

/// SharedPreferences에서 accessToken을 가져오는 함수
Future<String?> getToken(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}
