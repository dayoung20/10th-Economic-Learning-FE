import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileButtonUnselected extends StatefulWidget {
  final double width;
  final String text;

  const ProfileButtonUnselected({
    super.key,
    required this.width,
    required this.text,
  });

  @override
  State<ProfileButtonUnselected> createState() =>
      _ProfileButtonUnselectedState();
}

class _ProfileButtonUnselectedState extends State<ProfileButtonUnselected> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.getWidth(context, widget.width),
      height: ScreenUtils.getHeight(context, 44),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: ScreenUtils.getWidth(context, 1),
              color: const Color(0xFFA2A2A2)),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Center(
        child: Text(
          widget.text,
          style: Palette.pretendard(
              context, const Color(0xFFA2A2A2), 16, FontWeight.w400, 1.5, -0.4),
        ),
      ),
    );
  }
}
