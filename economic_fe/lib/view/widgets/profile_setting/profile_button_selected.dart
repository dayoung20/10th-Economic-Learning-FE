import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileButtonSelected extends StatefulWidget {
  final double paddingWidth;
  final double paddingHeight;
  final double height;
  final double fontSize;
  final String text;

  const ProfileButtonSelected({
    super.key,
    required this.text,
    required this.paddingWidth,
    required this.paddingHeight,
    required this.height,
    required this.fontSize,
  });

  @override
  State<ProfileButtonSelected> createState() => _ProfileButtonSelectedState();
}

class _ProfileButtonSelectedState extends State<ProfileButtonSelected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtils.getHeight(context, widget.height),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtils.getWidth(context, widget.paddingWidth),
          vertical: ScreenUtils.getHeight(context, widget.paddingHeight)),
      decoration: ShapeDecoration(
        color: const Color(0xFFDEF7F7),
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: ScreenUtils.getWidth(context, 1),
              color: const Color(0xFF767676)),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: Palette.pretendard(
            context,
            const Color(0xFF111111),
            widget.fontSize,
            FontWeight.w500,
            1.0,
            -0.4,
          ),
        ),
      ),
    );
  }
}
