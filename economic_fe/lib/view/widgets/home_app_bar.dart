import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
    required this.dayCounts,
  });

  final int dayCounts;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      backgroundColor: Palette.background,
      centerTitle: false,
      // oo일 연속 학습 중
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          shadows: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 0,
            )
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/icon.png',
              width: 14,
              height: 16,
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              '$dayCounts일 연속 학습 중',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF111111),
                fontSize: 12,
                fontFamily: 'Pretendard Variable',
                fontWeight: FontWeight.w500,
                height: 1.40,
                letterSpacing: -0.30,
              ),
            )
          ],
        ),
      ),
      actions: [
        // 검색
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.search,
            size: 24,
          ),
        ),
        // 알림
        IconButton(
          onPressed: () {
            Get.toNamed('/notification');
          },
          icon: const Icon(
            Icons.notifications_none,
            size: 24,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}
