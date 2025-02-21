import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.find<HomeController>();

    return AppBar(
      automaticallyImplyLeading: false,
      forceMaterialTransparency: true,
      backgroundColor: Palette.background,
      centerTitle: false,
      // oo일 연속 학습 중
      title: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
              width: 14.w,
              height: 16.h,
            ),
            SizedBox(
              width: 4.w,
            ),
            Obx(
              () => Text(
                '${controller.currentStreak.value}일 연속 학습 중',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF111111),
                  fontSize: 12.sp,
                  fontFamily: 'Pretendard Variable',
                  fontWeight: FontWeight.w500,
                  height: 1.40,
                  letterSpacing: -0.30,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        // 검색
        IconButton(
          onPressed: () {
            Get.toNamed('/search');
          },
          icon: Icon(
            Icons.search,
            size: 24.w,
          ),
        ),
        // 알림
        IconButton(
          onPressed: () {
            Get.toNamed('/notification');
          },
          icon: Icon(
            Icons.notifications_none,
            size: 24.w,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}
