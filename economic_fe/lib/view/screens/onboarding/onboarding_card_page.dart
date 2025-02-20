import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/onboarding_slide.dart';
import 'package:economic_fe/view_model/onboarding_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 50.h,
          ),
          SizedBox(
            height: 510.h,
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
                  image: 'assets/onboarding_card_1.png',
                ),
                OnboardingSlide(
                  title: "경제 뉴스와 AI챗봇",
                  subtitle: "최신 경제 기사를 확인하고\nAI에게 모르는 내용을 질문해요!",
                  currentIdx: 1,
                  image: 'assets/onboarding_card_2.png',
                ),
                OnboardingSlide(
                  title: "커뮤니티 소통",
                  subtitle: "커뮤니티에서 내 의견을 공유하고\n다른 사람들과 토론해요!",
                  currentIdx: 2,
                  image: 'assets/onboarding_card_3.png',
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: 32.h,
              ),
              CustomButton(
                text: "시작하기",
                onPress: () {
                  controller.clickedTestBtn(context);
                },
                bgColor: Palette.buttonColorBlue,
              ),
              SizedBox(
                height: 14.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.clickedExistBtn();
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  child: Text(
                    '계정이 이미 있어요',
                    style: TextStyle(
                      color: const Color(0xFF404040),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      decoration: TextDecoration.underline,
                      letterSpacing: -0.35.w,
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
