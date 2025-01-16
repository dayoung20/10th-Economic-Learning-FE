import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CustomBottomBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5),
      decoration: const BoxDecoration(
        color: Palette.background,
        border: Border(
          top: BorderSide(
            color: Color(0xffa2a2a2), // 테두리 색상
            width: 1, // 테두리 두께
          ),
        ),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Palette.background,
        selectedItemColor: const Color(0xff2BD6D6),
        unselectedItemColor: Colors.black,
        selectedLabelStyle: const TextStyle(
          color: Color(0xFF2AD6D6),
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.20,
          letterSpacing: -0.30,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Color(0xFF111111),
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.20,
          letterSpacing: -0.30,
        ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/family_home.png',
              width: 32,
            ),
            activeIcon: Image.asset(
              'assets/family_home_active.png',
              width: 32,
            ),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/book_ribbon_bottom.png',
              width: 32,
            ),
            activeIcon: Image.asset(
              'assets/book_ribbon_bottom_active.png',
              width: 32,
            ),
            label: '용어사전',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/news_bottom.png',
              width: 32,
            ),
            activeIcon: Image.asset(
              'assets/news_bottom_active.png',
              width: 32,
            ),
            label: '기사',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/forum.png',
              width: 32,
            ),
            activeIcon: Image.asset(
              'assets/forum_active.png',
              width: 32,
            ),
            label: '커뮤니티',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/person.png',
              width: 32,
            ),
            activeIcon: Image.asset(
              'assets/person_active.png',
              width: 32,
            ),
            label: '마이페이지',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.toNamed('/home'); // 홈 페이지로 이동
              break;
            case 1:
              Get.toNamed('/dictionary'); // 용어사전 페이지로 이동
              break;
            case 2:
              Get.toNamed('/article'); // 기사 페이지로 이동
              break;
            case 3:
              Get.toNamed('/community'); // 커뮤니티 페이지로 이동
              break;
            case 4:
              // Get.toNamed('/profile');  // 마이페이지로 이동
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
