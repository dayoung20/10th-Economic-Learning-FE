import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LeveltestResultPage extends StatefulWidget {
  const LeveltestResultPage({super.key});

  @override
  State<LeveltestResultPage> createState() => _LeveltestResultPageState();
}

class _LeveltestResultPageState extends State<LeveltestResultPage> {
  String name = '리플'; // 사용자 이름
  String level = 'Intermediate'; // 레벨테스트 결과 - 영어
  String levelKor = '중급'; // 레벨테스트 결과 - 한국어
  int correctNum = 5; // 맞춘 문제 개수

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: ScreenUtils.getHeight(context, 60),
          ),
          Center(
            child: Text(
              '$name님의 레벨테스트 결과는?',
              style: Palette.pretendard(
                context,
                const Color(0xFF111111),
                20,
                FontWeight.w600,
                1.3,
                -0.5,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 18),
          ),
          Container(
            width: ScreenUtils.getWidth(context, 360),
            height: ScreenUtils.getHeight(context, 164),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/leveltest_result_bg.png'),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  level,
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF1DB691),
                    20,
                    FontWeight.w500,
                    1.2,
                    -0.5,
                  ),
                ),
                Text(
                  levelKor,
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF1DB691),
                    28,
                    FontWeight.w700,
                    1.2,
                    -0.5,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 22),
          ),
          Container(
            width: ScreenUtils.getWidth(context, 327),
            height: ScreenUtils.getHeight(context, 247),
            padding: const EdgeInsets.all(24),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFA2A2A2)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '나의 학습 레벨',
                  style: Palette.pretendard(
                    context,
                    Colors.black,
                    16,
                    FontWeight.w400,
                    1.4,
                    -0.4,
                  ),
                ),
                Text(
                  level,
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF1DB691),
                    28,
                    FontWeight.w700,
                    1.2,
                    -0.7,
                  ),
                ),
                SizedBox(
                  width: ScreenUtils.getWidth(context, 279),
                  child: Text(
                    '리플님은 중급 단계로 수준이 어쩌고 저쩌고 해서 이렇게 됩니다. 경제 단계에 대한 기초 지식이 풍부하시군요. 하지만 어쩌고는 부족하네요. 이럴 경우 일반 경제 국제 경제 어쩌고 파트를 조금 더 집중적으로 공부하셔서 실력을 기르시는게 좋아요.',
                    style: Palette.pretendard(
                      context,
                      const Color(0xFF111111),
                      16,
                      FontWeight.w400,
                      1.4,
                      -0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 12),
          ),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '9문제 중 총 ',
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF111111),
                    14,
                    FontWeight.w400,
                    1.4,
                    -0.35,
                  ),
                ),
                Text(
                  '$correctNum문제',
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF067BD5),
                    14,
                    FontWeight.w600,
                    1.4,
                    -0.35,
                  ),
                ),
                Text(
                  '를 맞혔습니다!',
                  style: Palette.pretendard(
                    context,
                    const Color(0xFF111111),
                    14,
                    FontWeight.w400,
                    1.4,
                    -0.35,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 22),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 132),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  text: '해설보기',
                  onPress: () {},
                  bgColor: Palette.buttonColorGreen,
                ),
                CustomButton(
                  text: '시작하기',
                  onPress: () {},
                  bgColor: Palette.buttonColorBlue,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
