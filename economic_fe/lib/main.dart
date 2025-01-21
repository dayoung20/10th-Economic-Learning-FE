import 'package:economic_fe/data/services/user_router.dart';
import 'package:economic_fe/view/screens/onboarding/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  //await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(const RippleApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     // return GetMaterialApp(
//     //   title: '경제 지식 앱',
//     //   theme: ThemeData(
//     //     primarySwatch: Colors.blue,
//     //   ),
//     //   home: const Text("test11"),
//     // );
//     // return OnboardingPage();
//     // return const MaterialApp(
//     //   home: OnboardingPage(),
//     // );
//     runApp(const RippleApp());
//   }
// }

// class RippleApp extends StatelessWidget {
//   const RippleApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       routerConfig: UserRouter.getRouter(),
//     );
//   }
// }

class RippleApp extends StatelessWidget {
  const RippleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Ripple',
      initialRoute: '/test',
      getPages: UserRouter.getPages(), // 라우트 설정
    );
  }
}
