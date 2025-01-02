import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  // Implements PreferredSizeWidget
  final String title;
  final void Function()? onPress;
  final IconData icon;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onPress,
    required this.icon,
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
    );
  }
}
