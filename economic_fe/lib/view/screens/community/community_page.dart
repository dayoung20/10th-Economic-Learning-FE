import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/category_tab.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view/widgets/home_app_bar.dart';
import 'package:economic_fe/view/widgets/order_tab.dart';
import 'package:economic_fe/view_model/community/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final CommunityController controller = Get.put(CommunityController());
  int dayCounts = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const HomeAppBar(),
      body: Obx(() {
        return Stack(
          children: [
            Column(
              children: [
                SizedBox(height: 12.h),
                Center(
                  child: Obx(() {
                    if (controller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    var todaysTok = controller.todaysTokDetail;
                    if (todaysTok.isEmpty) {
                      return const Center(child: Text("오늘의 경제톡톡을 불러올 수 없습니다."));
                    }

                    return GestureDetector(
                      onTap: () {
                        controller.toTalkDetailPage(todaysTok['id']);
                      }, // 오늘의 경제톡톡 연결 필요
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32.w,
                        height: 122.h,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: todaysTok['imageUrl'] != null
                                ? NetworkImage(todaysTok['imageUrl'])
                                : const AssetImage(
                                    'assets/talk_image_sample.png'), // 오늘의 경제톡톡 대표 이미지 연결 필요
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.35), // 어두운 필터 추가
                              BlendMode.darken, // 어두운 필터 적용
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFA2A2A2)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                todaysTok['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: -0.55,
                                ),
                              ),
                              Text(
                                '현재 뜨거운 톡톡!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                SizedBox(height: 14.h),
                // 일반 게시물 / 경제톡톡 탭
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  decoration: const BoxDecoration(color: Colors.black),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    child: Column(
                      children: [
                        TabBar(
                          indicator: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.35,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: const Color(0xFF767676),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                            letterSpacing: -0.35,
                          ),
                          tabs: [
                            Tab(
                              text: '일반게시판',
                              height: 44.h,
                            ),
                            Tab(
                              text: '경제톡톡',
                              height: 44.h,
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              // 일반게시판 내용 (서버 데이터 적용)
                              Column(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 12.w, vertical: 10.h),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.selectCategory(0),
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    0,
                                                text: '전체',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.selectCategory(1),
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    1,
                                                text: '자유',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.selectCategory(2),
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    2,
                                                text: '질문',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.selectCategory(3),
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    3,
                                                text: '책추천',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.selectCategory(4),
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    4,
                                                text: '정보 공유',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Obx(() {
                                    // 선택된 카테고리에 따라 데이터 필터링
                                    var posts = controller.postList;

                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 16.w),
                                      child: Column(
                                        children: [
                                          // 인기순 / 최신순 선택
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectOrder(0);
                                                },
                                                child: OrderTab(
                                                  text: '인기순',
                                                  isSelected: controller
                                                          .selectedOrder
                                                          .value ==
                                                      0,
                                                ),
                                              ),
                                              const SizedBox(width: 6),
                                              GestureDetector(
                                                onTap: () {
                                                  controller.selectOrder(1);
                                                },
                                                child: OrderTab(
                                                  text: '최신순',
                                                  isSelected: controller
                                                          .selectedOrder
                                                          .value ==
                                                      1,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 5.h),
                                          // 리스트
                                          controller.isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator()) // 로딩 UI
                                              : posts.isEmpty
                                                  ? const Center(
                                                      child: Text('게시글이 없습니다.'))
                                                  : SizedBox(
                                                      height: 270.h,
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        itemCount: posts.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          var post =
                                                              posts[index];

                                                          return GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .toDetailPage(
                                                                      post[
                                                                          "id"]);
                                                            },
                                                            child: ListItem(
                                                              title:
                                                                  post["title"],
                                                              description: post[
                                                                  "content"],
                                                              date: post[
                                                                  "createdDate"],
                                                              likes: post[
                                                                  "likeCount"],
                                                              comments: post[
                                                                  "commentCount"],
                                                              imageUrl: post[
                                                                  "imageUrl"],
                                                              onTap: () {
                                                                controller
                                                                    .toDetailPage(
                                                                        post[
                                                                            "id"]);
                                                              },
                                                            ),
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    vertical:
                                                                        16.h),
                                                            child: Container(
                                                              height: 1,
                                                              color: const Color(
                                                                  0xffd9d9d9),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              // 경제톡톡 화면
                              Obx(() {
                                // 선택된 카테고리에 따라 데이터 필터링
                                var tokPosts = controller.tokPostList;
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.w),
                                  child: Column(
                                    children: [
                                      // 인기순 / 최신순 선택
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Row(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectTokOrder(0);
                                              },
                                              child: OrderTab(
                                                text: '인기순',
                                                isSelected: controller
                                                        .selectedTokOrder
                                                        .value ==
                                                    0,
                                              ),
                                            ),
                                            SizedBox(width: 6.w),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectTokOrder(1);
                                              },
                                              child: OrderTab(
                                                text: '최신순',
                                                isSelected: controller
                                                        .selectedTokOrder
                                                        .value ==
                                                    1,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // 리스트
                                      controller.isLoading.value
                                          ? const Center(
                                              child:
                                                  CircularProgressIndicator()) // 로딩 UI
                                          : tokPosts.isEmpty
                                              ? const Center(
                                                  child: Text('게시글이 없습니다.'))
                                              : SizedBox(
                                                  height: 270.h,
                                                  child: ListView.separated(
                                                    shrinkWrap: true,
                                                    itemCount: tokPosts.length,
                                                    itemBuilder:
                                                        (context, index) {
                                                      var tokPost =
                                                          tokPosts[index];

                                                      return TalkListItem(
                                                        onTap: () {
                                                          controller
                                                              .toTalkDetailPage(
                                                                  tokPost[
                                                                      "id"]);
                                                        },
                                                        participantCount: tokPost[
                                                            'participantCount'],
                                                        createdDate: tokPost[
                                                            'createdDate'],
                                                        title: tokPost['title'],
                                                        likeCount: tokPost[
                                                            'likeCount'],
                                                        commentCount: tokPost[
                                                            'participantCount'], // 댓글 수 연결 필요
                                                        imageUrl:
                                                            tokPost['imageUrl'],
                                                      );
                                                    },
                                                    separatorBuilder:
                                                        (context, index) {
                                                      return Padding(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                vertical: 16.h),
                                                        child: Container(
                                                          height: 1,
                                                          color: const Color(
                                                              0xffd9d9d9),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                    ],
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (controller.isModalVisible.value)
              Positioned.fill(
                child: GestureDetector(
                  onTap: controller.toggleModal, // 화면 탭 시 다이얼로그 숨기기
                  child: Container(
                    color: Colors.black.withOpacity(0.5), // 어두운 배경
                  ),
                ),
              ),
            if (controller.isModalVisible.value)
              Positioned(
                bottom: 135.h,
                right: 15.w,
                child: Container(
                  width: 156.w,
                  height: 88.h,
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.toChatPage();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/chatbot_green.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '챗봇',
                              style: TextStyle(
                                color: const Color(0xFF404040),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.toNewPost();
                        },
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/edit_square.png',
                              width: 24.w,
                              height: 24.h,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '글쓰기',
                              style: TextStyle(
                                color: const Color(0xFF404040),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.40,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (controller.isModalVisible.value)
              Positioned(
                bottom: 75.h,
                right: 15.w,
                child: GestureDetector(
                  onTap: () {
                    controller.toggleModal();
                  },
                  child: Container(
                    width: 48.w,
                    height: 48.h,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                    ),
                    child: Icon(
                      Icons.close,
                      size: 25.w,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        );
      }),
      floatingActionButton: GestureDetector(
        onTap: () {
          controller.toggleModal();
        },
        child: Container(
          width: 48.w,
          height: 48.h,
          decoration: const ShapeDecoration(
            color: Color(0xFF2AD6D6),
            shape: OvalBorder(),
          ),
          child: Icon(
            Icons.add,
            size: 25.w,
            color: Colors.white,
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 3),
    );
  }
}

class TalkListItem extends StatelessWidget {
  final Function() onTap;
  final String? imageUrl;
  final int participantCount;
  final String createdDate;
  final String title;
  final int likeCount;
  final int commentCount;

  const TalkListItem({
    super.key,
    required this.onTap,
    this.imageUrl,
    required this.participantCount,
    required this.createdDate,
    required this.title,
    required this.likeCount,
    required this.commentCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // 경제톡톡 이미지
        Padding(
          padding: EdgeInsets.only(right: 12.w),
          child: // 이미지가 있는 경우에만 표시
              imageUrl != null && imageUrl!.isNotEmpty
                  ? GestureDetector(
                      onTap: onTap,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          imageUrl!,
                          width: 97.w,
                          height: 118.h,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 97.w,
                            height: 118.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(Icons.image_not_supported,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 97.w,
                        height: 118.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(7),
                          image: const DecorationImage(
                            image: AssetImage('assets/talk_image_sample.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width - 141.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$participantCount명이 참여했어요',
                    style: TextStyle(
                      color: const Color(0xFF767676),
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.33,
                    ),
                  ),
                  Text(
                    createdDate,
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
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 141.w,
                height: 60.h,
                child: Flexible(
                  child: Text(
                    title,
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
            ),
            SizedBox(
              height: 12.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  '$likeCount',
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
                    size: 18.sp,
                    color: const Color(0xff767676),
                  ),
                ),
                Text(
                  '$commentCount',
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
    );
  }
}

class ListItem extends StatelessWidget {
  final String title;
  final String description;
  final String date;
  final int likes;
  final int comments;
  final String? imageUrl;
  final Function() onTap;

  const ListItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.likes,
    required this.comments,
    required this.onTap,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onTap,
                child: Text(
                  title,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  width: 235.w,
                  height: 42.h,
                  child: Flexible(
                    child: Text(
                      description,
                      style: TextStyle(
                        color: const Color(0xFF111111),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.35,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Icon(
                      Icons.favorite_border,
                      size: 18.sp,
                      color: const Color(0xff767676),
                    ),
                  ),
                  Text(
                    '$likes',
                    style: TextStyle(
                      color: const Color(0xFF767676),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.30,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: Icon(
                      Icons.chat_bubble_outline,
                      size: 18.sp,
                      color: const Color(0xff767676),
                    ),
                  ),
                  Text(
                    comments < 0 ? '0' : '$comments',
                    style: TextStyle(
                      color: const Color(0xFF767676),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.30,
                    ),
                  ),
                  SizedBox(
                    width: 14.w,
                  ),
                  Text(
                    date,
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
            ],
          ),
          // 이미지가 있는 경우에만 표시
          imageUrl != null && imageUrl!.isNotEmpty
              ? GestureDetector(
                  onTap: onTap,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: Image.network(
                      imageUrl!,
                      width: 66.w,
                      height: 66.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 66.w,
                        height: 66.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(7),
                        ),
                        child: const Icon(Icons.image_not_supported,
                            color: Colors.grey),
                      ),
                    ),
                  ),
                )
              : Image.asset(
                  'assets/empty_post_image.png',
                  width: 66.w,
                  height: 66.h,
                ),
        ],
      ),
    );
  }
}
