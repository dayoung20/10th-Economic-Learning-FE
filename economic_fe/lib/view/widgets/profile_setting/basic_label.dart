import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class BasicLabel extends StatefulWidget {
  final String label;

  const BasicLabel({
    super.key,
    required this.label,
  });

  @override
  State<BasicLabel> createState() => _BasicLabelState();
}

class _BasicLabelState extends State<BasicLabel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ScreenUtils.getWidth(context, 281),
      child: Text(
        widget.label,
        style: Palette.pretendard(
          context,
          const Color(0xFFA2A2A2),
          14,
          FontWeight.w400,
          1.5,
          -0.35,
        ),
      ),
    );
  }
}
