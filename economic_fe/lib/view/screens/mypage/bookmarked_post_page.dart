import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/mypage/bookmarked_posts_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookmarkedPostPage extends StatefulWidget {
  const BookmarkedPostPage({super.key});

  @override
  State<BookmarkedPostPage> createState() => _BookmarkedPostPageState();
}

class _BookmarkedPostPageState extends State<BookmarkedPostPage> {
  final BookmarkedPostsController controller =
      Get.put(BookmarkedPostsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: controller.argument,
        icon: Icons.close,
        onPress: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return Center(
            child: Text(
              '스크랩 된 데이터가 없습니다.',
              style: TextStyle(
                fontSize: 16.sp,
                color: const Color(0xFF767676),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return GestureDetector(
              onTap: () {
                if (post['type'] == 'ECONOMY_TALK') {
                  Get.toNamed('/community/talk_detail', arguments: post["id"]);
                } else {
                  Get.toNamed('/community/detail', arguments: post["id"]);
                }
              },
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: const Border(
                    bottom: BorderSide(
                      color: Color(0xFFD9D9D9),
                      width: 1,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 게시글 유형 및 작성일
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            post["type"] ?? '',
                            style: TextStyle(
                              color: const Color(0xFF767676),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.30,
                              letterSpacing: -0.30,
                            ),
                          ),
                          Text(
                            post["createdDate"] ?? '',
                            style: TextStyle(
                              color: const Color(0xFF767676),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400,
                              height: 1.50,
                              letterSpacing: -0.30,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // 게시글 제목
                      GestureDetector(
                        onTap: () {
                          // 게시글 상세 페이지 이동 (추후 구현 가능)
                        },
                        child: Text(
                          controller.argument == "좋아요 한 댓글"
                              ? post["content"] ?? ''
                              : post["title"] ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            height: 1.3,
                            letterSpacing: -0.4,
                          ),
                        ),
                      ),
                      // 좋아요 한 댓글의 경우 원문글 제목 표시
                      if (controller.argument == "좋아요 한 댓글")
                        Column(
                          children: [
                            SizedBox(height: 6.h),
                            Text(
                              post["postName"] ?? '',
                              style: TextStyle(
                                color: const Color(0xFFA2A2A2),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                height: 1.30,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
