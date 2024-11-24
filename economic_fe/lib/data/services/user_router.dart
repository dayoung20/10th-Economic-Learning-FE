import 'package:economic_fe/view/screens/home_page.dart';
import 'package:economic_fe/view/screens/onboarding_page.dart';
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
      ],
    );
  }
}
