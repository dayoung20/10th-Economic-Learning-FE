import 'package:economic_fe/view/screens/home_page.dart';
import 'package:economic_fe/view/screens/learning_set/learning_list_page.dart';
import 'package:economic_fe/view/screens/leveltest_result_page.dart';

import 'package:economic_fe/view/screens/onboarding/onboarding_card_page.dart';

import 'package:economic_fe/view/screens/login_page.dart';

import 'package:economic_fe/view/screens/onboarding/onboarding_page.dart';
import 'package:economic_fe/view/screens/profile_setting/basic_info_page.dart';
import 'package:economic_fe/view/screens/profile_setting/job_select_page.dart';
import 'package:economic_fe/view/screens/profile_setting/part_select_page.dart';
import 'package:economic_fe/view/screens/profile_setting/profile_setting_page.dart';
import 'package:economic_fe/view/screens/quiz/level_select_page.dart';
import 'package:economic_fe/view/screens/quiz/quiz_page.dart';
import 'package:economic_fe/view/screens/test_multiple_choice_page.dart';
import 'package:economic_fe/view/screens/test_ox_page.dart';
import 'package:economic_fe/view/screens/test_page.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:go_router/go_router.dart';

// class UserRouter {
//   static GoRouter getRouter() {
//     return GoRouter(
//       initialLocation: '/', // 초기 경로 설정
//       routes: [
//         GoRoute(
//           path: '/',
//           builder: (context, state) => const OnboardingPage(), // 홈 페이지
//         ),
//         GoRoute(
//           path: '/onboarding',
//           builder: (context, state) => const OnboardingCardPage(),
//         ),
//         GoRoute(
//           path: '/test',
//           builder: (context, state) => const TestPage(),
//           routes: [
//             GoRoute(
//               path: 'multi',
//               builder: (context, state) => const TestMultipleChoicePage(),
//             ),
//             GoRoute(
//               path: 'ox',
//               builder: (context, state) => const TestOxPage(),
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '/leveltest_result',
//           builder: (context, state) => const LeveltestResultPage(),
//         ),
//         GoRoute(
//           path: '/login',
//           builder: (context, state) => const LoginPage(),
//         ),
//         GoRoute(
//           path: '/profile_setting',
//           builder: (context, state) => const ProfileSettingPage(),
//           routes: [
//             GoRoute(
//               path: 'basic',
//               builder: (context, state) => const BasicInfoPage(),
//             ),
//             GoRoute(
//               path: 'job',
//               builder: (context, state) => const JobSelectPage(),
//             ),
//             GoRoute(
//               path: 'part',
//               builder: (context, state) => const PartSelectPage(),
//             ),
//           ],
//         ),
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const HomePage(),
//         ),
//         GoRoute(
//             path: '/learning_list',
//             builder: (context, state) => const LearningListPage(),
//             routes: [
//               GoRoute(
//                   path: 'quiz_level',
//                   builder: (context, state) => const LevelSelectPage(),
//                   routes: [
//                     GoRoute(
//                       path: 'quiz',
//                       builder: (context, state) => const QuizPage(),
//                     )
//                   ])
//             ]),
//       ],
//     );
//   }
// }

// GetX의 라우터를 사용하는 방식
class UserRouter {
  static List<GetPage> getPages() {
    return [
      GetPage(name: '/', page: () => const OnboardingPage()), // 홈 페이지
      GetPage(name: '/onboarding', page: () => const OnboardingCardPage()),
      GetPage(
        name: '/test',
        page: () => const TestPage(),
        children: [
          GetPage(name: '/multi', page: () => const TestMultipleChoicePage()),
          GetPage(name: '/ox', page: () => const TestOxPage()),
        ],
      ),
      GetPage(
          name: '/leveltest_result', page: () => const LeveltestResultPage()),
      GetPage(name: '/login', page: () => const LoginPage()),
      GetPage(
        name: '/profile_setting',
        page: () => const ProfileSettingPage(),
        children: [
          GetPage(name: '/basic', page: () => const BasicInfoPage()),
          GetPage(name: '/job', page: () => const JobSelectPage()),
          GetPage(name: '/part', page: () => const PartSelectPage()),
        ],
      ),
      GetPage(name: '/home', page: () => const HomePage()),
      GetPage(
        name: '/learning_list',
        page: () => const LearningListPage(),
        children: [
          GetPage(
            name: '/quiz_level',
            page: () => const LevelSelectPage(),
            children: [
              GetPage(name: '/quiz', page: () => const QuizPage()),
            ],
          ),
        ],
      ),
    ];
  }
}
