import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final void Function()? onPress;
  final IconData? icon;
  final int? currentIndex;
  final int? totalIndex;
  final ValueNotifier<int>?
      currentIndexNotifier; // 추가: 상태 변경 감지를 위한 ValueNotifier
  final ValueNotifier<int>? totalIndexNotifier; // 추가: 전체 개수 변경 감지
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
    this.currentIndexNotifier, // 추가
    this.totalIndexNotifier, // 추가
    this.titleStyle,
    this.rightIcon = false,
    this.onTapTitle,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      title: GestureDetector(
        onTap: widget.onTapTitle,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title),
            if (widget.rightIcon == true) const Icon(Icons.arrow_drop_down),
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
        if ((widget.currentIndexNotifier != null &&
                widget.totalIndexNotifier != null) ||
            (widget.currentIndex != null && widget.totalIndex != null))
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: ValueListenableBuilder<int>(
              valueListenable: widget.currentIndexNotifier ??
                  ValueNotifier(widget.currentIndex ?? 0),
              builder: (context, currentIndex, _) {
                return ValueListenableBuilder<int>(
                  valueListenable: widget.totalIndexNotifier ??
                      ValueNotifier(widget.totalIndex ?? 1),
                  builder: (context, totalIndex, _) {
                    return Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '$currentIndex',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w500,
                              height: 1.40.h,
                            ),
                          ),
                          TextSpan(
                            text: '/$totalIndex',
                            style: TextStyle(
                              color: const Color(0xFF767676),
                              fontSize: 14,
                              fontFamily: 'Pretendard Variable',
                              fontWeight: FontWeight.w500,
                              height: 1.40.h,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
      ],
      bottom: (widget.currentIndexNotifier != null &&
                  widget.totalIndexNotifier != null) ||
              (widget.currentIndex != null && widget.totalIndex != null)
          ? PreferredSize(
              preferredSize: const Size.fromHeight(3.0),
              child: ValueListenableBuilder<int>(
                valueListenable: widget.currentIndexNotifier ??
                    ValueNotifier(widget.currentIndex ?? 0),
                builder: (context, currentIndex, _) {
                  return ValueListenableBuilder<int>(
                    valueListenable: widget.totalIndexNotifier ??
                        ValueNotifier(widget.totalIndex ?? 1),
                    builder: (context, totalIndex, _) {
                      return LinearProgressIndicator(
                        value: totalIndex > 0 ? currentIndex / totalIndex : 0,
                        backgroundColor: const Color(0xffe0e0e0),
                        color: Palette.buttonColorBlue,
                      );
                    },
                  );
                },
              ),
            )
          : null,
    );
  }
}
