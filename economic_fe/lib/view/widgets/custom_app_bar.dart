import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Implements PreferredSizeWidget
  final String title;
  final void Function()? onPress;
  final IconData icon;
  final int? currentIndex;
  final int? totalIndex;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    required this.icon,
    this.currentIndex,
    this.totalIndex,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(widget.title),
      titleTextStyle: Palette.pretendard(
        context,
        const Color(0xFF111111),
        20,
        FontWeight.w500,
        1.3,
        -0.5,
      ),
      centerTitle: true,
      backgroundColor: Palette.background,
      leading: IconButton(
        onPressed: widget.onPress,
        icon: Icon(
          widget.icon,
          size: ScreenUtils.getWidth(context, 24),
          color: Colors.black,
        ),
      ),
      actions: [
        // 오른쪽 텍스트가 존재하는 경우 텍스트를 표시
        if (widget.currentIndex != null && widget.totalIndex != null)
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${widget.currentIndex}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                  TextSpan(
                    text: '/${widget.totalIndex}',
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontFamily: 'Pretendard Variable',
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
      bottom: widget.currentIndex != null && widget.totalIndex != null
          ? PreferredSize(
              preferredSize: const Size.fromHeight(3.0), // 하단 프로그레스 바 높이 설정
              child: LinearProgressIndicator(
                value: widget.currentIndex! / widget.totalIndex!, //
                backgroundColor: const Color(0xffe0e0e0),
                color: Palette.buttonColorBlue, // 진행 바 색상
              ),
            )
          : null, // 오른쪽 텍스트가 없으면 프로그레스 바를 표시하지 않음
    );
  }
}
