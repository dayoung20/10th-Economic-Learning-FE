import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingSlide extends StatelessWidget {
  final String title;
  final String subtitle;
  final int currentIdx;
  final String image;

  const OnboardingSlide(
      {super.key,
      required this.title,
      required this.subtitle,
      required this.currentIdx,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          width: 315.w,
          height: 313.h,
        ),
        SizedBox(height: 35.h),
        Text(
          title,
          style: Palette.cardTitle,
        ),
        SizedBox(height: 22.h),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Palette.cardSub,
        ),
        SizedBox(
          height: 60.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                width: currentIdx == 0 ? 32.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentIdx == 0
                        ? const Color(0xff2ad6d6)
                        : const Color(0xff767676))),
            const SizedBox(
              width: 8,
            ),
            Container(
                width: currentIdx == 1 ? 32.w : 8.w,
                height: 8,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentIdx == 1
                        ? const Color(0xff2ad6d6)
                        : const Color(0xff767676))),
            SizedBox(
              width: 8.w,
            ),
            Container(
                width: currentIdx == 2 ? 32.w : 8.w,
                height: 8.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: currentIdx == 2
                        ? const Color(0xff2ad6d6)
                        : const Color(0xff767676))),
            const SizedBox(
              width: 8,
            ),
          ],
        ),
      ],
    );
  }
}
