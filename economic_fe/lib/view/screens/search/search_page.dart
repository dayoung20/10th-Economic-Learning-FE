import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/models/community/post_model.dart';
import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  final SearchPageController controller = Get.put(SearchPageController());

  late TabController tabController; // TabController를 상태에서 직접 관리

  @override
  void initState() {
    super.initState();
    tabController =
        TabController(length: controller.categories.length, vsync: this);
    tabController.addListener(() {
      controller.changeTab(tabController.index);
    });
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '검색',
        icon: Icons.close,
        onPress: () => Get.back(),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 21),
          Obx(() =>
              controller.isSearching.value && controller.isTextNotEmpty.value
                  ? _buildTabBar()
                  : _buildRecentSearches()),
          Expanded(
            child: Obx(() =>
                controller.isSearching.value && controller.isTextNotEmpty.value
                    ? _buildSearchResults()
                    : const SizedBox()),
          ),
        ],
      ),
    );
  }

  /// 검색창 UI
  Widget _buildSearchBar() {
    return Center(
      child: Container(
        width: Get.width - 32,
        height: 42,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: ShapeDecoration(
          color: const Color(0xFFF2F3F5),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(52)),
        ),
        child: Row(
          children: [
            const Icon(Icons.search, color: Color(0xffa2a2a2)),
            const SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: controller.searchController,
                cursorColor: const Color(0xff111111),
                style: const TextStyle(fontSize: 16, color: Color(0xFF111111)),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: '검색어를 입력해주세요.',
                  hintStyle: TextStyle(color: Color(0xFFA2A2A2), fontSize: 16),
                ),
                onSubmitted: (value) {
                  controller.search(value);
                  tabController.index = 0; // 검색 실행 시 기본 카테고리를 "통합"으로 설정
                },
              ),
            ),
            Obx(() {
              return controller.isTextNotEmpty.value
                  ? GestureDetector(
                      onTap: () {
                        controller.searchController.clear();
                        controller.isTextNotEmpty.value = false;
                      },
                      child: const Icon(Icons.close, color: Colors.grey),
                    )
                  : const SizedBox();
            }),
          ],
        ),
      ),
    );
  }

  /// 가로 스크롤 가능한 탭바 (수정)
  Widget _buildTabBar() {
    return SizedBox(
      height: 50,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        controller: tabController,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          height: 1.50,
          letterSpacing: -0.40,
        ),
        unselectedLabelColor: Colors.grey,
        tabs: controller.categories
            .map((category) => Tab(text: category))
            .toList(),
      ),
    );
  }

  /// 검색 결과 UI (탭별 표시)
  Widget _buildSearchResults() {
    return Expanded(
      child: Obx(() {
        if (controller.selectedTabIndex.value == 0) {
          return _buildAll(
            controller.searchTerms,
            controller.searchNews,
            controller.searchPosts,
          );
        }

        List<dynamic> results;
        switch (controller.selectedTabIndex.value) {
          case 1: // 용어사전
            results = controller.searchTerms;
            break;
          case 2: // 경제 기사
            results = controller.searchNews;
            break;
          default: // 일반 게시판
            results = controller.searchPosts;
        }

        return results.isEmpty
            ? const Center(child: Text("결과가 없습니다."))
            : ListView.separated(
                separatorBuilder: (_, __) => const Divider(
                  color: Color(0xffd9d9d9),
                  thickness: 1,
                  height: 0,
                ),
                itemCount: results.length,
                itemBuilder: (_, i) {
                  switch (controller.selectedTabIndex.value) {
                    case 0: // 통합
                      return _buildAll(results[i], results[i], results[i]);

                    case 1: // 용어사전 (Dictionary)
                      return _buildDictionaryCard(results[i]);

                    case 2: // 경제 기사 (News)
                      return _buildNewsCard(results[i]);

                    case 3: // 일반 게시글
                      return _buildPostCard(results[i]);

                    default: // 일반 게시글 (Posts)
                      return _buildPostCard(results[i]);
                  }
                },
              );
      }),
    );
  }

  /// 통합 검색 결과 (카테고리별 표시)
  Widget _buildAll(List<DictionaryModel> terms, List<ArticleModel> news,
      List<PostModel> posts) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (terms.isNotEmpty)
            _buildCategorySection("용어 사전", terms, _buildDictionaryCard, 1),
          if (news.isNotEmpty)
            _buildCategorySection("경제 기사", news, _buildNewsCard, 2),
          if (posts.isNotEmpty)
            _buildCategorySection("일반 게시판", posts, _buildPostCard, 3),
        ],
      ),
    );
  }

  /// 통합 탭의 각 카테고리 섹션
  Widget _buildCategorySection<T>(String title, List<T> items,
      Widget Function(T) itemBuilder, int tabIndex) {
    if (items.isEmpty) return const SizedBox(); // 아이템이 없으면 표시하지 않음

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 16, right: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                  letterSpacing: -0.45,
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.changeTab(tabIndex); // 해당 카테고리 탭으로 이동
                  tabController.animateTo(tabIndex);
                },
                child: const Row(
                  children: [
                    Text(
                      '더보기',
                      style: TextStyle(
                        color: Color(0xFF767676),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                        letterSpacing: -0.21,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, left: 3),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12,
                        color: Color(0xff767676),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Column(
          children: List.generate(
            items.length > 4 ? 4 : items.length, // 최대 4개까지만 표시
            (i) => Column(
              children: [
                itemBuilder(items[i]),
                if (items.length > 4
                    ? i != 3
                    : i < items.length - 1) // 마지막 항목이 아닐 경우 구분선 추가
                  const Divider(
                    color: Color(0xffd9d9d9),
                    thickness: 1,
                    height: 0,
                  ),
              ],
            ),
          ),
        ),
        const Divider(
          thickness: 5, // 섹션 구분선
          color: Color(0xffF2F3F5),
        ),
      ],
    );
  }

  /// 용어 검색 결과 UI
  Widget _buildDictionaryCard(DictionaryModel term) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showTermDetailDialog(context, term);
            },
            child: SizedBox(
              width: 292,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    term.termName!,
                    style: const TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    term.termDescription!,
                    style: const TextStyle(
                      color: Color(0xFF767676),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 1.40,
                      letterSpacing: -0.35,
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: GestureDetector(
              onTap: () {
                controller.scrapTermToggle(term);
              },
              child: Icon(
                term.isScraped! ? Icons.bookmark : Icons.bookmark_outline,
                color: term.isScraped!
                    ? Palette.buttonColorGreen
                    : const Color(0xffa2a2a2),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 용어 상세보기 다이얼로그
  void showTermDetailDialog(BuildContext context, DictionaryModel term) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),
                    // 용어 제목
                    Text(
                      term.termName ?? "용어 제목",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.45,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // 용어 설명
                    Text(
                      term.termDescription ?? "상세 내용이 없습니다.",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              // 오른쪽 상단 X 버튼 (팝업 닫기)
              Positioned(
                top: 16,
                right: 16,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(); // 팝업 닫기
                  },
                  child: const Icon(
                    Icons.close,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// 경제 기사 UI
  Widget _buildNewsCard(ArticleModel news) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            news.translatedCategory,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 298,
                child: Text(
                  maxLines: 2,
                  news.title!,
                  style: const TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    height: 1.30,
                    letterSpacing: -0.40,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.scrapNewsToggle(news);
                },
                child: Icon(
                  news.isScraped! ? Icons.bookmark : Icons.bookmark_outline,
                  color: news.isScraped!
                      ? Palette.buttonColorGreen
                      : const Color(0xff767676),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                news.publisher!,
                style: const TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.30,
                ),
              ),
              Text(
                news.createdDate!,
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
    );
  }

  /// 일반 게시판 UI
  Widget _buildPostCard(PostModel post) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            '/community/detail',
            arguments: post.id,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 235,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.favorite_outline,
                        size: 20,
                        color: Color(0xff767676),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${post.likeCount!}',
                        textAlign: TextAlign.center,
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
                      const Icon(
                        Icons.chat_bubble_outline,
                        size: 20,
                        color: Color(0xff767676),
                      ),
                      const SizedBox(
                        width: 3,
                      ),
                      Text(
                        '${post.commentCount!}',
                        textAlign: TextAlign.center,
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
                        post.createdDate!,
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
            ),
            post.imageUrl != null
                ? Container(
                    width: 66,
                    height: 66,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD9D9D9),
                      borderRadius: BorderRadius.circular(7),
                      image: DecorationImage(
                        image: NetworkImage(post.imageUrl!),
                      ),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }

  /// 최근 검색어 UI
  Widget _buildRecentSearches() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.keywords.isEmpty) {
            return const Padding(
              padding: EdgeInsets.only(top: 82),
              child: Text(
                '최근 검색한 내용이 없습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                ),
              ),
            );
          }

          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    '최근 검색',
                    style: TextStyle(
                      color: Color(0xFF111111),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: -0.40,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.deleteSearchKeywordAll,
                    child: const Text(
                      '전체삭제',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 1.50,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.keywords.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.search(controller.keywords[index]);
                              controller.searchController.text =
                                  controller.keywords[index];
                              tabController.index =
                                  0; // 🔹 검색 실행 시 "통합" 기본 탭 설정
                            },
                            child: Text(
                              controller.keywords[index],
                              style: const TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 1.50,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => controller.deleteSearchKeyword(
                                controller.keywords[index]),
                            child: const Icon(Icons.close),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
