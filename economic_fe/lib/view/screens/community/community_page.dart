import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view/widgets/home_app_bar.dart';
import 'package:economic_fe/view_model/community/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CommunityPage extends StatelessWidget {
  const CommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityController controller = Get.put(CommunityController());

    int dayCounts = 3;

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
                    onTap: () => controller.toTalkDetailPage(),
                    child: Container(
                      width: 328,
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
                              // 일반게시판 내용
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
                                              onTap: () {
                                                controller.selectCategory(0);
                                              },
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    0,
                                                text: '전체',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectCategory(1);
                                              },
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    1,
                                                text: '자유',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectCategory(2);
                                              },
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    2,
                                                text: '질문',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectCategory(3);
                                              },
                                              child: CategoryTab(
                                                isSelected: controller
                                                        .selectedCategoryIndex
                                                        .value ==
                                                    3,
                                                text: '책추천',
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.selectCategory(4);
                                              },
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
                                    switch (controller
                                        .selectedCategoryIndex.value) {
                                      case 0: // 전체 카테고리 내용
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16),
                                          child: Expanded(
                                            child: Column(
                                              children: [
                                                // 인기순 / 최신순 선택
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .selectOrder(0);
                                                      },
                                                      child: OrderTab(
                                                        text: '인기순',
                                                        isSelected: controller
                                                                .selectedOrder
                                                                .value ==
                                                            0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 6,
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        controller
                                                            .selectOrder(1);
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
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                // 리스트
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height -
                                                      475,
                                                  child: SingleChildScrollView(
                                                    child: ListView.separated(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount:
                                                          10, // 예시 데이터 갯수
                                                      itemBuilder:
                                                          (context, index) {
                                                        // 인기순과 최신순을 구분해서 데이터를 다르게 처리
                                                        if (controller
                                                                .selectedOrder
                                                                .value ==
                                                            0) {
                                                          // 인기순
                                                          return ListItem(
                                                            title:
                                                                '돈 어케 쓰지 (인기순)',
                                                            description:
                                                                '이곳에는 내용이 들어갑니다. 이곳에는 내용이 들어갑니다. 이곳에는 내용이 들어갑니다...',
                                                            date:
                                                                '${index + 1}일 전',
                                                            likes:
                                                                100, // 인기순에 맞는 데이터 예시
                                                            comments:
                                                                50, // 인기순에 맞는 댓글 수
                                                          );
                                                        } else {
                                                          // 최신순
                                                          return ListItem(
                                                            title:
                                                                '돈 어케 쓰지 (최신순)',
                                                            description:
                                                                '이곳에는 내용이 들어갑니다. 이곳에는 내용이 들어갑니다. 이곳에는 내용이 들어갑니다...',
                                                            date:
                                                                '${index + 1}일 전',
                                                            likes:
                                                                10, // 최신순에 맞는 데이터 예시
                                                            comments:
                                                                5, // 최신순에 맞는 댓글 수
                                                          );
                                                        }
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 16),
                                                          child: Container(
                                                            height: 1,
                                                            color: const Color(
                                                                0xffd9d9d9),
                                                          ),
                                                        ); // 항목 사이에 구분선 추가
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      case 1:
                                        return const Center(
                                            child: Text('자유 카테고리 내용'));
                                      case 2:
                                        return const Center(
                                            child: Text('질문 카테고리 내용'));
                                      case 3:
                                        return const Center(
                                            child: Text('책추천 카테고리 내용'));
                                      case 4:
                                        return const Center(
                                            child: Text('정보 공유 카테고리 내용'));
                                      default:
                                        return const Center(
                                            child: Text('전체 카테고리 내용'));
                                    }
                                  })
                                ],
                              ),
                              // 경제톡톡 화면
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 11),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () =>
                                              controller.selectOrder(0),
                                          child: OrderTab(
                                            text: '인기순',
                                            isSelected: controller
                                                    .selectedOrder.value ==
                                                0,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 6,
                                        ),
                                        GestureDetector(
                                          onTap: () =>
                                              controller.selectOrder(1),
                                          child: OrderTab(
                                            text: '최신순',
                                            isSelected: controller
                                                    .selectedOrder.value ==
                                                1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 11,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height -
                                              448,
                                      child: SingleChildScrollView(
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: 10, // 예시 데이터 갯수
                                          itemBuilder: (context, index) {
                                            // 인기순과 최신순을 구분해서 데이터를 다르게 처리
                                            if (controller
                                                    .selectedOrder.value ==
                                                0) {
                                              // 인기순
                                              return TalkListItem(
                                                onTap: () {
                                                  controller.toTalkDetailPage();
                                                },
                                              );
                                            } else {
                                              // 최신순
                                              return TalkListItem(
                                                onTap: () {
                                                  controller.toTalkDetailPage();
                                                },
                                              );
                                            }
                                          },
                                          separatorBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 16),
                                              child: Container(
                                                height: 1,
                                                color: const Color(0xffd9d9d9),
                                              ),
                                            ); // 항목 사이에 구분선 추가
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                bottom: 75,
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
                      Row(
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
                    ],
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
  const TalkListItem({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 경제톡톡 이미지
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: 97,
            height: 118,
            decoration: ShapeDecoration(
              image: const DecorationImage(
                image: AssetImage('assets/talk_image_sample.png'),
                fit: BoxFit.cover,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: 219,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                  Text(
                    '4시간 전',
                    textAlign: TextAlign.right,
                    style: TextStyle(
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
              child: const SizedBox(
                width: 219,
                height: 60,
                child: Flexible(
                  child: Text(
                    '현재 경제 상황에서 가장 중요한 투자 전략은 무엇이라고 생각하나요? 현재 경제 상황에서 가장 중요한 투자 전략...',
                    style: TextStyle(
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
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 2),
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
                Padding(
                  padding: EdgeInsets.only(right: 2),
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
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class CategoryTab extends StatelessWidget {
  final bool isSelected;
  final String text;

  const CategoryTab({
    super.key,
    required this.isSelected,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 6),
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0xff2BD6D6) : Colors.white,
          shape: RoundedRectangleBorder(
            side: isSelected
                ? const BorderSide(width: 1, color: Color(0xff2BD6D6))
                : const BorderSide(width: 1, color: Color(0xFFD9D9D9)),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xffa2a2a2),
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.35,
          ),
        ),
      ),
    );
  }
}

class OrderTab extends StatelessWidget {
  final bool isSelected;
  final String text;

  const OrderTab({
    super.key,
    required this.text,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: Icon(
            Icons.check,
            size: 15,
            color:
                isSelected ? const Color(0xff00D6D6) : const Color(0xffA2A2A2),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            color:
                isSelected ? const Color(0xff404040) : const Color(0xFFA2A2A2),
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.50,
            letterSpacing: -0.30,
          ),
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

  const ListItem({
    super.key,
    required this.title,
    required this.description,
    required this.date,
    required this.likes,
    required this.comments,
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
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.30,
                  letterSpacing: -0.40,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              SizedBox(
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
                    '$comments',
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
          Container(
            width: 66,
            height: 66,
            decoration: ShapeDecoration(
              color: const Color(0xFFD9D9D9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7)),
            ),
          ),
        ],
      ),
    );
  }
}
