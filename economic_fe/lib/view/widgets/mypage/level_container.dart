import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class LevelContainer extends StatelessWidget {
  final String level;
  final bool isSelected;
  final Function() onTap;

  const LevelContainer({
    super.key,
    required this.level,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xFF1DB691) : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
                width: 1,
                color: isSelected
                    ? Palette.buttonColorGreen
                    : const Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          level,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xffa2a2a2),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            height: 1.50,
            letterSpacing: -0.35,
          ),
        ),
      ),
    );
  }
}
