import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/category_tab.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view/widgets/order_tab.dart';
import 'package:economic_fe/view_model/article/article_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ArticleListPage extends StatefulWidget {
  const ArticleListPage({super.key});

  @override
  State<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleListPage> {
  final ArticleListController controller = Get.put(ArticleListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getNewsList(1, "RECENT", null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Palette.background,
        centerTitle: true,
        title: const Text(
          '경제 기사',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.30,
            letterSpacing: -0.50,
          ),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 53,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Obx(() {
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(0);
                        controller.getNewsList(1, "RECENT", null);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCategoryIndex.value == 0,
                        text: '전체',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(1);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 1,
                          text: 'FINANCE'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(2);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 2,
                          text: 'INVESTMENT'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(3);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 3,
                          text: 'NORMAL'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(4);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 4,
                          text: 'GLOBAL'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(5);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 5,
                          text: 'INDUSTRY'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(6);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 6,
                          text: 'REAL_ESTATE'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(7);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 7,
                          text: 'ECONOMIC_ANALYSIS'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(8);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 8,
                          text: 'ECONOMIC_POLICY'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory(9);
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCategoryIndex.value == 9,
                          text: 'OTHER'),
                    ),
                  ],
                );
              }),
            ),
          ),
          const SizedBox(
            height: 11,
          ),
          Obx(() {
            switch (controller.selectedCategoryIndex.value) {
              case 0: // 전체 카테고리 내용
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            // 인기순/최신순 선택
                            GestureDetector(
                              onTap: () {
                                controller.selectOrder(0);
                              },
                              child: OrderTab(
                                text: '인기순',
                                isSelected: controller.selectedOrder.value == 0,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.selectOrder(1);
                              },
                              child: OrderTab(
                                text: '최신순',
                                isSelected: controller.selectedOrder.value == 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 기사 목록
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.articles.length, // 예시 데이터 갯수
                          itemBuilder: (context, index) {
                            final article = controller.articles[index];
                            // 인기순과 최신순을 구분해서 데이터를 다르게 처리
                            if (controller.selectedOrder.value == 0) {
                              // 인기순
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // 카테고리 이름
                                    Text(
                                      article.category,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // 기사 헤드라인
                                        GestureDetector(
                                          onTap: () {
                                            controller.toDetailPage(article);
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                80,
                                            child: Text(
                                              article.headline,
                                              style: const TextStyle(
                                                color: Color(0xFF111111),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                                height: 1.30,
                                                letterSpacing: -0.40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () => controller
                                              .toggleBookmark(article.id),
                                          child: Obx(() {
                                            return Image.asset(
                                              article.isBookmarked.value
                                                  ? 'assets/bookmark_selected.png' // 북마크 활성 상태
                                                  : 'assets/bookmark.png', // 북마크 비활성 상태
                                              width: 13,
                                              height: 18.38,
                                            );
                                          }),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 6,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // 신문사
                                        Text(
                                          article.publisher,
                                          style: const TextStyle(
                                            color: Color(0xFF767676),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.50,
                                            letterSpacing: -0.30,
                                          ),
                                        ),
                                        // 기사 업로드 시간
                                        Text(
                                          article.uploadTime,
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
                            } else {
                              // 최신순
                              return const SizedBox();
                            }
                          },
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Container(
                                height: 1,
                                color: const Color(0xffd9d9d9),
                              ),
                            ); // 항목 사이에 구분선 추가
                          },
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return const Center(child: Text('카테고리 내용'));
            }
          }),
        ],
      ),
      floatingActionButton: ChatbotFAB(onTap: () {
        controller.toChatbot();
      }),
      bottomNavigationBar: const CustomBottomBar(currentIndex: 2),
    );
  }
}
