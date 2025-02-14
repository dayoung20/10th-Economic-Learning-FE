import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/circular_chart.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view/widgets/home_app_bar.dart';
import 'package:economic_fe/view_model/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final HomeController controller = Get.put(HomeController());

    // 경제 톡톡 참여자 프로필 사진 리스트
    const List<String> profileImages = [
      'assets/profile_example.png',
      'assets/profile_example.png',
      'assets/profile_example.png',
      'assets/profile_example.png',
    ];
    const int peopleCounts = 134; // 경제톡톡 참여자 수

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const HomeAppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  child: HomeTitle(
                    title: '나의 학습 현황',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                // 학습 현황 컨테이너
                Center(
                  child: Container(
                    width: 317,
                    height: 292,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            width: 1, color: Color(0xFFA2A2A2)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // 진도율
                                  const Row(
                                    children: [
                                      Text(
                                        '진도율',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF111111),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: -0.35,
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 2),
                                        child: Icon(
                                          Icons.help_outline,
                                          size: 14,
                                          color: Color(0xffa2a2a2),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // 전체 세트 보기 버튼
                                  HomeSmallButton(
                                    controller: controller,
                                    onTap: () {
                                      controller.navigateToLearningList();
                                    },
                                    text: '전체 세트 보기',
                                  ),
                                ],
                              ),
                              // 진도율 그래프
                              Obx(() {
                                return SizedBox(
                                  width: 240,
                                  height: 156,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      // Beginner
                                      SizedBox(
                                        width: 72,
                                        height: 156,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 44,
                                              child: Text(
                                                '${(controller.beginnerProgress.value).toInt()}%',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                  letterSpacing: -0.30,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 36,
                                              height: controller.maxHeight *
                                                  controller
                                                      .beginnerProgress.value *
                                                  0.01,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFB1F2F2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Beginner',
                                              style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                                letterSpacing: -0.30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Intermediate
                                      SizedBox(
                                        width: 72,
                                        height: 156,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 44,
                                              child: Text(
                                                '${(controller.intermediateProgress.value * 100).toInt()}%',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                  letterSpacing: -0.30,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 36,
                                              height: controller.maxHeight *
                                                  controller
                                                      .intermediateProgress
                                                      .value,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFB1F2F2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Intermediate',
                                              style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                                letterSpacing: -0.30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Advanced
                                      SizedBox(
                                        width: 72,
                                        height: 156,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 44,
                                              child: Text(
                                                '${(controller.advancedProgress.value * 100).toInt()}%',
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                  color: Color(0xFF111111),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.50,
                                                  letterSpacing: -0.30,
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 36,
                                              height: controller.maxHeight *
                                                  controller
                                                      .advancedProgress.value,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFB1F2F2),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft: Radius.circular(4),
                                                    topRight:
                                                        Radius.circular(4),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const Text(
                                              'Advanced',
                                              style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                height: 1.50,
                                                letterSpacing: -0.30,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),

                              Container(
                                width: 269,
                                height: 44,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFF2AD6D6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                // 학습 하러 가기 버튼
                                child: GestureDetector(
                                  onTap: () {
                                    // 학습 진행 상황에 따라 다음 화면 반환하는 로직 필요
                                    controller.navigateToLearningList();
                                  },
                                  child: const Center(
                                    child: Text(
                                      '학습 하러 가기',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        height: 1.50,
                                        letterSpacing: -0.45,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Obx(() {
                          return controller.isProgressContainerVisible.value ==
                                  false
                              ? Container(
                                  width: 337,
                                  height: 292,
                                  decoration: ShapeDecoration(
                                    color: const Color(0xBF111111),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Stack(
                                      children: [
                                        // 창 닫기 버튼
                                        Positioned(
                                          right: 0,
                                          child: GestureDetector(
                                            onTap: () => controller
                                                .isProgressContainerVisible
                                                .value = false,
                                            child: const Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Center(
                                              child: Text(
                                                '레벨테스트를 진행해야 \n더 정확한 학습이 가능해요.',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                  height: 1.30,
                                                  letterSpacing: -0.50,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            GestureDetector(
                                              onTap: () =>
                                                  controller.toLevelTest(),
                                              child: Center(
                                                child: Container(
                                                  width: 280,
                                                  height: 60,
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        Palette.buttonColorBlue,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              16),
                                                    ),
                                                  ),
                                                  child: const Center(
                                                    child: Text(
                                                      '레벨테스트 시작하기',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        height: 1.20,
                                                        letterSpacing: -0.45,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : const SizedBox();
                        }),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                // 오늘의 퀘스트
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        '오늘의 퀘스트',
                        style: TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 1.30,
                          letterSpacing: -0.50,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      // 목표 변경하기 버튼
                      HomeSmallButton(
                        controller: controller,
                        onTap: controller.showGoalDialog,
                        text: '목표 변경하기',
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 18,
                ),
                Center(
                  child: Obx(() {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TodaysQuestChart(
                          icon: 'book_ribbon',
                          text: '개념 학습',
                          quest: controller.goalSets[0],
                          progress: 0.65,
                        ),
                        TodaysQuestChart(
                          icon: 'news',
                          text: '경제 기사',
                          quest: controller.goalSets[1],
                          progress: 0.75,
                        ),
                        TodaysQuestChart(
                          icon: 'quiz',
                          text: '퀴즈',
                          quest: controller.goalSets[2],
                          progress: 0.75,
                        ),
                      ],
                    );
                  }),
                ),
                const SizedBox(
                  height: 36,
                ),
                // 경제 기사
                TitleWithMoreBtn(
                  title: '경제 기사',
                  onTap: () {
                    // 경제 기사 화면으로 이동
                    Get.toNamed('/article');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 경제 기사 리스트 불러오기
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (controller.articles.isEmpty) {
                    return const Center(child: Text("불러올 경제 기사가 없습니다."));
                  }

                  return Column(
                    children: List.generate(
                      5,
                      (index) {
                        if (index.isOdd) {
                          return Padding(
                            padding: const EdgeInsets.all(8),
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1,
                              height: 16,
                            ),
                          );
                        }

                        final article = controller.articles[index ~/ 2];
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              '/article/detail',
                              arguments: article,
                            );
                          },
                          child: ExampleArticle(
                            category: article.translatedCategory,
                            headline: article.title ?? "제목 없음",
                          ),
                        );
                      },
                    ),
                  );
                }),

                const SizedBox(
                  height: 36,
                ),
                // 경제 톡톡
                TitleWithMoreBtn(
                  title: '경제 톡톡',
                  onTap: () {
                    Get.toNamed('/community');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 경제 톡톡 주제 컨테이너
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 1, color: const Color(0xFFA2A2A2)),
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
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                todaysTok['title'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -0.55,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                '현재 뜨거운 톡톡!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontFamily: 'Pretendard Variable',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.35,
                                ),
                              ),
                              const SizedBox(
                                height: 49,
                              ),
                              // API에서 받아온 랜덤 프로필 리스트 활용
                              Row(
                                children: [
                                  Obx(() {
                                    int profileCount = controller
                                        .participantProfileImages.length
                                        .clamp(0, 4); // 최대 4개
                                    double spacing = profileCount > 0
                                        ? 14.0 * (profileCount - 1) + 20
                                        : 0;

                                    return SizedBox(
                                      width: spacing, // 프로필 개수에 따른 크기 조절
                                      height: 18,
                                      child: Stack(
                                        children: List.generate(
                                          profileCount,
                                          (index) {
                                            return Positioned(
                                              left: 14.0 * index, // 위치를 겹치게 조정
                                              child: Container(
                                                width: 18,
                                                height: 18,
                                                decoration: ShapeDecoration(
                                                  color:
                                                      const Color(0xFFF3F3F3),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            43),
                                                  ),
                                                  shadows: const [
                                                    BoxShadow(
                                                      color: Color(0x3F000000),
                                                      blurRadius: 1,
                                                      offset:
                                                          Offset(0.20, 0.20),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(43),
                                                  child: controller
                                                          .participantProfileImages[
                                                              index]
                                                          .isNotEmpty
                                                      ? Image.network(
                                                          controller
                                                                  .participantProfileImages[
                                                              index],
                                                          fit: BoxFit.cover,
                                                          errorBuilder: (context,
                                                                  error,
                                                                  stackTrace) =>
                                                              Image.asset(
                                                                  'assets/default_profile.png'),
                                                        )
                                                      : Image.asset(
                                                          'assets/default_profile.png'), // 기본 이미지
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    );
                                  }),

                                  // 🔹 프로필 개수에 따라 동적으로 간격 조정
                                  Obx(() {
                                    int profileCount = controller
                                        .participantProfileImages.length
                                        .clamp(0, 4);
                                    double textPadding =
                                        profileCount > 0 ? 5.0 : 0;

                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: textPadding), // 동적 간격 조절
                                      child: Text(
                                        '${controller.todaysTokDetail["participantCount"] ?? 0}명이 참여했어요',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 1.50,
                                          letterSpacing: -0.30,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(
                  height: 36,
                ),
                // 인기게시물
                TitleWithMoreBtn(
                  title: '인기게시물',
                  onTap: () {
                    // 커뮤니티 화면으로 이동
                    Get.toNamed('/community');
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 인기게시물 2개
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                            child: CircularProgressIndicator()); // 로딩 중
                      }

                      if (controller.popularPosts.isEmpty) {
                        return const Center(
                            child: Text("불러올 인기 게시글이 없습니다.")); // 게시글 없음
                      }

                      return Column(
                        children: List.generate(
                          controller.popularPosts.length.clamp(0, 2), // 최대 2개
                          (index) {
                            final post = controller.popularPosts[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 20),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(index == 0 ? 16 : 0),
                                  topRight:
                                      Radius.circular(index == 0 ? 16 : 0),
                                  bottomLeft:
                                      Radius.circular(index == 1 ? 16 : 0),
                                  bottomRight:
                                      Radius.circular(index == 1 ? 16 : 0),
                                ),
                                border: Border(
                                    left: const BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    right: const BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    top: const BorderSide(
                                        width: 1, color: Color(0xFFA2A2A2)),
                                    bottom: index == 1
                                        ? const BorderSide(
                                            // width: index == 1 ? 1 : 0,
                                            width: 1,
                                            color: Color(0xFFA2A2A2))
                                        : BorderSide.none),
                              ),
                              child: PopularPosts(
                                category: post.translatedType,
                                title: post.title!,
                                likesCount: post.likeCount!,
                                commentsCount: post.commentCount!,
                                time: post.createdDate!,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 48,
                ),
              ],
            ),
          ),
          Obx(() {
            if (!controller.isDialogVisible.value) {
              return const SizedBox.shrink();
            }
            return GestureDetector(
              onTap: () {
                controller.hideGoalDialog();
                controller.resetGoalSets();
              },
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 32,
                    height: 360,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 24),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              '오늘의 퀘스트 변경',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                height: 1.20,
                                letterSpacing: -0.45,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.hideGoalDialog();
                                controller.resetGoalSets();
                              },
                              child: const Icon(Icons.close),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 26, right: 26, bottom: 2),
                          child: Container(
                            height: 1,
                            color: const Color(0xffd9d9d9),
                          ),
                        ),
                        Column(
                          children: List.generate(3, (index) {
                            String questTitle = '';
                            switch (index) {
                              case 0:
                                questTitle = '개념학습';
                                break;
                              case 1:
                                questTitle = '경제 기사';
                                break;
                              default:
                                questTitle = '퀴즈';
                                break;
                            }
                            final isMinimum = controller.tempGoalSets[index] ==
                                controller.minGoalSets;
                            final isMaximum = controller.tempGoalSets[index] ==
                                controller.maxGoalSets;
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    questTitle,
                                    style: const TextStyle(
                                      color: Color(0xFF111111),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      height: 1.60,
                                      letterSpacing: -0.45,
                                    ),
                                  ),
                                  Obx(() {
                                    return Row(
                                      children: [
                                        // - 버튼
                                        GestureDetector(
                                          onTap: () => controller
                                              .minusTempGoalSets(index),
                                          child: Icon(
                                            Icons.remove_circle_outline,
                                            color: isMinimum
                                                ? const Color(0xffd9d9d9)
                                                : const Color(0xffa2a2a2),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        // 세트 수
                                        Text(
                                          '${controller.tempGoalSets[index]}',
                                          style: const TextStyle(
                                            color: Color(0xFF111111),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            height: 1.20,
                                          ),
                                        ),
                                        const Text(
                                          '세트',
                                          style: TextStyle(
                                            color: Color(0xFF111111),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.20,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        // + 버튼
                                        GestureDetector(
                                          onTap: () => controller
                                              .plusTempGoalSets(index),
                                          child: Icon(
                                            Icons.add_circle_outline,
                                            color: isMaximum
                                                ? const Color(0xffd9d9d9)
                                                : const Color(0xffa2a2a2),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
                            );
                          }),
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        // 저장하기 버튼
                        GestureDetector(
                          onTap: () {
                            controller.setUserGoal();
                            controller.saveGoalSets();
                            controller.hideGoalDialog();
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width - 84,
                            height: 60,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF2AD6D6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                '저장하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  height: 1.20,
                                  letterSpacing: -0.45,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
      // 하단바
      bottomNavigationBar: const CustomBottomBar(
        currentIndex: 0,
      ),
    );
  }
}

class PopularPosts extends StatelessWidget {
  final String category;
  final String title;
  final int likesCount;
  final int commentsCount;
  final String time;

  const PopularPosts({
    super.key,
    required this.category,
    required this.title,
    required this.likesCount,
    required this.commentsCount,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
          decoration: ShapeDecoration(
            color: const Color(0xFF2AD6D6),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          ),
          child: Text(
            category,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.50,
              letterSpacing: -0.30,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            color: Color(0xFF404040),
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.50,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.favorite_border,
              size: 20,
              color: Color(0xff767676),
            ),
            const SizedBox(
              width: 4,
            ),
            // 좋아요 수
            Text(
              '$likesCount',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF767676),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
                letterSpacing: -0.35,
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.chat_bubble_outline,
              size: 20,
              color: Color(0xff767676),
            ),
            const SizedBox(
              width: 4,
            ),
            // 댓글 수
            Text(
              '$commentsCount',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color(0xFF767676),
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.50,
                letterSpacing: -0.35,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            // 게시글 업로드 시간
            Text(
              time,
              textAlign: TextAlign.center,
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
    );
  }
}

class TitleWithMoreBtn extends StatelessWidget {
  final String title;
  final void Function() onTap;

  const TitleWithMoreBtn({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            HomeTitle(title: title),
            // 더보기 버튼
            GestureDetector(
              onTap: onTap,
              child: const Row(
                children: [
                  Text(
                    '더보기',
                    style: TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 10,
                    color: Color(0xff767676),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExampleArticle extends StatelessWidget {
  final String category;
  final String headline;

  const ExampleArticle({
    super.key,
    required this.category,
    required this.headline,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            category,
            style: const TextStyle(
              color: Color(0xFF2AD6D6),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 1.30,
              letterSpacing: -0.30,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            headline,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              height: 1.30,
              letterSpacing: -0.40,
            ),
          ),
        ],
      ),
    );
  }
}

class TodaysQuestChart extends StatelessWidget {
  final double progress;
  final String icon;
  final String text;
  final int quest;

  const TodaysQuestChart({
    super.key,
    required this.icon,
    required this.text,
    required this.quest,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          CircularChart(
            progress: progress,
            icon: icon,
            text: text,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '$quest',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  height: 1.20,
                ),
              ),
              const Text(
                '세트',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.20,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HomeSmallButton extends StatelessWidget {
  final void Function() onTap;
  final String text;

  const HomeSmallButton({
    super.key,
    required this.controller,
    required this.onTap,
    required this.text,
  });

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 26,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFA2A2A2)),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Color(0xFF767676),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 1.50,
                letterSpacing: -0.30,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            const Icon(
              Icons.arrow_forward_ios,
              size: 9.42,
              color: Color(0xff767676),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeTitle extends StatelessWidget {
  final String title;

  const HomeTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF111111),
        fontSize: 20,
        fontWeight: FontWeight.w500,
        height: 1.30,
        letterSpacing: -0.50,
      ),
    );
  }
}
