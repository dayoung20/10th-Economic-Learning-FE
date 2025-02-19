import 'package:economic_fe/data/services/user_router.dart';
import 'package:economic_fe/data/services/validate_access_token.dart';
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

  // accessToken 유효성 검증
  bool isValidToken = await validateAccessToken();

  runApp(RippleApp(isLoggedIn: isValidToken));
}

class RippleApp extends StatelessWidget {
  final bool isLoggedIn;

  const RippleApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    // // 유효한 토큰이 있을 때만 SSE 실행
    // if (isLoggedIn) {
    //   Get.put(PushNotificationController(), permanent: true);
    // }

    return GetMaterialApp(
      title: 'Ripple',
      initialRoute: isLoggedIn ? '/home' : '/',
      // initialRoute: '/home',
      getPages: UserRouter.getPages(),
    );
  }
}
