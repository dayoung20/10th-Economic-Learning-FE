import 'package:economic_fe/data/models/user_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/onboarding_slide.dart';
import 'package:economic_fe/view_model/onboarding_card_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class OnboardingCardPage extends StatefulWidget {
  const OnboardingCardPage({super.key});

  @override
  State<OnboardingCardPage> createState() => _OnboardingCardPageState();
}

class _OnboardingCardPageState extends State<OnboardingCardPage> {
  late final OnboardingCardController controller;
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    controller = Get.put(OnboardingCardController()..getStats());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index; // 값을 변경할 수 있음
                });
              },
              children: const [
                OnboardingSlide(
                  title: "학습과 퀴즈로 누구나 쉽게",
                  subtitle: "개념 학습과 퀴즈로\n누구나 쉽게 경제 학습이 가능해요.",
                  currentIdx: 0,
                ),
                OnboardingSlide(
                  title: "경제 뉴스와 AI챗봇",
                  subtitle: "최신 경제 기사 확인하고\nAI로 모르는 내용 확인해요.",
                  currentIdx: 1,
                ),
                OnboardingSlide(
                  title: "커뮤니티 소통",
                  subtitle: "커뮤니티에서 다른 사람들과\n토론해요!",
                  currentIdx: 2,
                ),
              ],
            ),
          ),
          CustomButton(
            text: "시작하기",
            onPress: () {
              // final controller = Get.find<OnboardingCardController>();
              controller.clickedTestBtn(context);
            },
            bgColor: Palette.buttonColorBlue,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomButton(
            text: "계정이 이미 있어요",
            onPress: () {},
            bgColor: Palette.buttonColorGreen,
          ),
        ],
      )),
    );
  }
}

// class OnboardingSlidePage extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final int currentIdx;

//   const OnboardingSlidePage(
//       {super.key,
//       required this.title,
//       required this.subtitle,
//       required this.currentIdx});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         const Placeholder(fallbackHeight: 200, fallbackWidth: 200), // 이미지 자리
//         const SizedBox(height: 30),
//         Text(
//           title,
//           style: Palette.cardTitle,
//         ),
//         const SizedBox(height: 10),
//         Text(
//           subtitle,
//           textAlign: TextAlign.center,
//           style: Palette.cardSub,
//         ),
//         const SizedBox(
//           height: 3,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//                 width: currentIdx == 0 ? 32 : 8,
//                 height: 8,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: currentIdx == 0
//                         ? const Color(0xff767676)
//                         : const Color(0xff2ad6d6))),
//             const SizedBox(
//               width: 2,
//             ),
//             Container(
//                 width: currentIdx == 1 ? 32 : 8,
//                 height: 8,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: currentIdx == 1
//                         ? const Color(0xff767676)
//                         : const Color(0xff2ad6d6))),
//             const SizedBox(
//               width: 2,
//             ),
//             Container(
//                 width: currentIdx == 2 ? 32 : 8,
//                 height: 8,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: currentIdx == 2
//                         ? const Color(0xff767676)
//                         : const Color(0xff2ad6d6))),
//             const SizedBox(
//               width: 2,
//             ),
//             Container(
//                 width: currentIdx == 3 ? 32 : 8,
//                 height: 8,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(100),
//                     color: currentIdx == 3
//                         ? const Color(0xff767676)
//                         : const Color(0xff2ad6d6))),
//           ],
//         ),
//       ],
//     );
//   }
// }
