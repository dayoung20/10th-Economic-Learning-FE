import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class ProfileSettingButton extends StatefulWidget {
  final String title;
  final Icon icon;
  final void Function()? onPress;
  final bool isSelected; // 버튼의 선택 여부를 나타내는 변수

  const ProfileSettingButton({
    super.key,
    required this.title,
    this.onPress,
    this.isSelected = false,
    required this.icon,
  });

  @override
  State<ProfileSettingButton> createState() => _ProfileSettingButtonState();
}

class _ProfileSettingButtonState extends State<ProfileSettingButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Palette.pretendard(
            context,
            const Color(0xFFA2A2A2),
            14,
            FontWeight.w400,
            1.5,
            -0.35,
          ),
        ),
        SizedBox(
          height: ScreenUtils.getHeight(context, 8),
        ),
        GestureDetector(
          onTap: widget.onPress,
          child: Container(
            width: ScreenUtils.getWidth(context, 280),
            height: ScreenUtils.getHeight(context, 58),
            padding: EdgeInsets.all(
              ScreenUtils.getWidth(context, 12),
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    width: ScreenUtils.getWidth(context, 1),
                    color: const Color(0xFFA2A2A2)),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.icon,
                    Padding(
                      padding: EdgeInsets.only(
                        left: ScreenUtils.getWidth(context, 6),
                      ),
                      child: Text(
                        widget.title,
                        style: Palette.pretendard(
                            context,
                            widget.isSelected
                                ? const Color(0xff111111)
                                : const Color(0xFFA2A2A2),
                            16,
                            FontWeight.w400,
                            1.5,
                            -0.4),
                      ),
                    ),
                  ],
                ),
                widget.isSelected
                    ? const Icon(
                        Icons.check_circle_outline,
                        color: Color(0xff067BD5),
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
