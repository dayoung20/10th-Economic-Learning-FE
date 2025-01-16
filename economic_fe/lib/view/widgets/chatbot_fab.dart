import 'package:flutter/material.dart';

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
        width: 48,
        height: 48,
        decoration: ShapeDecoration(
          color: const Color(0xFF1DB691),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(26.50),
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/chatbot_white.png',
            width: 28,
            height: 28,
          ),
        ),
      ),
    );
  }
}
