import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/learning_set/learning_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningListItem extends StatefulWidget {
  final int setNum;
  final String setTitle;
  final int index;

  const LearningListItem({
    super.key,
    required this.setNum,
    required this.setTitle,
    required this.index,
  });

  @override
  State<LearningListItem> createState() => _LearningListItemState();
}

class _LearningListItemState extends State<LearningListItem> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LearningListController>();

    return Obx(() {
      // 현재 아이템이 선택되었는지 여부
      bool isSelected = controller.selectedItemIndex.value == widget.index;

      // 현재 학습 세트 데이터 가져오기
      final learningSet = controller.learningSetList.isNotEmpty &&
              widget.index < controller.learningSetList.length
          ? controller.learningSetList[widget.index]
          : null;

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
                      : const Color(0xFFD9D9D9),
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
                          child: Icon(
                            learningSet?.isLearningSetCompleted == true
                                ? Icons.check_circle
                                : Icons.check_circle_outline,
                            color: learningSet?.isLearningSetCompleted == true
                                ? Colors.green
                                : const Color(0xffA2A2A2),
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
                    controller.toggleItemSelection(widget.index);
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 8),
          ),
          if (isSelected) ...[
            SizedBox(
              height: ScreenUtils.getHeight(context, 8),
            ),
            GestureDetector(
              onTap: () {
                controller.clickedLearningConcept(context);
              },
              child: Container(
                width: ScreenUtils.getWidth(context, 332),
                height: ScreenUtils.getHeight(context, 58),
                padding:
                    const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
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
                    Icon(
                      learningSet?.isConceptCompleted == true
                          ? Icons.check_circle
                          : Icons.check_circle_outline,
                      color: learningSet?.isConceptCompleted == true
                          ? Colors.green
                          : const Color(0xffa2a2a2),
                    ),
                  ],
                ),
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
                  Icon(
                    learningSet?.isQuizCompleted == true
                        ? Icons.check_circle
                        : Icons.check_circle_outline,
                    color: learningSet?.isQuizCompleted == true
                        ? Colors.green
                        : const Color(0xffa2a2a2),
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
