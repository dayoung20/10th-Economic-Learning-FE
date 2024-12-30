import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileSettingAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  // Implements PreferredSizeWidget
  final String title;
  final void Function()? onPress;

  const ProfileSettingAppBar({
    super.key,
    required this.title,
    this.onPress,
  });

  @override
  State<ProfileSettingAppBar> createState() => _ProfileSettingAppBarState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the height of the AppBar
}

class _ProfileSettingAppBarState extends State<ProfileSettingAppBar> {
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
          Icons.close,
          size: ScreenUtils.getWidth(context, 24),
        ),
      ),
    );
  }
}
