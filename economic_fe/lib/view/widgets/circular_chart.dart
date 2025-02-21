import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CircularChart extends StatefulWidget {
  final double progress; // 원형 차트의 진행 정도 (0.0 ~ 1.0)
  final String icon; // 원형 차트 내부에 들어갈 아이콘
  final String text; // 원형 차트 내부에 들어갈 글자

  const CircularChart(
      {super.key,
      required this.progress,
      required this.icon,
      required this.text});

  @override
  State<CircularChart> createState() => _CircularChartState();
}

class _CircularChartState extends State<CircularChart> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center, // Stack 내 위젯을 중앙에 배치
      children: [
        CustomPaint(
          size: const Size(90, 90), // 원형 차트의 크기
          painter: CirclePainter(progress: widget.progress),
        ),
        // 원형 차트의 중앙에 텍스트 추가
        Column(
          children: [
            Image.asset(
              'assets/${widget.icon}.png',
              width: 28.11.w,
              height: 23.h,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: const Color(0xFF767676),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.20.h,
                letterSpacing: -0.30.w,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CirclePainter extends CustomPainter {
  final double progress; // 0.0에서 1.0까지의 값 (진행 비율)

  CirclePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint grayPaint = Paint()
      ..color = const Color(0xff767676)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.w; // 원의 테두리 두께

    final Paint greenPaint = Paint()
      ..color = const Color(0xff1EB692)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 13.w;

    // 원형 차트의 배경 원을 그린다 (회색)
    canvas.drawCircle(
        Offset(size.width / 2, size.height / 2), size.width / 2, grayPaint);

    // 원형 차트의 진행 부분을 그린다 (초록색)
    double sweepAngle = 2 * 3.14159265359 * progress; // 진행 비율에 따라 각도 계산
    canvas.drawArc(
      Rect.fromCircle(
          center: Offset(size.width / 2, size.height / 2),
          radius: size.width / 2),
      -3.14159265359 / 2, // 시작 각도 (위에서 시작)
      sweepAngle, // 진행 각도
      false,
      greenPaint,
    );
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.progress != progress; // 진행률이 변경되었을 때 다시 그림
  }
}
