import 'package:economic_fe/data/services/user_router.dart';
import 'package:economic_fe/data/services/validate_access_token.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ko', null); // 로캘 초기화

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
    return ScreenUtilInit(
      designSize: const Size(360, 740),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Ripple',
          initialRoute: isLoggedIn ? '/home' : '/',
          // initialRoute: '/leveltest_result/answer',
          getPages: UserRouter.getPages(),
          builder: (context, widget) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                  textScaler: const TextScaler.linear(1.0)), // 시스템 폰트 크기 조절 방지
              child: widget!,
            );
          },
        );
      },
    );
  }
}
