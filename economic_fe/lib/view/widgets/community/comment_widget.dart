import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/community/option_dialog.dart';
import 'package:economic_fe/view_model/community/detail_controller.dart';
import 'package:economic_fe/view_model/community/talk_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommentWidget extends StatefulWidget {
  final Comment comment;
  final bool isReply;
  final bool isAuthor;
  final bool? isTalk;

  const CommentWidget({
    super.key,
    required this.comment,
    required this.isReply,
    required this.isAuthor,
    this.isTalk = false,
  });

  @override
  State<CommentWidget> createState() => _CommentWidgetState();
}

class _CommentWidgetState extends State<CommentWidget> {
  late DetailController controller;
  late TalkDetailController talkController;
  late bool isTalkMode;

  @override
  void initState() {
    super.initState();
    if (widget.isTalk!) {
      Get.lazyPut<TalkDetailController>(() => TalkDetailController());
      talkController = Get.find<TalkDetailController>();
    } else {
      Get.lazyPut<DetailController>(() => DetailController());
      controller = Get.find<DetailController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10), // 답글 들여쓰기 적용
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // 상단 정렬
            children: [
              // 답글이면 turn_left 아이콘을 프로필 왼쪽에 배치
              if (widget.isReply)
                Padding(
                  padding: const EdgeInsets.only(right: 6, left: 16),
                  child: Transform.rotate(
                    angle: 3.14, // 180도 회전
                    child: const Icon(
                      Icons.turn_left,
                      size: 20,
                      color: Color(0xffa2a2a2),
                    ),
                  ),
                ),

              // 프로필 + 댓글 내용 + 버튼을 묶어서 turn_left 오른쪽에 배치
              Expanded(
                child: Padding(
                  padding: widget.isReply
                      ? const EdgeInsets.only(right: 16)
                      : const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          // 프로필 & 작성자 정보
                          Image.asset(
                            'assets/profile_example.png',
                            width: 18,
                            height: 18,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            widget.comment.author,
                            style: const TextStyle(
                              color: Color(0xFF404040),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              height: 1.50,
                              letterSpacing: -0.35,
                            ),
                          ),
                          const SizedBox(width: 7),
                          Text(
                            widget.comment.date,
                            style: const TextStyle(
                              color: Color(0xFF767676),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: -0.30,
                            ),
                          ),
                          const Spacer(),

                          // 더보기 버튼 (수정/삭제/신고)
                          GestureDetector(
                            onTap: () {
                              _handleOptions(
                                  context, widget.isAuthor, widget.isReply);
                            },
                            child: const Icon(Icons.more_horiz,
                                size: 20, color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),

                      // 댓글 내용 표시
                      Text(
                        widget.comment.isDeleted
                            ? "삭제된 댓글입니다."
                            : widget.comment.content,
                        style: TextStyle(
                          color: widget.comment.isDeleted
                              ? Colors.grey
                              : const Color(0xFF404040),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.35,
                        ),
                      ),

                      const SizedBox(height: 8.5),

                      Row(
                        children: [
                          // 좋아요 수
                          Padding(
                            padding: const EdgeInsets.only(right: 5),
                            child: GestureDetector(
                              onTap: () {
                                widget.isTalk!
                                    ? talkController
                                        .likeCommentToggle(widget.comment.id)
                                    : controller
                                        .likeCommentToggle(widget.comment.id);
                              },
                              child: Icon(
                                widget.comment.isLiked
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                size: 18,
                                color: widget.comment.isLiked
                                    ? Palette.buttonColorBlue
                                    : Colors.grey,
                              ),
                            ),
                          ),
                          Text("${widget.comment.likes}"),

                          // 답글 버튼
                          if (!widget.isReply) ...[
                            const SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                widget.isTalk!
                                    ? talkController.activateReplyMode(
                                        widget.comment.id,
                                        widget.comment.author)
                                    : controller.activateReplyMode(
                                        widget.comment.id,
                                        widget.comment.author);
                              },
                              child: Row(
                                children: [
                                  const Icon(Icons.chat_bubble_outline,
                                      size: 18, color: Colors.grey),
                                  const SizedBox(width: 5),
                                  Text("${widget.comment.replies.length}"),
                                ],
                              ),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // 댓글/답글 사이 구분선 추가
        const Padding(
          padding: EdgeInsets.only(top: 10),
          child: Divider(
            color: Color(0xFFD9D9D9), // 연한 회색 구분선
            thickness: 1,
          ),
        ),

        // 대댓글 리스트 (삭제된 댓글이라도 답글이 있으면 그대로 유지)
        if (widget.comment.replies.isNotEmpty)
          Column(
            children: widget.comment.replies.map((reply) {
              return CommentWidget(
                comment: reply,
                isReply: true,
                isAuthor: reply.isAuthor,
                isTalk: widget.isTalk,
              );
            }).toList(),
          ),
      ],
    );
  }

  void _handleOptions(BuildContext context, bool isAuthor, bool isReply) {
    OptionsDialog.showOptionsDialog(
      context: context,
      isAuthor: isAuthor,
      isComment: !isReply, // 댓글이면 true, 대댓글이면 false
      onEdit: () {
        if (isReply) {
          widget.isTalk!
              ? talkController.activateReplyEditMode(
                  widget.comment.id, widget.comment.content)
              : controller.activateReplyEditMode(
                  widget.comment.id, widget.comment.content);
        } else {
          widget.isTalk!
              ? talkController.activateEditMode(
                  widget.comment.id, widget.comment.content)
              : controller.activateEditMode(
                  widget.comment.id, widget.comment.content);
        }
      },
      onDelete: () {
        Navigator.of(context).pop();
        widget.isTalk!
            ? talkController.deleteComment(widget.comment.id)
            : controller.deleteComment(widget.comment.id);
      },
      onReport: () {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('댓글 신고 기능 실행')));
      },
    );
  }
}
