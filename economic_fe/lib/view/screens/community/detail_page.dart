// import 'package:economic_fe/view/theme/palette.dart';
// import 'package:economic_fe/view/widgets/community/comment_widget.dart';
// import 'package:economic_fe/view/widgets/community/option_dialog.dart';
// import 'package:economic_fe/view_model/community/detail_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DetailPage extends StatelessWidget {
//   const DetailPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final DetailController controller = Get.put(DetailController());

//     return Scaffold(
//       backgroundColor: Palette.background,
//       appBar: AppBar(
//         forceMaterialTransparency: true,
//         backgroundColor: Palette.background,
//         leading: GestureDetector(
//           // 뒤로 가기
//           onTap: () => controller.goBack(),
//           child: const Icon(
//             Icons.arrow_back_ios,
//             size: 24,
//             color: Colors.black,
//           ),
//         ),
//         title: const Text(
//           '일반 게시판',
//           textAlign: TextAlign.right,
//           style: TextStyle(
//             color: Color(0xFF111111),
//             fontSize: 20,
//             fontWeight: FontWeight.w500,
//             height: 1.30,
//             letterSpacing: -0.50,
//           ),
//         ),
//         centerTitle: true,
//         actions: [
//           // 더보기 버튼
//           Padding(
//             padding: const EdgeInsets.only(right: 16),
//             child: GestureDetector(
//               onTap: () {
//                 // isAuthor: false
//                 _handleOptions(context, false);
//               },
//               child: const Icon(Icons.more_horiz),
//             ),
//           ),
//         ],
//       ),
//       body: Obx(() {
//         return Stack(
//           children: [
//             Column(
//               children: [
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.all(16),
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 // 게시글 작성자 프로필 사진
//                                 Image.asset(
//                                   'assets/profile_example.png',
//                                   width: 34,
//                                   height: 34,
//                                 ),
//                                 const SizedBox(
//                                   width: 7,
//                                 ),
//                                 // 게시글 작성자 닉네임
//                                 const Text(
//                                   '닉네임',
//                                   style: TextStyle(
//                                     color: Color(0xFF404040),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500,
//                                     height: 1.50,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 8,
//                                 ),
//                                 // 게시글 작성 시간
//                                 const Text(
//                                   '4시간 전',
//                                   style: TextStyle(
//                                     color: Color(0xFF767676),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.50,
//                                     letterSpacing: -0.30,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 11,
//                             ),
//                             // 게시글 제목
//                             const Text(
//                               '일반게시판 제목이 들어갑니다. 일반게시판 제목이 들어갑니다. 일반게시판 제목이 들어갑니다.',
//                               style: TextStyle(
//                                 color: Color(0xFF111111),
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w500,
//                                 height: 1.30,
//                                 letterSpacing: -0.45,
//                               ),
//                             ),
//                             const SizedBox(
//                               height: 8,
//                             ),
//                             // 게시글 내용
//                             const Text(
//                               '경제 어쩌고에 대한 간단한 의견 입니다. 경제 어쩌고에 대한 간단한 의견 입니다. 경제 어쩌고에 대한 간단한 의견 입니다. 경제 어쩌고에 대한 간단한 의견 입니다. 경제 어쩌고에 대한 간단한 의견 입니다. 경제 어쩌고에 대한 간단한 의견 입니다. ',
//                               style: TextStyle(
//                                 color: Color(0xFF111111),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w400,
//                                 height: 1.50,
//                                 letterSpacing: -0.40,
//                               ),
//                             ),
//                             // 사진
//                             Container(
//                               height: 220,
//                               padding: const EdgeInsets.only(
//                                   left: 16, top: 20, bottom: 20),
//                               child: ListView.builder(
//                                 scrollDirection: Axis.horizontal,
//                                 itemCount: 3,
//                                 itemBuilder: (context, index) {
//                                   return Padding(
//                                     padding: const EdgeInsets.only(right: 10),
//                                     child: Container(
//                                       width: 180,
//                                       height: 180,
//                                       decoration: ShapeDecoration(
//                                         image: const DecorationImage(
//                                           image: AssetImage(
//                                               'assets/detail_image_sample.png'),
//                                           fit: BoxFit.fill,
//                                         ),
//                                         shape: RoundedRectangleBorder(
//                                           side: const BorderSide(
//                                               width: 1,
//                                               color: Color(0xFFD9D9D9)),
//                                           borderRadius:
//                                               BorderRadius.circular(8),
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ),
//                             const Row(
//                               children: [
//                                 // 좋아요 수
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 5),
//                                   child: Icon(
//                                     Icons.favorite_border,
//                                     size: 18,
//                                     color: Color(0xff767676),
//                                   ),
//                                 ),
//                                 Text(
//                                   '999+',
//                                   style: TextStyle(
//                                     color: Color(0xFF767676),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.50,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 // 댓글 수
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 5),
//                                   child: Icon(
//                                     Icons.chat_bubble_outline,
//                                     size: 18,
//                                     color: Color(0xff767676),
//                                   ),
//                                 ),
//                                 Text(
//                                   '999+',
//                                   style: TextStyle(
//                                     color: Color(0xFF767676),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.50,
//                                   ),
//                                 ),
//                                 SizedBox(
//                                   width: 8,
//                                 ),
//                                 // 북마크 수
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 5),
//                                   child: Icon(
//                                     Icons.bookmark_border,
//                                     size: 18,
//                                     color: Color(0xff767676),
//                                   ),
//                                 ),
//                                 Text(
//                                   '999+',
//                                   style: TextStyle(
//                                     color: Color(0xFF767676),
//                                     fontSize: 12,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.50,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             const SizedBox(
//                               height: 3,
//                             ),
//                           ],
//                         ),
//                       ),
//                       // 게시글/댓글 구분선
//                       Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 8,
//                         decoration:
//                             const BoxDecoration(color: Color(0xFFF2F3F5)),
//                       ),
//                       // 댓글 부분
//                       Expanded(
//                         child: Obx(() {
//                           return ListView.builder(
//                             shrinkWrap: true,
//                             physics: const NeverScrollableScrollPhysics(),
//                             itemCount: controller.comments.length,
//                             itemBuilder: (context, index) {
//                               final comment = controller.comments[index];
//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   // 댓글 본문
//                                   Padding(
//                                     padding: const EdgeInsets.all(16),
//                                     child: CommentWidget(
//                                       comment: comment,
//                                       isReply: false,
//                                       isAuthor: comment.isAuthor,
//                                     ),
//                                   ),
//                                   // 구분 선
//                                   Container(
//                                     color: const Color(0xffd9d9d9),
//                                     height: 1,
//                                   ),
//                                   // 답글 리스트 (답글이 있다면)
//                                   if (comment.replies.isNotEmpty)
//                                     ListView.builder(
//                                       shrinkWrap: true,
//                                       physics:
//                                           const NeverScrollableScrollPhysics(),
//                                       itemCount: comment.replies.length,
//                                       itemBuilder: (context, replyIndex) {
//                                         final reply =
//                                             comment.replies[replyIndex];
//                                         return Padding(
//                                           padding: const EdgeInsets.all(16),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Transform.rotate(
//                                                     angle: 3.14,
//                                                     child: const Icon(
//                                                       Icons.turn_left,
//                                                       size: 20,
//                                                       color: Color(0xffa2a2a2),
//                                                     ),
//                                                   ),
//                                                   SizedBox(
//                                                     width:
//                                                         MediaQuery.of(context)
//                                                                 .size
//                                                                 .width -
//                                                             55,
//                                                     child: CommentWidget(
//                                                       comment: reply,
//                                                       isReply: true,
//                                                       isAuthor:
//                                                           comment.isAuthor,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   if (comment.replies.isNotEmpty)
//                                     // 구분 선
//                                     Container(
//                                       color: const Color(0xffd9d9d9),
//                                       height: 1,
//                                     ),
//                                 ],
//                               );
//                             },
//                           );
//                         }),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // 댓글 입력 창
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
//                   child: Container(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
//                     decoration: ShapeDecoration(
//                       color: const Color(0xFFF2F3F5),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(17),
//                       ),
//                     ),
//                     child: Obx(() {
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: SizedBox(
//                               width: 280,
//                               child: TextField(
//                                 controller: controller.messageController,
//                                 onChanged: (value) {
//                                   controller.updateMessage(value);
//                                 },
//                                 decoration: const InputDecoration(
//                                   hintText: '댓글을 입력하세요.',
//                                   hintStyle: TextStyle(
//                                     color: Color(0xFFA2A2A2),
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w400,
//                                     letterSpacing: -0.40,
//                                   ),
//                                   border: InputBorder.none,
//                                 ),
//                                 maxLines: 5, // 최대 줄 수
//                                 minLines: 1, // 최소 줄 수
//                               ),
//                             ),
//                           ),
//                           controller.messageText.value.isNotEmpty
//                               ? GestureDetector(
//                                   onTap: () => controller.sendMessage(),
//                                   child: Image.asset(
//                                     'assets/send_active.png',
//                                     width: 24,
//                                   ),
//                                 )
//                               : Image.asset(
//                                   'assets/send.png',
//                                   width: 24,
//                                 ),
//                         ],
//                       );
//                     }),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 19,
//                 ),
//               ],
//             ),
//             if (controller.isModalVisible.value)
//               Positioned.fill(
//                 child: GestureDetector(
//                   onTap: controller.toggleModal, // 화면 탭 시 다이얼로그 숨기기
//                   child: Container(
//                     color: Colors.black.withOpacity(0.5), // 어두운 배경
//                   ),
//                 ),
//               ),
//             if (controller.isModalVisible.value)
//               Positioned(
//                 bottom: 240,
//                 right: 15,
//                 child: Container(
//                   width: 156,
//                   height: 88,
//                   padding: const EdgeInsets.symmetric(horizontal: 10),
//                   decoration: ShapeDecoration(
//                     color: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                   ),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       GestureDetector(
//                         onTap: () {
//                           controller.toChatPage();
//                         },
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/chatbot_green.png',
//                               width: 24,
//                               height: 24,
//                             ),
//                             const SizedBox(width: 6),
//                             const Text(
//                               '챗봇',
//                               style: TextStyle(
//                                 color: Color(0xFF404040),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 height: 1.40,
//                                 letterSpacing: -0.35,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           controller.toNewPost();
//                         },
//                         child: Row(
//                           children: [
//                             Image.asset(
//                               'assets/edit_square.png',
//                               width: 24,
//                               height: 24,
//                             ),
//                             const SizedBox(width: 6),
//                             const Text(
//                               '글쓰기',
//                               style: TextStyle(
//                                 color: Color(0xFF404040),
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w500,
//                                 height: 1.40,
//                                 letterSpacing: -0.35,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             if (controller.isModalVisible.value)
//               Positioned(
//                 bottom: 180,
//                 right: 15,
//                 child: GestureDetector(
//                   onTap: () {
//                     controller.toggleModal();
//                   },
//                   child: Container(
//                     width: 48,
//                     height: 48,
//                     decoration: const ShapeDecoration(
//                       color: Colors.white,
//                       shape: OvalBorder(),
//                     ),
//                     child: const Icon(
//                       Icons.close,
//                       size: 25,
//                       color: Colors.black,
//                     ),
//                   ),
//                 ),
//               ),
//             Positioned(
//               bottom: 120,
//               right: 16,
//               child: GestureDetector(
//                 onTap: () {
//                   controller.toggleModal();
//                 },
//                 child: Container(
//                   width: 48,
//                   height: 48,
//                   decoration: const ShapeDecoration(
//                     color: Color(0xFF2AD6D6),
//                     shape: OvalBorder(),
//                   ),
//                   child: const Icon(
//                     Icons.add,
//                     size: 25,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       }),
//     );
//   }

//   void _handleOptions(BuildContext context, bool isAuthor) {
//     OptionsDialog.showOptionsDialog(
//       context: context,
//       isAuthor: isAuthor,
//       isComment: false,
//       onEdit: () {
//         // 수정 기능
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('게시글 수정 기능 실행')),
//         );
//       },
//       onDelete: () {
//         // 삭제 기능
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('게시글 삭제 기능 실행')),
//         );
//       },
//       onReport: () {
//         // 신고 기능
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('게시글 신고 기능 실행')),
//         );
//       },
//     );
//   }
// }

import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/community/comment_widget.dart';
import 'package:economic_fe/view/widgets/community/option_dialog.dart';
import 'package:economic_fe/view_model/community/detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final DetailController controller = Get.put(DetailController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Palette.background,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child:
              const Icon(Icons.arrow_back_ios, size: 24, color: Colors.black),
        ),
        title: const Text(
          '일반 게시판',
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
              onTap: () {
                bool isAuthor = controller.isAuthor.value;
                _handleOptions(context, isAuthor);
              },
              child: const Icon(Icons.more_horiz),
            ),
          ),
        ],
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
                Expanded(
                  child: ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: post["authorProfileImage"] !=
                                          null
                                      ? NetworkImage(post["authorProfileImage"])
                                      : const AssetImage(
                                              'assets/profile_example.png')
                                          as ImageProvider,
                                  radius: 17,
                                ),
                                const SizedBox(width: 7),
                                Text(
                                  post["author"] ?? "익명",
                                  style: const TextStyle(
                                    color: Color(0xFF404040),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  post["createdDate"] ?? "날짜 없음",
                                  style: const TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 11),
                            Text(
                              post["title"] ?? "제목 없음",
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              post["content"] ?? "내용 없음",
                              style: const TextStyle(
                                color: Color(0xFF111111),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 20),
                            // 이미지 리스트
                            if (post["imageList"] != null &&
                                post["imageList"].isNotEmpty)
                              SizedBox(
                                height: 180,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: post["imageList"].length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.network(
                                          post["imageList"][index][
                                              "url"], // 여기서 "url" 필드에 명확히 접근해야 함
                                          width: 180,
                                          height: 180,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                const Icon(Icons.favorite_border,
                                    size: 18, color: Color(0xff767676)),
                                const SizedBox(width: 5),
                                Text("${post["likeCount"] ?? 0}"),
                                const SizedBox(width: 8),
                                const Icon(Icons.chat_bubble_outline,
                                    size: 18, color: Color(0xff767676)),
                                const SizedBox(width: 5),
                                Text("${post["commentCount"] ?? 0}"),
                                const SizedBox(width: 8),
                                const Icon(Icons.bookmark_border,
                                    size: 18, color: Color(0xff767676)),
                                const SizedBox(width: 5),
                                Text("${post["scrapCount"] ?? 0}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(thickness: 8, color: Color(0xFFF2F3F5)),
                      // 댓글 리스트
                      Obx(() {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller.comments.length,
                          itemBuilder: (context, index) {
                            final comment = controller.comments[index];
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: CommentWidget(
                                comment: comment,
                                isReply: false,
                                isAuthor: comment.isAuthor,
                              ),
                            );
                          },
                        );
                      }),
                    ],
                  ),
                ),
                // 댓글 입력창
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
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
                                ? controller.sendMessage
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
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  void _handleOptions(BuildContext context, bool isAuthor) {
    OptionsDialog.showOptionsDialog(
      context: context,
      isAuthor: isAuthor,
      isComment: false,
      onEdit: () => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('게시글 수정 기능 실행'))),
      onDelete: () => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('게시글 삭제 기능 실행'))),
      onReport: () => ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('게시글 신고 기능 실행'))),
    );
  }
}
