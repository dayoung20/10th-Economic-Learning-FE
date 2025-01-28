import 'package:flutter/material.dart';

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
      style: const TextStyle(
        color: Color(0xFF111111),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.30,
        letterSpacing: -0.45,
      ),
    );
  }
}
