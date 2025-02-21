import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryText extends StatelessWidget {
  final String text;

  const CategoryText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: const Color(0xFF111111),
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        height: 1.30,
        letterSpacing: -0.45,
      ),
    );
  }
}
