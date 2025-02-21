import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryOptions extends StatelessWidget {
  final String text;
  final Function() onTap;
  final bool? isToggle;
  final bool? isToggleOn;
  final bool? isText;

  const CategoryOptions({
    super.key,
    required this.text,
    required this.onTap,
    this.isToggle = false,
    this.isToggleOn = true,
    this.isText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 6.w, top: 27.5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              color: const Color(0xFF111111),
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.40,
            ),
          ),
          isToggle!
              ? GestureDetector(
                  onTap: onTap, // 버튼 클릭 시 상태 변경
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300), // 애니메이션 지속 시간
                    width: 52.w,
                    height: 29.h,
                    decoration: BoxDecoration(
                      color: isToggleOn!
                          ? Palette.buttonColorBlue
                          : Colors.grey, // 상태에 따른 색상
                      borderRadius: BorderRadius.circular(25), // 둥근 모서리
                    ),
                    alignment: isToggleOn!
                        ? Alignment.centerRight
                        : Alignment.centerLeft, // 상태에 따른 위치
                    padding: const EdgeInsets.all(1.5),
                    child: Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle, // 둥근 토글 버튼
                      ),
                    ),
                  ),
                )
              : isText!
                  ? Text(
                      '최신 1.0 사용 중',
                      style: TextStyle(
                        color: const Color(0xFF767676),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.30,
                      ),
                    )
                  : GestureDetector(
                      onTap: onTap,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 15.w,
                      ),
                    ),
        ],
      ),
    );
  }
}
