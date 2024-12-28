import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileButtonSelected extends StatefulWidget {
  final double width;
  final String text;

  const ProfileButtonSelected({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  State<ProfileButtonSelected> createState() => _ProfileButtonSelectedState();
}

class _ProfileButtonSelectedState extends State<ProfileButtonSelected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.getWidth(context, widget.width),
      height: ScreenUtils.getHeight(context, 44),
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
              context, const Color(0xFF111111), 16, FontWeight.w500, 1.5, -0.4),
        ),
      ),
    );
  }
}
