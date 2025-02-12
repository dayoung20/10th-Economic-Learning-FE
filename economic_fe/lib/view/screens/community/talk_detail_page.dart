import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/community/comment_widget.dart';
import 'package:economic_fe/view_model/community/talk_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TalkDetailPage extends StatelessWidget {
  const TalkDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final TalkDetailController controller = Get.put(TalkDetailController());

    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Palette.background,
        leading: GestureDetector(
          // 뒤로 가기
          onTap: () => controller.goBack(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Colors.black,
          ),
        ),
        title: const Text(
          '경제 톡톡',
          textAlign: TextAlign.right,
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.30,
            letterSpacing: -0.50,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        var post = controller.postDetail;
        if (post.isEmpty) {
          return const Center(child: Text("게시글을 불러올 수 없습니다."));
        }

        return Stack(
          children: [
            Column(
              children: [
                // 경제 톡톡 게시글 이미지
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 152,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(post['imageList'][0]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 참여 인원
                                Text(
                                  '${post['participantCount']}명이 참여했어요',
                                  style: const TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: -0.33,
                                  ),
                                ),
                                // 게시글 업로드 시간
                                Text(
                                  '${post['createdDate']}',
                                  textAlign: TextAlign.right,
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
                            const SizedBox(
                              height: 8,
                            ),
                            // 게시글 제목
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 32,
                              child: Flexible(
                                child: Text(
                                  '${post['title']}',
                                  style: const TextStyle(
                                    color: Color(0xFF111111),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    height: 1.30,
                                    letterSpacing: -0.45,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            // 게시글 내용
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 32,
                              child: Flexible(
                                child: Text(
                                  '${post['content']}',
                                  style: const TextStyle(
                                    color: Color(0xFF404040),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                // 좋아요 수
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Obx(() => GestureDetector(
                                        onTap: () =>
                                            controller.likePostToggle(),
                                        child: Icon(
                                          post['isLiked']
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 18,
                                          color: post['isLiked']
                                              ? Palette.buttonColorBlue
                                              : const Color(0xff767676),
                                        ),
                                      )),
                                ),
                                const Text(
                                  '999+', // 좋아요 수 연결 필요
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                // 댓글 수
                                const Padding(
                                  padding: EdgeInsets.only(right: 5),
                                  child: Icon(
                                    Icons.chat_bubble_outline,
                                    size: 18,
                                    color: Color(0xff767676),
                                  ),
                                ),
                                const Text(
                                  '999+', // 댓글 수 연결 필요
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                // 북마크 수
                                Padding(
                                  padding: const EdgeInsets.only(right: 5),
                                  child: Obx(() => GestureDetector(
                                        onTap: () =>
                                            controller.scrapPostToggle(),
                                        child: Icon(
                                          post['isScraped']
                                              ? Icons.bookmark
                                              : Icons.bookmark_border,
                                          size: 18,
                                          color: post['isScraped']
                                              ? Palette.buttonColorBlue
                                              : const Color(0xff767676),
                                        ),
                                      )),
                                ),
                                const Text(
                                  '999+',
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 19,
                            ),
                          ],
                        ),
                      ),
                      // 게시글 / 댓글 구분 선
                      const Divider(thickness: 8, color: Color(0xFFF2F3F5)),
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.comments.length,
                          itemBuilder: (context, index) {
                            final comment = controller.comments[index];
                            return CommentWidget(
                              comment: comment,
                              isReply: false,
                              isAuthor: comment.isAuthor,
                              isTalk: true,
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                // 댓글 입력창 (답글 작성 모드 UI 추가)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Column(
                    children: [
                      // 댓글 수정 중 UI
                      Obx(() {
                        if (controller.isEditingComment.value) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "댓글 수정 중...",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: controller.disableEditMode,
                                  child: const Icon(Icons.close,
                                      size: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      // 답글 작성 모드 UI
                      Obx(() {
                        if (controller.replyingToCommentId.value != -1) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${controller.replyToAuthor.value}님에게 답글 작성 중",
                                  style: const TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: controller.disableReplyMode,
                                  child: const Icon(Icons.close,
                                      size: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox(); // 일반 댓글 모드일 때는 아무것도 표시 안함
                        }
                      }),
                      // 대댓글 수정 UI 추가
                      Obx(() {
                        if (controller.isEditingReply.value) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 8),
                            margin: const EdgeInsets.only(bottom: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  "대댓글 수정 중...",
                                  style: TextStyle(
                                      color: Colors.black87, fontSize: 14),
                                ),
                                GestureDetector(
                                  onTap: controller.disableReplyEditMode,
                                  child: const Icon(Icons.close,
                                      size: 18, color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      }),
                      // 실제 댓글 입력창
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 7),
                        decoration: ShapeDecoration(
                          color: const Color(0xFFF2F3F5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(17)),
                        ),
                        child: Obx(() {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: controller.messageController,
                                  onChanged: (value) =>
                                      controller.updateMessage(value),
                                  decoration: const InputDecoration(
                                    hintText: '댓글을 입력하세요.',
                                    border: InputBorder.none,
                                  ),
                                  maxLines: 5,
                                  minLines: 1,
                                ),
                              ),
                              GestureDetector(
                                onTap: controller.messageText.value.isNotEmpty
                                    ? (controller.isEditingComment.value
                                        ? controller.editComment
                                        : controller.isEditingReply.value
                                            ? controller.editReply
                                            : controller.sendMessage)
                                    : null,
                                child: Image.asset(
                                  controller.messageText.value.isNotEmpty
                                      ? 'assets/send_active.png'
                                      : 'assets/send.png',
                                  width: 24,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 19,
                ),
              ],
            ),
            Positioned(
              bottom: 120,
              right: 16,
              child: ChatbotFAB(
                onTap: () {
                  controller.toChatBot();
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
