import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/learning_set/learning_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningListItem extends StatefulWidget {
  final int setNum;
  final String setTitle;
  final int index; // 각 아이템의 인덱스를 받기 위해 추가

  const LearningListItem({
    super.key,
    required this.setNum,
    required this.setTitle,
    required this.index, // 인덱스를 받기 위해 추가
  });

  @override
  State<LearningListItem> createState() => _LearningListItemState();
}

class _LearningListItemState extends State<LearningListItem> {
  @override
  Widget build(BuildContext context) {
    // LearningListController 가져오기
    final controller = Get.find<LearningListController>();

    return Obx(() {
      // 선택된 아이템의 인덱스가 현재 아이템의 인덱스와 동일하면 decoration을 변경
      bool isSelected = controller.selectedItemIndex.value == widget.index;

      return Column(
        children: [
          Container(
            width: ScreenUtils.getWidth(context, 332),
            height: ScreenUtils.getHeight(context, 91),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtils.getWidth(context, 21),
              vertical: ScreenUtils.getHeight(context, 18),
            ),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  width: isSelected ? 3 : 1,
                  color: isSelected
                      ? const Color(0xFF1DB691)
                      : const Color(0xFFD9D9D9), // 선택된 경우와 선택되지 않은 경우 색상 변경
                ),
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
                IconButton(
                  icon: Icon(
                    isSelected
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                  onPressed: () {
                    controller
                        .toggleItemSelection(widget.index); // 아이템 선택 상태 변경
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 8),
          ),
          // 상세 내용 표시
          if (isSelected) ...[
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            Container(
              width: ScreenUtils.getWidth(context, 332),
              height: ScreenUtils.getHeight(context, 58),
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
              decoration: ShapeDecoration(
                color: const Color(0xFFF2F3F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '개념학습',
                    style: Palette.pretendard(
                      context,
                      const Color(0xFF404040),
                      16,
                      FontWeight.w600,
                      1.4,
                      -0.4,
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xffa2a2a2),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            Container(
              width: ScreenUtils.getWidth(context, 332),
              height: ScreenUtils.getHeight(context, 58),
              padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
              decoration: ShapeDecoration(
                color: const Color(0xFFF2F3F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '퀴즈풀기',
                    style: Palette.pretendard(
                      context,
                      const Color(0xFF404040),
                      16,
                      FontWeight.w600,
                      1.4,
                      -0.4,
                    ),
                  ),
                  const Icon(
                    Icons.check_circle_outline,
                    color: Color(0xffa2a2a2),
                  ),
                ],
              ),
            ),
          ],
        ],
      );
    });
  }
}
