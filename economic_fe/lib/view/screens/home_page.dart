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

    // 연속 학습일
    const int dayCounts = 3;

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
      appBar: const HomeAppBar(dayCounts: dayCounts),
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
                                                '${(controller.beginnerProgress.value * 100).toInt()}%',
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
                                                      .beginnerProgress.value,
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
                          return controller.isProgressContainerVisible.value
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
                const Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TodaysQuestChart(
                        icon: 'book_ribbon',
                        text: '개념 학습',
                        quest: 1,
                        progress: 0.65,
                      ),
                      TodaysQuestChart(
                        icon: 'news',
                        text: '경제 기사',
                        quest: 1,
                        progress: 0.75,
                      ),
                      TodaysQuestChart(
                        icon: 'quiz',
                        text: '퀴즈',
                        quest: 1,
                        progress: 0.75,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                // 경제 기사
                TitleWithMoreBtn(
                  title: '경제 기사',
                  onTap: () {
                    // 경제 기사 화면으로 이동
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 경제 기사 예시 (3개)
                const ExampleArticle(
                  category: '경기 분석',
                  headline: '[속보] 정부 “러시아 전면전 감행시 수출 통제 등 제제 동참할 수 밖에"',
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    decoration: const BoxDecoration(
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                ),
                const ExampleArticle(
                  category: '금융',
                  headline: '[속보] 정부 “러시아 전면전 감행시 수출 통제 등 제제 동참할 수 밖에"',
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    decoration: const BoxDecoration(
                      color: Color(0xffd9d9d9),
                    ),
                  ),
                ),
                const ExampleArticle(
                  category: '경기 분석',
                  headline: '[속보] 정부 “러시아 전면전 감행시 수출 통제 등 제제 동참할 수 밖에"',
                ),
                const SizedBox(
                  height: 36,
                ),
                // 경제 톡톡
                TitleWithMoreBtn(
                  title: '경제 톡톡',
                  onTap: () {
                    // 경제 톡톡 화면으로 이동
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 경제 톡톡 주제 컨테이너
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border:
                          Border.all(width: 1, color: const Color(0xFFA2A2A2)),
                      image: DecorationImage(
                        image: const AssetImage(
                            'assets/image_example.png'), // 배경 이미지
                        fit: BoxFit.cover, // 이미지 크기 조정
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.1), // 어두운 색을 덧씌우고 불투명도를 조정
                          BlendMode.darken, // BlendMode.darken을 사용해 이미지를 어둡게 함
                        ),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            '저축은 어떻게?\n체계적으로? 아님?',
                            style: TextStyle(
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
                          // 톡톡에 참여한 사람들
                          Row(
                            children: [
                              // 프로필 (최대 4명)
                              SizedBox(
                                width: 60,
                                height: 18,
                                child: Stack(
                                  children: List.generate(
                                    profileImages.length,
                                    (index) {
                                      // 최대 4명까지 프로필을 띄울 수 있도록 설정
                                      if (index >= 4) return Container();

                                      return Positioned(
                                        left: 14.0 *
                                            index, // 위치를 조금씩 왼쪽으로 이동시켜서 겹치게 함
                                        child: Container(
                                          width: 18,
                                          height: 18,
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFF3F3F3),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(43),
                                            ),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x3F000000),
                                                blurRadius: 1,
                                                offset: Offset(0.20, 0.20),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(43),
                                            child: Image.asset(
                                              profileImages[
                                                  index], // 이미지 리스트에서 해당 이미지를 가져와서 표시
                                              fit: BoxFit
                                                  .cover, // 이미지를 컨테이너에 맞게 조정
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                '$peopleCounts명이 참여했어요',
                                style: TextStyle(
                                  color: Colors.white,
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
                    ),
                  ),
                ),
                const SizedBox(
                  height: 36,
                ),
                // 인기게시물
                TitleWithMoreBtn(
                  title: '인기게시물',
                  onTap: () {
                    // 커뮤니티 화면으로 이동
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                // 인기게시물 2개
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            border: Border(
                              left: BorderSide(
                                  width: 1, color: Color(0xFFA2A2A2)),
                              top: BorderSide(
                                  width: 1, color: Color(0xFFA2A2A2)),
                              right: BorderSide(
                                  width: 1, color: Color(0xFFA2A2A2)),
                            ),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 328, // 최소 너비 제한
                          ),
                          child: const PopularPosts(
                            category: '자유',
                            title: '스레드제목이들어갈공간스레드제목이들어갈공간스',
                            likesCount: 1,
                            commentsCount: 1,
                            time: 4,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          decoration: const ShapeDecoration(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFA2A2A2)),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                            ),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 328, // 최소 너비 제한
                          ),
                          child: const PopularPosts(
                            category: '인기',
                            title: '스레드제목이들어갈공간스레드제목이들어갈공간스',
                            likesCount: 1,
                            commentsCount: 1,
                            time: 4,
                          ),
                        ),
                      ],
                    ),
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
              onTap: controller.hideGoalDialog,
              child: Container(
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: GestureDetector(
                    onTap: () {}, // 다이얼로그 바깥 클릭 무시
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
                                onTap: controller.hideGoalDialog,
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
                              final isMinimum = controller.goalSets[index] ==
                                  controller.minGoalSets;
                              final isMaximum = controller.goalSets[index] ==
                                  controller.maxGoalSets;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 18),
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
                                            onTap: () =>
                                                controller.minusGoalSets(index),
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
                                            '${controller.goalSets[index]}',
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
                                            onTap: () =>
                                                controller.plusGoalSets(index),
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
                              controller.hideGoalDialog();
                              // 저장하는 로직 추가 필요
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
  final int time;

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
              '$time시간 전',
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
