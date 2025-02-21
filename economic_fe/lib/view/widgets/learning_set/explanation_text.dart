import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExplanationText extends StatelessWidget {
  final String explanation;

  const ExplanationText({super.key, required this.explanation});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: _parseExplanation(explanation),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.4,
          letterSpacing: -0.35,
          color: Colors.black,
        ),
      ),
    );
  }

  /// 텍스트를 분석하여 `**볼드 텍스트**`를 `TextSpan`으로 변환
  List<TextSpan> _parseExplanation(String text) {
    final List<TextSpan> spans = [];
    final RegExp regex = RegExp(r'\*\*(.*?)\*\*'); // `**볼드**` 감지 정규식
    final matches = regex.allMatches(text);

    int lastMatchEnd = 0;

    for (final match in matches) {
      // 일반 텍스트 추가
      if (match.start > lastMatchEnd) {
        spans.add(
          TextSpan(
            text: text.substring(lastMatchEnd, match.start),
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w400,
              height: 1.4,
              letterSpacing: -0.35,
            ),
          ),
        );
      }

      // 볼드 텍스트 추가
      spans.add(TextSpan(
        text: match.group(1), // `**` 사이의 텍스트만 가져옴
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          height: 1.4,
          letterSpacing: -0.35,
        ),
      ));

      lastMatchEnd = match.end;
    }

    // 마지막 일반 텍스트 추가
    if (lastMatchEnd < text.length) {
      spans.add(
        TextSpan(
          text: text.substring(lastMatchEnd),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            height: 1.4,
            letterSpacing: -0.35,
          ),
        ),
      );
    }

    return spans;
  }
}
