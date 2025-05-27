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
      ],
    );
  }
}
