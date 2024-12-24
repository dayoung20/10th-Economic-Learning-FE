import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomButton extends StatefulWidget {
  final String text;
  final void Function()? onPress;
  // final double width;
  // final double height;
  final Color bgColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPress,
    required this.bgColor,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: widget.onPress,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(280, 60), // width와 height 설정
        backgroundColor: widget.bgColor, // 배경색 설정 (16진수 #00D6D6)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // border-radius: 16px
        ),
        alignment: Alignment.center, // 텍스트 정렬
        padding: EdgeInsets.zero, // 내부 여백 제거
      ),
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: widget.bgColor == Colors.white
              ? Colors.black
              : Colors.white, // 텍스트 색상 설정
        ),
      ),
    );
  }
}
