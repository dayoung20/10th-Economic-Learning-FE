import 'dart:io';

import 'package:economic_fe/view/screens/mypage/mypage_home_page.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/mypage/my_profie_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late MyProfileController controller; // 컨트롤러 변수 선언

  @override
  void initState() {
    super.initState();

    int? userId = Get.arguments as int?; // Get.arguments에서 userId 가져오기

    // 최초 진입 시 컨트롤러 등록 (앱이 처음 실행된 경우)
    if (!Get.isRegistered<MyProfileController>()) {
      controller = Get.put(MyProfileController());
    } else {
      controller = Get.find<MyProfileController>(); // 기존 컨트롤러 가져오기
    }

    // userId에 따라 프로필 정보 불러오기
    controller.fetchUserInfo(userId);
    controller.fetchMyPosts(userId);
    controller.fetchCommentPosts(userId);
    controller.fetchTokTok(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '프로필',
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
              padding: EdgeInsets.only(top: 10.h, left: 16.w),
              child: Row(
                children: [
                  // 사용자 프로필 사진
                  SizedBox(
                    height: 81.h,
                    child: Stack(
                      children: [
                        Container(
                          width: 81.w,
                          height: 81.h,
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
                                    width: 81.w,
                                    height: 81.h,
                                  ),
                                )
                              : user.profileImageURL != null
                                  ? ClipOval(
                                      child: Image(
                                        image:
                                            NetworkImage(user.profileImageURL!),
                                        fit: BoxFit.cover,
                                        width: 81.w,
                                        height: 81.h,
                                      ),
                                    )
                                  : Icon(
                                      Icons.person,
                                      size: 35.w,
                                    ),
                        ),
                        if (controller.userId == null)
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
                                width: 26.w,
                                height: 26.h,
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
                                child: Icon(
                                  Icons.edit_outlined,
                                  size: 15.w,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 사용자 이름
                      Row(
                        children: [
                          Text(
                            user.nickname,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              height: 1.40,
                              letterSpacing: -0.50,
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 1.h),
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2AD6D6),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: Text(
                              controller.convertLevel(user.level!),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
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
                        style: TextStyle(
                          color: const Color(0xFF767676),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.30,
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      // 한 줄 소개
                      Text(
                        controller.truncateIntro(user.profileIntro),
                        style: TextStyle(
                          color: const Color(0xFF404040),
                          fontSize: 14.sp,
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
              padding: EdgeInsets.only(top: 17.h, left: 16.w),
              child: Row(
                children: [
                  // 직무
                  JobContainer(text: user.job),
                  SizedBox(
                    width: 8.w,
                  ),
                  // 업종
                  JobContainer(text: user.businessType),
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
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
                labelStyle: TextStyle(
                  fontSize: 14.sp,
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

                                  return GestureDetector(
                                    onTap: () {
                                      controller.toDetailPage(post.id!);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(12.0),
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
                                                113.w,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  post.title!,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF111111),
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.30,
                                                    letterSpacing: -0.40,
                                                  ),
                                                ),
                                                Text(
                                                  post.content!,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF111111),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.50,
                                                    letterSpacing: -0.35,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 8.h,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_outline,
                                                      size: 18.w,
                                                      color: const Color(
                                                          0xff767676),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      '${post.likeCount}',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF767676),
                                                        fontSize: 12.sp,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.50,
                                                        letterSpacing: -0.30,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Icon(
                                                      Icons.chat_bubble_outline,
                                                      size: 18.w,
                                                      color: const Color(
                                                          0xff767676),
                                                    ),
                                                    SizedBox(
                                                      width: 5.w,
                                                    ),
                                                    Text(
                                                      '${post.commentCount}',
                                                      style: TextStyle(
                                                        color: const Color(
                                                            0xFF767676),
                                                        fontSize: 12.sp,
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
                                          SizedBox(
                                            width: 15.w,
                                          ),
                                          // 이미지가 있는 경우에만 표시
                                          if (post.imageUrl != null &&
                                              post.imageUrl!.isNotEmpty)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: Image.network(
                                                post.imageUrl!,
                                                width: 66.w,
                                                height: 66.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  width: 66.w,
                                                  height: 66.h,
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[300],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            7),
                                                  ),
                                                  child: const Icon(
                                                      Icons.image_not_supported,
                                                      color: Colors.grey),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              );
                  }),
                  // 경제 톡톡 화면
                  Obx(() {
                    if (controller.economyTalkPosts.isEmpty) {
                      return Center(
                        child: Text(
                          '내가 참여한 경제 톡톡이 없습니다.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF767676),
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
                                  padding: EdgeInsets.only(right: 12.w),
                                  child: // 이미지가 있는 경우에만 표시
                                      post.imageUrl != null &&
                                              post.imageUrl!.isNotEmpty
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(7),
                                              child: Image.network(
                                                post.imageUrl!,
                                                width: 97.w,
                                                height: 118.h,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                        stackTrace) =>
                                                    Container(
                                                  width: 97.w,
                                                  height: 118.h,
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
                                              width: 97.w,
                                              height: 118.h,
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
                                          141.w,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '${post.commentCount}명이 참여했어요',
                                            style: TextStyle(
                                              color: const Color(0xFF767676),
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                              letterSpacing: -0.33,
                                            ),
                                          ),
                                          Text(
                                            post.createdDate!,
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: const Color(0xFFA2A2A2),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              height: 1.50,
                                              letterSpacing: -0.30,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8.h,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          141.w,
                                      height: 60.h,
                                      child: Flexible(
                                        child: Text(
                                          post.title!,
                                          style: TextStyle(
                                            color: const Color(0xFF111111),
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 1.30,
                                            letterSpacing: -0.38,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 12.h,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: Icon(
                                            Icons.favorite_border,
                                            size: 18.w,
                                            color: const Color(0xff767676),
                                          ),
                                        ),
                                        Text(
                                          '${post.likeCount}',
                                          style: TextStyle(
                                            color: const Color(0xFF767676),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(right: 2.w),
                                          child: Icon(
                                            Icons.chat_bubble_outline,
                                            size: 18.w,
                                            color: const Color(0xff767676),
                                          ),
                                        ),
                                        Text(
                                          '${post.commentCount}',
                                          style: TextStyle(
                                            color: const Color(0xFF767676),
                                            fontSize: 12.sp,
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
                      return Center(
                        child: Text(
                          '내가 댓글 단 게시글이 없습니다.',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFF767676),
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
                                    style: TextStyle(
                                      color: const Color(0xFF767676),
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w400,
                                      height: 1.30,
                                      letterSpacing: -0.30,
                                    ),
                                  ),
                                  Text(
                                    post['createdDate'],
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
                              Text(
                                post['comment'],
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  letterSpacing: -0.4,
                                ),
                              ),
                              // 원문글 제목 표시
                              Column(
                                children: [
                                  SizedBox(height: 6.h),
                                  Text(
                                    post['postTitle'],
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
