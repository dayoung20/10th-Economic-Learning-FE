import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/view/widgets/community/option_dialog.dart';
import 'package:flutter/material.dart';

class CommentWidget extends StatelessWidget {
  final Comment comment;
  final bool isReply;
  final bool isAuthor;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.isReply,
    required this.isAuthor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 댓글 작성자 프로필 사진
            Row(
              children: [
                Image.asset(
                  'assets/profile_example.png',
                  width: 18,
                  height: 18,
                ),
                const SizedBox(width: 7),
                // 댓글 작성자 닉네임
                Text(
                  comment.author,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Color(0xFF404040),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    height: 1.50,
                    letterSpacing: -0.35,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
                // 댓글 작성일
                Text(
                  comment.date,
                  style: const TextStyle(
                    color: Color(0xFF767676),
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 1.50,
                    letterSpacing: -0.30,
                  ),
                ),
              ],
            ),
            // 더보기 버튼
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: GestureDetector(
                onTap: () {
                  _handleOptions(context, isAuthor);
                },
                child: const Icon(
                  Icons.more_horiz,
                  size: 20,
                  color: Color(0xff404040),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        // 댓글 내용
        SizedBox(
          width: isReply
              ? MediaQuery.of(context).size.width - 52
              : MediaQuery.of(context).size.width - 32,
          child: Text(
            comment.content,
            style: const TextStyle(
              color: Color(0xFF404040),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 1.50,
              letterSpacing: -0.35,
            ),
          ),
        ),
        const SizedBox(
          height: 8.5,
        ),
        Row(
          children: [
            // 좋아요 수
            const Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(
                Icons.favorite_border,
                size: 18,
                color: Color(0xff767676),
              ),
            ),
            Text(
              '${comment.likes}',
              style: const TextStyle(
                color: Color(0xFF767676),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
              ),
            ),
            const SizedBox(width: 8),
            // 답글 수
            isReply
                ? const SizedBox()
                : Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(right: 5),
                        child: Icon(
                          Icons.chat_bubble_outline,
                          size: 18,
                          color: Color(0xff767676),
                        ),
                      ),
                      Text(
                        '${comment.replies.length}',
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ],
    );
  }

  void _handleOptions(BuildContext context, bool isAuthor) {
    OptionsDialog.showOptionsDialog(
      context: context,
      isAuthor: isAuthor,
      isComment: true,
      onEdit: () {
        // 수정 기능
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('댓글 수정 기능 실행')),
        );
      },
      onDelete: () {
        // 삭제 기능
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('댓글 삭제 기능 실행')),
        );
      },
      onReport: () {
        // // 신고 기능
        // ScaffoldMessenger.of(context).showSnackBar(
        //   const SnackBar(content: Text('댓글 신고 기능 실행')),
        // );
        _onReport(context: context, content: '댓글이 신고되었습니다.');
      },
    );
  }

  // 신고 완료 메시지
  static void _onReport({
    required BuildContext context,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            width: 312,
            height: 108,
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  content,
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '확인',
                      style: TextStyle(
                        color: Color(0xFF2AD6D6),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
