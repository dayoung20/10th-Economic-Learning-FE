import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

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
      width: 58,
      height: 38,
      decoration: widget.isSelected
          ? ShapeDecoration(
              color: const Color(0xFFDEF7F7),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: widget.textColor,
            fontSize: 16,
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
