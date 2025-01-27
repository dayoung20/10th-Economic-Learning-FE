import 'dart:io';

import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view_model/mypage/mypage_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MypageHomePage extends StatefulWidget {
  const MypageHomePage({super.key});

  @override
  State<MypageHomePage> createState() => _MypageHomePageState();
}

class _MypageHomePageState extends State<MypageHomePage> {
  final MypageHomeController controller = Get.put(MypageHomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'assets/icon.png',
              width: 25.88,
              height: 31.74,
            ),
            const SizedBox(
              width: 4,
            ),
            const Text(
              'Ripple',
              style: TextStyle(
                color: Color(0xFF111111),
                fontSize: 22.40,
                fontFamily: 'Palanquin',
                fontWeight: FontWeight.w400,
                letterSpacing: -0.45,
              ),
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {}, // 알림 화면으로
            child: const Icon(
              Icons.notifications_none,
              size: 24,
              color: Color(0xff1c1b1f),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20, left: 8),
            child: GestureDetector(
              onTap: () {}, // 설정 화면으로
              child: const Icon(
                Icons.settings_outlined,
                size: 24,
                color: Color(0xff1c1b1f),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 4),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  // 사용자 프로필 사진
                  SizedBox(
                    height: 81,
                    child: Stack(
                      children: [
                        Container(
                          width: 81,
                          height: 81,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF3F3F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(43),
                            ),
                          ),
                          child: Obx(() {
                            return controller.selectedProfileImage.value != null
                                ? ClipOval(
                                    child: Image.file(
                                      File(controller
                                          .selectedProfileImage.value!),
                                      fit: BoxFit.cover,
                                      width: 81,
                                      height: 81,
                                    ),
                                  )
                                : const Icon(
                                    Icons.person,
                                    size: 35,
                                  );
                          }),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          // 카메라 버튼
                          child: GestureDetector(
                            onTap: () {
                              controller.selectProfileImage(context);
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 사용자 이름
                      Text(
                        '리플',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.50,
                        ),
                      ),
                      // 생년월일
                      Text(
                        '1996. 11. 18',
                        style: TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.30,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      // 한 줄 소개
                      Text(
                        '만나서 반가워요.',
                        style: TextStyle(
                          color: Color(0xFF404040),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.30,
                          letterSpacing: -0.35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 17),
              child: Row(
                children: [
                  // 직무
                  JobContainer(text: '개발자(프론트엔드/백엔드)'),
                  SizedBox(
                    width: 8,
                  ),
                  // 업종
                  JobContainer(text: '스타트업/벤처'),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      Text(
                        '연속 학습일',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                      SizedBox(
                        height: 11,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          // 연속 학습일 수
                          Text(
                            '3',
                            style: TextStyle(
                              color: Color(0xFF2AD6D6),
                              fontSize: 32,
                              fontWeight: FontWeight.w600,
                              height: 0.80,
                            ),
                          ),
                          Text(
                            '일째',
                            style: TextStyle(
                              color: Color(0xFF4A4A4A),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 0.80,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 76,
                    color: const Color(0xffa2a2a2),
                  ),
                  const Column(
                    children: [
                      Text(
                        '나의 레벨',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      // 나의 레벨
                      Text(
                        '중급',
                        style: TextStyle(
                          color: Color(0xFF2AD6D6),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.30,
                          letterSpacing: -0.60,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 1,
                    height: 76,
                    color: const Color(0xffa2a2a2),
                  ),
                  const Column(
                    children: [
                      Text(
                        '퀴즈 정답률',
                        style: TextStyle(
                          color: Color(0xFF4A4A4A),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 0.80,
                        ),
                      ),
                      SizedBox(
                        height: 9,
                      ),
                      // 퀴즈 정답률
                      Text(
                        '75%',
                        style: TextStyle(
                          color: Color(0xFF2AD6D6),
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1.30,
                          letterSpacing: -0.60,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(7, (index) {
                  final days = ['일', '월', '화', '수', '목', '금', '토'];
                  return DailyCheck(
                    day: days[index],
                    isChecked: controller.isCheckedList[index], // 첫 번째 항목만 true
                  );
                }),
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            MyContentsContainer(
              title: '나의 학습',
              subTitle: '스크랩 한 퀴즈, 학습, 틀린 문제를 확인해요',
              onTap: () {},
            ),
            const SizedBox(
              height: 12,
            ),
            MyContentsContainer(
              title: '커뮤니티 활동',
              subTitle: '스크랩 및 좋아요 한 커뮤니티 내용을 확인해요',
              onTap: () {},
            ),
            const SizedBox(
              height: 12,
            ),
            MyContentsContainer(
              title: '스크랩 한 기사',
              subTitle: '스크랩 한 기사 내용을 확인해요',
              onTap: () {
                Get.toNamed('/mypage/article');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class MyContentsContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final Function() onTap;

  const MyContentsContainer({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width - 32,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFA2A2A2)),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.30,
                letterSpacing: -0.35,
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              subTitle,
              style: const TextStyle(
                color: Color(0xFF404040),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.30,
                letterSpacing: -0.30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DailyCheck extends StatelessWidget {
  final String day;
  final bool isChecked;

  const DailyCheck({
    super.key,
    required this.day,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: const TextStyle(
            color: Color(0xFF111111),
            fontSize: 12,
            fontFamily: 'Noto',
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 6,
        ),
        Container(
          width: 38,
          height: 38,
          decoration: ShapeDecoration(
            color:
                isChecked ? const Color(0xFF2AD6D6) : const Color(0xfff2f3f5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36),
            ),
          ),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              padding: const EdgeInsets.all(2),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Icon(
                Icons.check,
                color: isChecked
                    ? const Color(0xFF2AD6D6)
                    : const Color(0xfff2f3f5),
                size: 15,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class JobContainer extends StatelessWidget {
  final String text;

  const JobContainer({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFA2A2A2)),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF767676),
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.50,
          letterSpacing: -0.30,
        ),
      ),
    );
  }
}
