import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatbotFAB extends StatelessWidget {
  final Function() onTap;
  const ChatbotFAB({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48.w,
        height: 48.h,
        decoration: ShapeDecoration(
          color: const Color(0xFF1DB691),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.50),
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/chatbot_white.png',
            width: 28.w,
            height: 28.h,
          ),
        ),
      ),
    );
  }
}
