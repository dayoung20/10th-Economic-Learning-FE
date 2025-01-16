import 'package:economic_fe/data/models/community/comment.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/community/comment_widget.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
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
        actions: [
          // 더보기 버튼
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ],
      ),
      body: Stack(
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
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/talk_image_sample.png'),
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
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // 참여 인원
                              Text(
                                '999+명이 참여했어요',
                                style: TextStyle(
                                  color: Color(0xFF767676),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                  letterSpacing: -0.33,
                                ),
                              ),
                              // 게시글 업로드 시간
                              Text(
                                '4시간 전',
                                textAlign: TextAlign.right,
                                style: TextStyle(
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
                            child: const Flexible(
                              child: Text(
                                '경제톡톡 제목이 들어갑니다. 경제 톡톡 제목이 들어갑니다. 경제 톡톡 제목이 들어갑니다.',
                                style: TextStyle(
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
                            child: const Flexible(
                              child: Text(
                                '경제 상황은 투자 전략에 큰 영향을 미쳐요. 금리, 인플레이션, 경기 사이클, 글로벌 이벤트 등 다양한 요인이 현재의 투자 환경을 결정짓는 핵심 요소예요.\n\n예를 들어 인플레이션이 상승하는 시기에는 물가 상승을 방어할 수 있는 자산(원자재, 인플레이션 연동 채권 등)이 유리할 수 있어요. 경기 침체기에는 필수 소비재나 헬스케어와 같은 방어주가 주목받는 경우가 많아요.\n\n그렇다면 현재 경제 상황에서 가장 중요한 투자 전략은 무엇이라고 생각하시는지 여러분의 의견을 남겨주세요!',
                                style: TextStyle(
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
                          const Row(
                            children: [
                              // 좋아요 수
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.favorite_border,
                                  size: 18,
                                  color: Color(0xff767676),
                                ),
                              ),
                              Text(
                                '999+',
                                style: TextStyle(
                                  color: Color(0xFF767676),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              // 댓글 수
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.chat_bubble_outline,
                                  size: 18,
                                  color: Color(0xff767676),
                                ),
                              ),
                              Text(
                                '999+',
                                style: TextStyle(
                                  color: Color(0xFF767676),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.50,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              // 북마크 수
                              Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: Icon(
                                  Icons.bookmark_border,
                                  size: 18,
                                  color: Color(0xff767676),
                                ),
                              ),
                              Text(
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 8,
                      decoration: const BoxDecoration(color: Color(0xFFF2F3F5)),
                    ),
                    // 댓글 부분
                    Expanded(
                      child: Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.comments.length,
                          itemBuilder: (context, index) {
                            final comment = controller.comments[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // 댓글 본문
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: CommentWidget(
                                    comment: comment,
                                    isReply: false,
                                    isAuthor: comment.isAuthor,
                                  ),
                                ),
                                // 구분 선
                                Container(
                                  color: const Color(0xffd9d9d9),
                                  height: 1,
                                ),
                                // 답글 리스트 (답글이 있다면)
                                if (comment.replies.isNotEmpty)
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: comment.replies.length,
                                    itemBuilder: (context, replyIndex) {
                                      final reply = comment.replies[replyIndex];
                                      return Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Transform.rotate(
                                                  angle: 3.14,
                                                  child: const Icon(
                                                    Icons.turn_left,
                                                    size: 20,
                                                    color: Color(0xffa2a2a2),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width -
                                                      55,
                                                  child: CommentWidget(
                                                    comment: reply,
                                                    isReply: true,
                                                    isAuthor: comment.isAuthor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                if (comment.replies.isNotEmpty)
                                  // 구분 선
                                  Container(
                                    color: const Color(0xffd9d9d9),
                                    height: 1,
                                  ),
                              ],
                            );
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),

              // 댓글 입력 창
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF2F3F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17),
                    ),
                  ),
                  child: Obx(() {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: 280,
                            child: TextField(
                              controller: controller.messageController,
                              onChanged: (value) {
                                controller.updateMessage(value);
                              },
                              decoration: const InputDecoration(
                                hintText: '댓글을 입력하세요.',
                                hintStyle: TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.40,
                                ),
                                border: InputBorder.none,
                              ),
                              maxLines: 5, // 최대 줄 수
                              minLines: 1, // 최소 줄 수
                            ),
                          ),
                        ),
                        controller.messageText.value.isNotEmpty
                            ? GestureDetector(
                                onTap: () => controller.sendMessage(),
                                child: Image.asset(
                                  'assets/send_active.png',
                                  width: 24,
                                ),
                              )
                            : Image.asset(
                                'assets/send.png',
                                width: 24,
                              ),
                      ],
                    );
                  }),
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
      ),
    );
  }
}
