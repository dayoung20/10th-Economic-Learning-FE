import 'package:flutter/material.dart';

class CategoryTab extends StatelessWidget {
  final bool isSelected;
  final String text;

  const CategoryTab({
    super.key,
    required this.isSelected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xff2BD6D6) : Colors.white,
          shape: RoundedRectangleBorder(
            side: isSelected
                ? const BorderSide(width: 1, color: Color(0xff2BD6D6))
                : const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xffa2a2a2),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.35,
          ),
        ),
      ),
    );
  }
}
