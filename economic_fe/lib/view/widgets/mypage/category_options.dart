import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(left: 6, top: 27.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 16,
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
                    width: 52,
                    height: 29,
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
                      width: 25,
                      height: 25,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle, // 둥근 토글 버튼
                      ),
                    ),
                  ),
                )
              : isText!
                  ? const Text(
                      '최신 1.0 사용 중',
                      style: TextStyle(
                        color: Color(0xFF767676),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.30,
                      ),
                    )
                  : GestureDetector(
                      onTap: onTap,
                      child: const Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                      ),
                    ),
        ],
      ),
    );
  }
}
