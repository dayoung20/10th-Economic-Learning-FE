import 'package:economic_fe/data/models/article_model.dart';
import 'package:economic_fe/data/models/community/post_model.dart';
import 'package:economic_fe/data/models/community/tok_model.dart';
import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/search/search_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          SizedBox(height: 21.h),
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

  Widget _buildSearchBar() {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        height: 60.h,
        child: TextFormField(
          // onChanged: (value) {
          //   controller.search(value);
          // },
          controller: controller.searchController,
          decoration: InputDecoration(
            hintText: '검색',
            hintStyle: TextStyle(
              color: const Color(0xFFA2A2A2),
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.4,
              letterSpacing: -0.4,
            ),
            fillColor: const Color(0xFFF2F3F5),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(52),
            ),
            prefixIcon: const Icon(
              Icons.search,
              color: Color(0xFFA2A2A2),
            ),
          ),
          onFieldSubmitted: (value) {
            controller.search(value);
            tabController.index = 0;
          },
        ),
      ),
    );
  }

  /// 가로 스크롤 가능한 탭바 (수정)
  Widget _buildTabBar() {
    return SizedBox(
      height: 40.h,
      child: TabBar(
        tabAlignment: TabAlignment.start,
        controller: tabController,
        isScrollable: true,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorColor: Colors.black,
        labelColor: Colors.black,
        labelStyle: TextStyle(
          fontSize: 16.sp,
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
            controller.searchToks,
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
          case 3: // 일반 게시판
            results = controller.searchPosts;
            break;
          default: // 경제 톡톡
            results = controller.searchToks;
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
                      return _buildAll(
                          results[i], results[i], results[i], results[i]);

                    case 1: // 용어사전 (Dictionary)
                      return _buildDictionaryCard(results[i]);

                    case 2: // 경제 기사 (News)
                      return _buildNewsCard(results[i]);

                    case 3: // 일반 게시글
                      return _buildPostCard(results[i]);

                    default: // 경제 톡톡
                      return _buildTokCard(results[i]);
                  }
                },
              );
      }),
    );
  }

  /// 통합 검색 결과 (카테고리별 표시)
  Widget _buildAll(List<DictionaryModel> terms, List<ArticleModel> news,
      List<PostModel> posts, List<TokModel> toks) {
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
          if (toks.isNotEmpty)
            _buildCategorySection("경제 톡톡", toks, _buildTokCard, 4),
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
          padding: EdgeInsets.only(top: 24.h, left: 16.w, right: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: const Color(0xFF111111),
                  fontSize: 18.sp,
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
                child: Row(
                  children: [
                    Text(
                      '더보기',
                      style: TextStyle(
                        color: const Color(0xFF767676),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        height: 1.20,
                        letterSpacing: -0.21,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3.h, left: 3.w),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 12.w,
                        color: const Color(0xff767676),
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
        Divider(
          thickness: 5.h, // 섹션 구분선
          color: const Color(0xffF2F3F5),
        ),
      ],
    );
  }

  /// 용어 검색 결과 UI
  Widget _buildDictionaryCard(DictionaryModel term) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              showTermDetailDialog(context, term);
            },
            child: SizedBox(
              width: 292.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    term.termName!,
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Text(
                    term.termDescription!,
                    style: TextStyle(
                      color: const Color(0xFF767676),
                      fontSize: 14.sp,
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
            padding: EdgeInsets.only(top: 8.h),
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
                    SizedBox(height: 14.h),
                    // 용어 제목
                    Text(
                      term.termName ?? "용어 제목",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.45,
                        height: 1.2,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    // 용어 설명
                    Text(
                      term.termDescription ?? "상세 내용이 없습니다.",
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
              // 오른쪽 상단 X 버튼 (팝업 닫기)
              Positioned(
                top: 16.h,
                right: 16.w,
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
            style: TextStyle(
              color: const Color(0xFF2AD6D6),
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
              height: 1.30,
              letterSpacing: -0.30,
            ),
          ),
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 298.w,
                child: Text(
                  maxLines: 2,
                  news.title!,
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
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
          SizedBox(
            height: 6.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                news.publisher!,
                style: TextStyle(
                  color: const Color(0xFF767676),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.50,
                  letterSpacing: -0.30,
                ),
              ),
              Text(
                news.createdDate!,
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
              width: 235.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    post.title!,
                    style: TextStyle(
                      color: const Color(0xFF111111),
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
                      color: const Color(0xFF111111),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.50,
                      letterSpacing: -0.35,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    height: 8.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.favorite_outline,
                        size: 20.w,
                        color: const Color(0xff767676),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        '${post.likeCount!}',
                        textAlign: TextAlign.center,
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
                      Icon(
                        Icons.chat_bubble_outline,
                        size: 20.w,
                        color: const Color(0xff767676),
                      ),
                      SizedBox(
                        width: 3.w,
                      ),
                      Text(
                        '${post.commentCount!}',
                        textAlign: TextAlign.center,
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
                        post.createdDate!,
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
            ),
            post.imageUrl != null
                ? Container(
                    width: 66.w,
                    height: 66.h,
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

  /// 경제 톡톡 UI
  Widget _buildTokCard(TokModel tok) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(
            '/community/talk_detail',
            arguments: tok.id,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // 경제톡톡 이미지
            Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: // 이미지가 있는 경우에만 표시
                  tok.imageUrl != null && tok.imageUrl!.isNotEmpty
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.network(
                            tok.imageUrl!,
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
                        )
                      : Container(
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
                        '${tok.participantCount}명이 참여했어요',
                        style: TextStyle(
                          color: const Color(0xFF767676),
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          height: 1.50,
                          letterSpacing: -0.33,
                        ),
                      ),
                      Text(
                        tok.createdDate!,
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
                  width: MediaQuery.of(context).size.width - 141.w,
                  height: 60.h,
                  child: Flexible(
                    child: Text(
                      tok.title!,
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
                      '${tok.likeCount}',
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
                      '${tok.participantCount}',
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
  }

  /// 최근 검색어 UI
  Widget _buildRecentSearches() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26.h),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          if (controller.keywords.isEmpty) {
            return Padding(
              padding: EdgeInsets.only(top: 82.h),
              child: Text(
                '최근 검색한 내용이 없습니다.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: const Color(0xFF767676),
                  fontSize: 18.sp,
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
                  Text(
                    '최근 검색',
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      height: 1.50,
                      letterSpacing: -0.40,
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.deleteSearchKeywordAll,
                    child: Text(
                      '전체삭제',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.sp,
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
                      padding: EdgeInsets.only(top: 16.h),
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
                              style: TextStyle(
                                color: const Color(0xFF404040),
                                fontSize: 16.sp,
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
