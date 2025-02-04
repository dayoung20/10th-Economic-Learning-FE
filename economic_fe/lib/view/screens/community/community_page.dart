import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/category_tab.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view/widgets/home_app_bar.dart';
import 'package:economic_fe/view/widgets/order_tab.dart';
import 'package:economic_fe/view_model/community/community_controller.dart';
import 'package:flutter/material.dart';
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
      appBar: HomeAppBar(dayCounts: dayCounts),
      body: Obx(() {
        return Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 12),
                Center(
                  child: GestureDetector(
                    onTap: () {}, // 오늘의 경제톡톡 연결 필요
                    child: Container(
                      width: MediaQuery.of(context).size.width - 32,
                      height: 122,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image:
                              const AssetImage('assets/talk_image_sample.png'),
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
                        child: Container(
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/talk_image_sample.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '저축은 어떻게?\n체계적으로? 아님?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  height: 1.2,
                                  letterSpacing: -0.55,
                                ),
                              ),
                              Text(
                                '현재 뜨거운 톡톡!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.35,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 14),
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
                        const TabBar(
                          indicator: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 3,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          indicatorSize: TabBarIndicatorSize.tab,
                          labelStyle: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 1.50,
                            letterSpacing: -0.35,
                          ),
                          unselectedLabelStyle: TextStyle(
                            color: Color(0xFF767676),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.50,
                            letterSpacing: -0.35,
                          ),
                          tabs: [
                            Tab(
                              text: '일반게시판',
                              height: 44,
                            ),
                            Tab(
                              text: '경제톡톡',
                              height: 44,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 10),
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16),
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
                                          const SizedBox(height: 5),
                                          // 리스트
                                          controller.isLoading.value
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator()) // 로딩 UI
                                              : SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      475,
                                                  child: posts.isEmpty
                                                      ? const Center(
                                                          child: Text(
                                                              '게시글이 없습니다.'))
                                                      : SingleChildScrollView(
                                                          child: ListView
                                                              .separated(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount:
                                                                posts.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
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
                                                                  title: post[
                                                                      "title"],
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
                                                                            post["id"]);
                                                                  },
                                                                ),
                                                              );
                                                            },
                                                            separatorBuilder:
                                                                (context,
                                                                    index) {
                                                              return Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            16),
                                                                child:
                                                                    Container(
                                                                  height: 1,
                                                                  color: const Color(
                                                                      0xffd9d9d9),
                                                                ),
                                                              );
                                                            },
                                                          ),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Column(
                                    children: [
                                      // 인기순 / 최신순 선택
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
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
                                            const SizedBox(width: 6),
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
                                          : SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height -
                                                  475,
                                              child: tokPosts.isEmpty
                                                  ? const Center(
                                                      child: Text('게시글이 없습니다.'))
                                                  : SingleChildScrollView(
                                                      child: ListView.separated(
                                                        shrinkWrap: true,
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        itemCount:
                                                            tokPosts.length,
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
                                                            participantCount:
                                                                tokPost[
                                                                    'participantCount'],
                                                            createdDate: tokPost[
                                                                'createdDate'],
                                                            title: tokPost[
                                                                'title'],
                                                            likeCount: tokPost[
                                                                'likeCount'],
                                                            commentCount:
                                                                0, // 댓글 수 연결 필요
                                                          );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .symmetric(
                                                                    vertical:
                                                                        16),
                                                            child: Container(
                                                              height: 1,
                                                              color: const Color(
                                                                  0xffd9d9d9),
                                                            ),
                                                          );
                                                        },
                                                      ),
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
                bottom: 135,
                right: 15,
                child: Container(
                  width: 156,
                  height: 88,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
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
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '챗봇',
                              style: TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 14,
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
                              width: 24,
                              height: 24,
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              '글쓰기',
                              style: TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 14,
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
                bottom: 75,
                right: 15,
                child: GestureDetector(
                  onTap: () {
                    controller.toggleModal();
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const ShapeDecoration(
                      color: Colors.white,
                      shape: OvalBorder(),
                    ),
                    child: const Icon(
                      Icons.close,
                      size: 25,
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
          width: 48,
          height: 48,
          decoration: const ShapeDecoration(
            color: Color(0xFF2AD6D6),
            shape: OvalBorder(),
          ),
          child: const Icon(
            Icons.add,
            size: 25,
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
          padding: const EdgeInsets.only(right: 12),
          child: // 이미지가 있는 경우에만 표시
              imageUrl != null && imageUrl!.isNotEmpty
                  ? GestureDetector(
                      onTap: onTap,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(7),
                        child: Image.network(
                          imageUrl!,
                          width: 97,
                          height: 118,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            width: 97,
                            height: 118,
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
                        width: 97,
                        height: 118,
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
              width: MediaQuery.of(context).size.width - (32 + 97 + 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$participantCount명이 참여했어요',
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.33,
                    ),
                  ),
                  Text(
                    createdDate,
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
            GestureDetector(
              onTap: onTap,
              child: SizedBox(
                width: MediaQuery.of(context).size.width - (32 + 97 + 12),
                height: 60,
                child: Flexible(
                  child: Text(
                    title,
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
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
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
                  '$likeCount',
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
                  '$commentCount',
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
      padding: const EdgeInsets.symmetric(horizontal: 8),
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
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.40,
                  ),
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              GestureDetector(
                onTap: onTap,
                child: SizedBox(
                  width: 235,
                  height: 42,
                  child: Flexible(
                    child: Text(
                      description,
                      style: const TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.35,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
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
                    '$likes',
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.30,
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
                    comments < 0 ? '0' : '$comments',
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.30,
                    ),
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    date,
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
            ],
          ),
          // 이미지가 있는 경우에만 표시
          if (imageUrl != null && imageUrl!.isNotEmpty)
            GestureDetector(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: Image.network(
                  imageUrl!,
                  width: 66,
                  height: 66,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Icon(Icons.image_not_supported,
                        color: Colors.grey),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
