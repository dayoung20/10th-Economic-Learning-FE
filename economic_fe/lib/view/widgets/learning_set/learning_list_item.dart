import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/material.dart';

class LearningListItem extends StatefulWidget {
  final int setNum;
  final String setTitle;

  const LearningListItem({
    super.key,
    required this.setNum,
    required this.setTitle,
  });

  @override
  State<LearningListItem> createState() => _LearningListItemState();
}

class _LearningListItemState extends State<LearningListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.getWidth(context, 332),
      height: ScreenUtils.getHeight(context, 91),
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtils.getWidth(context, 21),
        vertical: ScreenUtils.getHeight(context, 20),
      ),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '세트 ${widget.setNum}',
                style: Palette.pretendard(
                  context,
                  const Color(0xFF767676),
                  14,
                  FontWeight.w400,
                  1.4,
                  -0.35,
                ),
              ),
              Row(
                children: [
                  Text(
                    widget.setTitle,
                    style: Palette.pretendard(
                      context,
                      const Color(0xFF404040),
                      18,
                      FontWeight.w600,
                      1.4,
                      -0.45,
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtils.getWidth(context, 6),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: ScreenUtils.getHeight(context, 3),
                    ),
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: Color(0xffA2A2A2),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
