import 'dart:io';

import 'package:economic_fe/view/screens/mypage/mypage_home_page.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/mypage/my_profie_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final MyProfileController controller = Get.put(MyProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '내 프로필',
        icon: Icons.arrow_back_ios_new,
        onPress: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final user = controller.userInfo.value;
        if (user == null) {
          return const Center(
            child: Text("사용자 정보를 불러오지 못했습니다."),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 16),
              child: Row(
                children: [
                  // 사용자 프로필 사진
                  SizedBox(
                    height: 81,
                    child: Stack(
                      children: [
                        Container(
                          width: 81,
                          height: 81,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFF3F3F3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(43),
                            ),
                          ),
                          child: controller.selectedProfileImage.value != null
                              ? ClipOval(
                                  child: Image.file(
                                    File(
                                        controller.selectedProfileImage.value!),
                                    fit: BoxFit.cover,
                                    width: 81,
                                    height: 81,
                                  ),
                                )
                              : user.profileImageURL != null
                                  ? ClipOval(
                                      child: Image(
                                        image:
                                            NetworkImage(user.profileImageURL!),
                                        fit: BoxFit.cover,
                                        width: 81,
                                        height: 81,
                                      ),
                                    )
                                  : const Icon(
                                      Icons.person,
                                      size: 35,
                                    ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          // 편집 버튼
                          child: GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                '/profile_setting',
                                arguments: controller.userInfo.value,
                              );
                            },
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x3F000000),
                                    blurRadius: 4,
                                    offset: Offset(0, 0),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: const Icon(
                                Icons.edit_outlined,
                                size: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 사용자 이름
                      Row(
                        children: [
                          Text(
                            user.nickname,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.50,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 1),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2AD6D6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              controller.convertLevel(user.level!),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 1.67,
                                letterSpacing: 0.25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // 생년월일
                      Text(
                        controller.formatBirthDate(user.birthDate),
                        style: const TextStyle(
                          color: Color(0xFF767676),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.30,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      // 한 줄 소개
                      Text(
                        controller.truncateIntro(user.profileIntro),
                        style: const TextStyle(
                          color: Color(0xFF404040),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          height: 1.30,
                          letterSpacing: -0.35,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 17, left: 16),
              child: Row(
                children: [
                  // 직무
                  JobContainer(text: user.job),
                  const SizedBox(
                    width: 8,
                  ),
                  // 업종
                  JobContainer(text: user.businessType),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Divider(
              color: Colors.black,
              height: 0,
            ),
            // 탭바
            Container(
              color: Colors.white,
              child: TabBar(
                controller: controller.tabController,
                labelColor: Colors.black,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelColor: const Color(0xff767676),
                indicatorColor: Colors.black,
                indicatorWeight: 3.0,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: const [
                  Tab(text: '일반 게시판'),
                  Tab(text: '경제 톡톡'),
                  Tab(text: '댓글 단 글'),
                ],
              ),
            ),
            // 탭 컨텐츠
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  // 일반 게시판 화면
                  Obx(() {
                    var posts = controller.myPosts;

                    return controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator()) // 로딩 UI
                        : posts.isEmpty
                            ? const Center(child: Text('게시글이 없습니다.'))
                            : ListView.builder(
                                itemCount: posts.length,
                                itemBuilder: (context, index) {
                                  var post = posts[index];
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
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              (32 + 66 + 15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                post.title!,
                                                style: const TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500,
                                                  height: 1.30,
                                                  letterSpacing: -0.40,
                                                ),
                                              ),
                                              Text(
                                                post.content!,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                  letterSpacing: -0.35,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.favorite_outline,
                                                    size: 18,
                                                    color: Color(0xff767676),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${post.likeCount}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.50,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  const Icon(
                                                    Icons.chat_bubble_outline,
                                                    size: 18,
                                                    color: Color(0xff767676),
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${post.commentCount}',
                                                    style: const TextStyle(
                                                      color: Color(0xFF767676),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.50,
                                                      letterSpacing: -0.30,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        // 이미지가 있는 경우에만 표시
                                        if (post.imageUrl != null &&
                                            post.imageUrl!.isNotEmpty)
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(7),
                                            child: Image.network(
                                              post.imageUrl!,
                                              width: 66,
                                              height: 66,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                width: 66,
                                                height: 66,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(7),
                                                ),
                                                child: const Icon(
                                                    Icons.image_not_supported,
                                                    color: Colors.grey),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  );
                                },
                              );
                  }),
                  // 경제 톡톡 화면
                  Obx(() {
                    if (controller.economyTalkPosts.isEmpty) {
                      return const Center(
                        child: Text(
                          '내가 참여한 경제 톡톡이 없습니다.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF767676),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.economyTalkPosts.length,
                      itemBuilder: (context, index) {
                        final post = controller.economyTalkPosts[index];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed('/community/talk_detail',
                                arguments: post.id!);
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // 경제톡톡 이미지
                                Padding(
                                  padding: const EdgeInsets.only(right: 12),
                                  child: // 이미지가 있는 경우에만 표시
                                      post.imageUrl != null &&
                                              post.imageUrl!.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: Image.network(
                                                post.imageUrl!,
                                                width: 97,
                                                height: 118,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  width: 97,
                                                  height: 118,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  child: const Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 97,
                                              height: 118,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7),
                                                image: const DecorationImage(
                                                  image: AssetImage(
                                                      'assets/talk_image_sample.png'),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          (32 + 97 + 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${post.commentCount}명이 참여했어요',
                                            style: const TextStyle(
                                              color: Color(0xFF767676),
                                              fontSize: 13,
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                              letterSpacing: -0.33,
                                            ),
                                          ),
                                          Text(
                                            post.createdDate!,
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(
                                              color: Color(0xFFA2A2A2),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          (32 + 97 + 12),
                                      height: 60,
                                      child: Flexible(
                                        child: Text(
                                          post.title!,
                                          style: const TextStyle(
                                            color: Color(0xFF111111),
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            height: 1.30,
                                            letterSpacing: -0.38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 18,
                                            color: Color(0xff767676),
                                          ),
                                        ),
                                        Text(
                                          '${post.likeCount}',
                                          style: const TextStyle(
                                            color: Color(0xFF767676),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(right: 2),
                                          child: Icon(
                                            Icons.chat_bubble_outline,
                                            size: 18,
                                            color: Color(0xff767676),
                                          ),
                                        ),
                                        Text(
                                          '${post.commentCount}',
                                          style: const TextStyle(
                                            color: Color(0xFF767676),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }),
                  // 댓글 단 글 화면
                  Obx(() {
                    if (controller.otherCommentPosts.isEmpty) {
                      return const Center(
                        child: Text(
                          '내가 댓글 단 게시글이 없습니다.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF767676),
                          ),
                        ),
                      );
                    }

                    return ListView.builder(
                      itemCount: controller.otherCommentPosts.length,
                      itemBuilder: (context, index) {
                        final post = controller.otherCommentPosts[index];
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // 게시글 유형 및 작성일
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    controller.translatedType(post['type']),
                                    style: const TextStyle(
                                      color: Color(0xFF767676),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 1.30,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  Text(
                                    post['createdDate'],
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
                              const SizedBox(height: 6),
                              // 게시글 제목
                              Text(
                                post['comment'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              // 원문글 제목 표시
                              Column(
                                children: [
                                  const SizedBox(height: 6),
                                  Text(
                                    post['postTitle'],
                                    style: const TextStyle(
                                      color: Color(0xFFA2A2A2),
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      height: 1.30,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
