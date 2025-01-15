import 'package:flutter/material.dart';

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
        return Wrap(
          children: [
            // 옵션 1: 수정 또는 신고
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
                if (isAuthor) {
                  onEdit(); // 수정 콜백 실행
                } else {
                  onReport(); // 신고 콜백 실행
                }
              },
              leading: Icon(
                isAuthor ? Icons.edit : Icons.flag,
                color: isAuthor ? Colors.blue : Colors.red,
              ),
              title: Text(
                isAuthor
                    ? '수정'
                    : isComment
                        ? '댓글 신고하기'
                        : '글 신고하기',
                style: TextStyle(
                  color: isAuthor ? Colors.blue : Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            // 옵션 2: 삭제 (작성자일 경우에만)
            if (isAuthor)
              ListTile(
                onTap: () {
                  Navigator.of(context).pop();
                  onDelete(); // 삭제 콜백 실행
                },
                leading: const Icon(Icons.delete, color: Colors.red),
                title: const Text(
                  '삭제',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            // 옵션 3: 닫기
            ListTile(
              onTap: () {
                Navigator.of(context).pop();
              },
              leading: const Icon(Icons.close, color: Colors.grey),
              title: const Text(
                '닫기',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
