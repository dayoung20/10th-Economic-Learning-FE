import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/onboarding_slide.dart';
import 'package:economic_fe/view_model/onboarding_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 393),
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
                  subtitle: "개념 학습과 퀴즈로\n누구나 쉽게 경제를 학습해요!",
                  currentIdx: 0,
                ),
                OnboardingSlide(
                  title: "경제 뉴스와 AI챗봇",
                  subtitle: "최신 경제 기사를 확인하고\nAI에게 모르는 내용을 질문해요!",
                  currentIdx: 1,
                ),
                OnboardingSlide(
                  title: "커뮤니티 소통",
                  subtitle: "커뮤니티에서 내 의견을 공유하고\n다른 사람들과 토론해요!",
                  currentIdx: 2,
                ),
              ],
            ),
          ),
          Column(
            children: [
              CustomButton(
                text: "시작하기",
                onPress: () {
                  // final controller = Get.find<OnboardingCardController>();
                  controller.clickedTestBtn(context);
                },
                bgColor: Palette.buttonColorBlue,
              ),
              const SizedBox(
                height: 14,
              ),
              GestureDetector(
                onTap: () {
                  controller.clickedExistBtn();
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    '계정이 이미 있어요',
                    style: TextStyle(
                      color: Color(0xFF404040),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      letterSpacing: -0.35,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      )),
    );
  }
}
