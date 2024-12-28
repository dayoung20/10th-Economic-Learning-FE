import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButtonUnfilled extends StatefulWidget {
  final String text;
  final void Function()? onPress;

  const CustomButtonUnfilled({
    super.key,
    required this.text,
    required this.onPress,
  });

  @override
  State<CustomButtonUnfilled> createState() => _CustomButtonUnfilledState();
}

class _CustomButtonUnfilledState extends State<CustomButtonUnfilled> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          ScreenUtils.getWidth(context, 280),
          ScreenUtils.getHeight(context, 60),
        ), // width와 height 설정
        backgroundColor: const Color(0xFFF2F3F5), // 배경색 설정 (16진수 #00D6D6)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // border-radius: 16px
        ),
        alignment: Alignment.center, // 텍스트 정렬
        padding: EdgeInsets.zero, // 내부 여백 제거
        elevation: 0,
      ),
      child: Text(
        widget.text,
        style: Palette.pretendard(
          context,
          const Color(0xFFA2A2A2), // 텍스트 색상 설정
          18, FontWeight.w600, 1.2, -0.45,
        ),
      ),
    );
  }
}
