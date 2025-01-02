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
      width: ScreenUtils.getWidth(context, 58),
      height: ScreenUtils.getHeight(context, 38),
      padding: const EdgeInsets.all(10),
      decoration: widget.isSelected
          ? ShapeDecoration(
              color: const Color(0xFFDEF7F7),
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
                borderRadius: BorderRadius.circular(8),
              ),
            )
          : null,
      child: Text(
        widget.text,
        style: Palette.pretendard(
          context,
          widget.textColor,
          16,
          FontWeight.w500,
          1,
          -0.4,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
