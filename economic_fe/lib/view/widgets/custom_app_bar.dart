import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Implements PreferredSizeWidget
  final String title;
  final void Function()? onPress;
  final IconData? icon;
  final int? currentIndex;
  final int? totalIndex;
  final TextStyle? titleStyle;
  final bool? rightIcon;
  final void Function()? onTapTitle;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    this.icon,
    this.currentIndex,
    this.totalIndex,
    this.titleStyle,
    this.rightIcon = false,
    this.onTapTitle,
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
      forceMaterialTransparency: true,
      title: GestureDetector(
        onTap: widget.onTapTitle,
        child: Row(
          mainAxisSize: MainAxisSize.min, // Row의 크기를 내용물에 맞게 설정
          mainAxisAlignment: MainAxisAlignment.center, // Row 내부에서의 정렬
          children: [
            Text(
              widget.title,
            ),
            if (widget.rightIcon == true) // 아이콘 조건부 표시
              const Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
      titleTextStyle: widget.titleStyle ??
          Palette.pretendard(
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
