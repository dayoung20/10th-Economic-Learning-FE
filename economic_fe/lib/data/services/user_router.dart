import 'package:economic_fe/view/screens/home_page.dart';
import 'package:economic_fe/view/screens/leveltest_result_page.dart';

import 'package:economic_fe/view/screens/onboarding_card_page.dart';

import 'package:economic_fe/view/screens/login_page.dart';

import 'package:economic_fe/view/screens/onboarding_page.dart';
import 'package:economic_fe/view/screens/test_multiple_choice_page.dart';
import 'package:economic_fe/view/screens/test_ox_page.dart';
import 'package:economic_fe/view/screens/test_page.dart';
import 'package:go_router/go_router.dart';

class UserRouter {
  static GoRouter getRouter() {
    return GoRouter(
      initialLocation: '/', // 초기 경로 설정
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const OnboardingPage(), // 홈 페이지
        ),
        GoRoute(
          path: '/onboarding',
          builder: (context, state) => const OnboardingCardPage(),
        ),
        GoRoute(
          path: '/test',
          builder: (context, state) => const TestPage(),
          routes: [
            GoRoute(
              path: 'multi',
              builder: (context, state) => const TestMultipleChoicePage(),
            ),
            GoRoute(
              path: 'ox',
              builder: (context, state) => const TestOxPage(),
            ),
          ],
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/leveltest_result',
          builder: (context, state) => const LeveltestResultPage(),
        ),
      ],
    );
  }
}
