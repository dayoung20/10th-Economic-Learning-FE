import 'package:economic_fe/view/screens/article/article_detail_page.dart';
import 'package:economic_fe/view/screens/article/article_list_page.dart';
import 'package:economic_fe/view/screens/chatbot_page.dart';
import 'package:economic_fe/view/screens/community/community_page.dart';
import 'package:economic_fe/view/screens/community/new_post_page.dart';
import 'package:economic_fe/view/screens/finish_page.dart';
import 'package:economic_fe/view/screens/learning_set/learning_concept_total_page.dart';
import 'package:economic_fe/view/screens/community/detail_page.dart';
import 'package:economic_fe/view/screens/community/talk_detail_page.dart';

import 'package:economic_fe/view/screens/login/agreement_detail_page.dart';
import 'package:economic_fe/view/screens/login/agreement_page.dart';
import 'package:economic_fe/view/screens/dictionary_page.dart';

import 'package:economic_fe/view/screens/home_page.dart';
import 'package:economic_fe/view/screens/learning_set/learning_list_page.dart';
import 'package:economic_fe/view/screens/leveltest_result_page.dart';
import 'package:economic_fe/view/screens/login/login_exist_page.dart';
import 'package:economic_fe/view/screens/mypage/mypage_home_page.dart';

import 'package:economic_fe/view/screens/onboarding/onboarding_card_page.dart';

import 'package:economic_fe/view/screens/login/login_page.dart';

import 'package:economic_fe/view/screens/onboarding/onboarding_page.dart';
import 'package:economic_fe/view/screens/profile_setting/basic_info_page.dart';
import 'package:economic_fe/view/screens/profile_setting/job_select_page.dart';
import 'package:economic_fe/view/screens/profile_setting/part_select_page.dart';
import 'package:economic_fe/view/screens/profile_setting/profile_setting_page.dart';
import 'package:economic_fe/view/screens/quiz/level_select_page.dart';
import 'package:economic_fe/view/screens/quiz/quiz_page.dart';
import 'package:economic_fe/view/screens/test_answer_page.dart';
import 'package:economic_fe/view/screens/test_multiple_choice_page.dart';
import 'package:economic_fe/view/screens/test_ox_page.dart';
import 'package:economic_fe/view/screens/test_page.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

// GetX의 라우터를 사용하는 방식
class UserRouter {
  static List<GetPage> getPages() {
    return [
      GetPage(
        name: '/',
        page: () => const OnboardingPage(),
      ), // 홈 페이지
      GetPage(
        name: '/onboarding',
        page: () => const OnboardingCardPage(),
      ),
      GetPage(
        name: '/test',
        page: () => const TestPage(),
        children: [
          GetPage(
            name: '/multi',
            page: () => const TestMultipleChoicePage(),
          ),
          GetPage(
            name: '/ox',
            page: () => const TestOxPage(),
          ),
        ],
      ),
      GetPage(
          name: '/leveltest_result',
          page: () => const LeveltestResultPage(),
          children: [
            GetPage(
              name: '/answer',
              page: () => const TestAnswerPage(),
            ),
          ]),
      // 카카오로 시작하기
      GetPage(
        name: '/login',
        page: () => const LoginPage(),
        children: [
          GetPage(
            name: '/agreement',
            page: () => const AgreementPage(),
            children: [
              GetPage(name: '/detail', page: () => const AgreementDetailPage())
            ],
          ),
        ],
      ),
      // 카카오 로그인
      GetPage(
        name: '/login_exist',
        page: () => const LoginExistPage(),
      ),
      GetPage(
        name: '/profile_setting',
        page: () => const ProfileSettingPage(),
        children: [
          GetPage(
            name: '/basic',
            page: () => const BasicInfoPage(),
          ),
          GetPage(
            name: '/job',
            page: () => const JobSelectPage(),
          ),
          GetPage(
            name: '/part',
            page: () => const PartSelectPage(),
          ),
        ],
      ),
      GetPage(
        name: '/home',
        page: () => const HomePage(),
      ),
      GetPage(
        name: '/learning_list',
        page: () => const LearningListPage(),
        children: [
          GetPage(
            name: '/quiz_level',
            page: () => const LevelSelectPage(),
            children: [
              GetPage(
                name: '/quiz',
                page: () => const QuizPage(),
              ),
            ],
          ),
          GetPage(
            name: '/learning_concept',
            page: () => const LearningConceptTotalPage(),
          ),
        ],
      ),
      GetPage(
        name: '/chatbot',
        page: () => const ChatbotPage(),
      ),
      GetPage(
        name: '/dictionary',
        page: () => const DictionaryPage(),
      ),
      // 커뮤니티 탭
      GetPage(
        name: '/community',
        page: () => const CommunityPage(),
        children: [
          // 경제 톡톡 세부 페이지
          GetPage(
            name: '/talk_detail',
            page: () => const TalkDetailPage(),
          ),
          // 일반 게시판 세부 페이지
          GetPage(
            name: '/detail',
            page: () => const DetailPage(),
          ),
          // 게시글 작성 페이지
          GetPage(
            name: '/new_post',
            page: () => const NewPostPage(),
          ),
        ],
      ),
      // 경제 기사
      GetPage(
        name: '/article',
        page: () => const ArticleListPage(),
        children: [
          // 기사 세부 페이지
          GetPage(
            name: '/detail',
            page: () => const ArticleDetailPage(),
          ),
        ],
      ),
      // 완료 페이지
      GetPage(
        name: '/finish',
        page: () => const FinishPage(),
      ),
      // 마이페이지
      GetPage(
        name: '/mypage',
        page: () => const MypageHomePage(),
      ),
    ];
  }
}
