import 'package:economic_fe/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  final bool isEnabled; // 버튼 활성화 상태
  final VoidCallback? onPressed; // 버튼 클릭 시 동작
  final String? text;
  final Color? btnColor;

  const NextButton({
    super.key,
    required this.isEnabled, // 필수 매개변수로 활성화 상태 받기
    this.onPressed, // 동작을 외부에서 주입받도록 처리
    this.text,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null, // 활성화 상태에 따라 동작 설정
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          ScreenUtils.getWidth(context, 310),
          ScreenUtils.getHeight(context, 56),
        ),
        backgroundColor: isEnabled
            ? btnColor ?? const Color(0xff1eb692)
            : Colors.grey, // 활성화 상태에 따라 색상 변경
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text ?? "다음 문제",
        style: const TextStyle(
          color: Colors.white, // 텍스트 색상
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
