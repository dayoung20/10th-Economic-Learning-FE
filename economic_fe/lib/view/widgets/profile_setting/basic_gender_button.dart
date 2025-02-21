import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BasicGenderButton extends StatefulWidget {
  final bool isSelected;
  final String text;
  final Color textColor;

  const BasicGenderButton({
    super.key,
    required this.text,
    required this.textColor,
    required this.isSelected,
  });

  @override
  State<BasicGenderButton> createState() => _BasicGenderButtonState();
}

class _BasicGenderButtonState extends State<BasicGenderButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58.w,
      height: 38.h,
      decoration: widget.isSelected
          ? ShapeDecoration(
              color: const Color(0xFFDEF7F7),
              shape: RoundedRectangleBorder(
                side: BorderSide(width: 1.w, color: const Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16.sp,
            fontFamily: 'Pretendard Variable',
            fontWeight: FontWeight.w500,
            height: 1.50,
            letterSpacing: -0.40,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
