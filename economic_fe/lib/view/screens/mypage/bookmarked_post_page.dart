import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/mypage/bookmarked_posts_controller.dart';
import 'package:flutter/material.dart';
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
  void initState() {
    super.initState();
    controller.fetchScrapedPosts(); // API 호출
  }

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
        // posts가 비어있는 경우 처리
        if (controller.posts.isEmpty) {
          return const Center(
            child: Text(
              '스크랩 한 게시글이 없습니다.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF767676),
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: controller.posts.length,
          itemBuilder: (context, index) {
            final post = controller.posts[index];
            return Container(
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          post["type"] ?? '',
                          style: const TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            height: 1.30,
                            letterSpacing: -0.30,
                          ),
                        ),
                        Text(
                          post["createdDate"] ?? '',
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
                      height: 6,
                    ),
                    GestureDetector(
                      onTap: () {
                        // 게시글 상세 페이지 이동
                      },
                      child: Text(
                        post["title"] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          height: 1.3,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ),
                    controller.argument == "좋아요 한 댓글"
                        ? Column(
                            children: [
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                post["postTitle"] ?? '',
                                style: const TextStyle(
                                  color: Color(0xFFA2A2A2),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 1.30,
                                  letterSpacing: -0.30,
                                ),
                              ),
                            ],
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
