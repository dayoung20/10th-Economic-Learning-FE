import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomSnackBar {
  static final List<OverlayEntry> _activeSnackBars = []; // 현재 활성 스낵바들

  static void show({
    required BuildContext context,
    required String message,
  }) {
    final overlay = Overlay.of(context);

    late final OverlayEntry overlayEntry; // 변수 선언만 먼저 함
    overlayEntry = OverlayEntry(
      builder: (context) => _PositionedSnackBar(
        message: message,
        onDismissed: () {
          // 스낵바가 사라질 때 리스트에서 제거
          _activeSnackBars.remove(overlayEntry);
          overlayEntry.remove();
        },
        positionOffset: _activeSnackBars.length * 50, // 스낵바 간 간격
      ),
    );

    // 스낵바 추가 및 삽입
    _activeSnackBars.add(overlayEntry);
    overlay.insert(overlayEntry);
  }
}

class _PositionedSnackBar extends StatefulWidget {
  final String message;
  final VoidCallback onDismissed;
  final double positionOffset; // 스낵바 위치 조정

  const _PositionedSnackBar({
    required this.message,
    required this.onDismissed,
    required this.positionOffset,
    super.key,
  });

  @override
  State<_PositionedSnackBar> createState() => _PositionedSnackBarState();
}

class _PositionedSnackBarState extends State<_PositionedSnackBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300), // 애니메이션 시간
      reverseDuration: const Duration(milliseconds: 300), // 닫힐 때 애니메이션
      vsync: this,
    );

    _slideAnimation =
        Tween<double>(begin: -50, end: widget.positionOffset) // 위에서 아래로 이동
            .animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _controller.forward();

    // 일정 시간 후 애니메이션 역재생 및 스낵바 닫기
    Future.delayed(const Duration(seconds: 1)).then((_) {
      if (mounted) {
        _controller.reverse().then((_) {
          widget.onDismissed();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _slideAnimation.value),
          child: child,
        );
      },
      child: Align(
        alignment: Alignment.topCenter,
        child: IntrinsicWidth(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            margin: EdgeInsets.only(top: 70.h),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              widget.message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
