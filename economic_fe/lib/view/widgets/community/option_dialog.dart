import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionsDialog {
  static void showOptionsDialog({
    required BuildContext context,
    required bool isComment,
    required bool isAuthor,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
    required VoidCallback onReport,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Wrap(
            children: [
              // 옵션 1: 수정 또는 신고
              ListTile(
                onTap: () {
                  Navigator.of(context).pop(); // 모달 닫기
                  if (isAuthor) {
                    onEdit();
                  } else {
                    showConfirmationDialog(
                      context:
                          Navigator.of(context, rootNavigator: true).context,
                      content: isComment ? '댓글을 신고하시겠어요?' : '게시글을 신고하시겠어요?',
                      onConfirm: () {
                        onReport(); // 신고 처리 콜백 실행
                      },
                      isReport: true,
                    );
                  }
                },
                title: Text(
                  isAuthor
                      ? '수정'
                      : isComment
                          ? '댓글 신고하기'
                          : '글 신고하기',
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.60,
                  ),
                ),
              ),
              // 옵션 2: 삭제 (작성자일 경우에만)
              if (isAuthor)
                ListTile(
                  onTap: () {
                    Navigator.of(context).pop(); // 모달 닫기
                    showConfirmationDialog(
                      context:
                          Navigator.of(context, rootNavigator: true).context,
                      content: '글을 삭제하시겠어요?',
                      onConfirm: onDelete,
                      isReport: false,
                    );
                  },
                  title: Text(
                    '삭제',
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.30,
                      letterSpacing: -0.60,
                    ),
                  ),
                ),
              // 옵션 3: 닫기
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                },
                title: Text(
                  '닫기',
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.60,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // 신고 또는 삭제 확인 다이얼로그
  static void showConfirmationDialog({
    required BuildContext context,
    required String content,
    required VoidCallback onConfirm,
    required bool isReport,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: 312,
            height: 108,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 12.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        '취소',
                        style: TextStyle(
                          color: const Color(0xFF9B9A99),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 32.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop;
                        onConfirm();
                      },
                      child: Text(
                        isReport ? '신고' : '확인',
                        style: TextStyle(
                          color: isReport
                              ? const Color(0xFFFF5468)
                              : const Color(0xFF2AD6D6),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
