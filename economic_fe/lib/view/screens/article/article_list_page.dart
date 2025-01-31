import 'package:economic_fe/data/models/article_model.dart';
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
                        controller.selectCategory("전체");
                        controller.getNewsList(1, "RECENT", null);
                      },
                      child: CategoryTab(
                        isSelected: controller.selectedCate.value == "전체",
                        text: '전체',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("FINANCE");
                        controller.getNewsList(1, "RECENT", "FINANCE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCate.value == "FINANCE",
                          text: 'FINANCE'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("INVESTMENT");
                        controller.getNewsList(1, "RECENT", "INVESTMENT");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCate.value == "INVESTMENT",
                          text: 'INVESTMENT'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("NORMAL");
                        controller.getNewsList(1, "RECENT", "NORMAL");
                      },
                      child: CategoryTab(
                          isSelected: controller.selectedCate.value == "NORMAL",
                          text: 'NORMAL'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("GLOBAL");
                        controller.getNewsList(1, "RECENT", "GLOBAL");
                      },
                      child: CategoryTab(
                          isSelected: controller.selectedCate.value == "GLOBAL",
                          text: 'GLOBAL'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("INDUSTRY");
                        controller.getNewsList(1, "RECENT", "INDUSTRY");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCate.value == "INDUSTRY",
                          text: 'INDUSTRY'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("REAL_ESTATE");
                        controller.getNewsList(1, "RECENT", "REAL_ESTATE");
                      },
                      child: CategoryTab(
                          isSelected:
                              controller.selectedCate.value == "REAL_ESTATE",
                          text: 'REAL_ESTATE'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("ECONOMIC_ANALYSIS");
                        controller.getNewsList(
                            1, "RECENT", "ECONOMIC_ANALYSIS");
                      },
                      child: CategoryTab(
                          isSelected: controller.selectedCate.value ==
                              "ECONOMIC_ANALYSIS",
                          text: 'ECONOMIC_ANALYSIS'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("ECONOMIC_POLICY");
                        controller.getNewsList(1, "RECENT", "ECONOMIC_POLICY");
                      },
                      child: CategoryTab(
                          isSelected: controller.selectedCate.value ==
                              "ECONOMIC_POLICY",
                          text: 'ECONOMIC_POLICY'),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.selectCategory("OTHER");
                        controller.getNewsList(1, "RECENT", "OTHER");
                      },
                      child: CategoryTab(
                          isSelected: controller.selectedCate.value == "OTHER",
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
                                controller.getNewsList(1, "POPULAR",
                                    controller.selectedCate.value);
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
                                controller.getNewsList(
                                    1, "RECENT", controller.selectedCate.value);
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
                      Obx(
                        () {
                          return FutureBuilder<List<ArticleModel>>(
                            future: controller.getNewsList(
                                1,
                                controller.selectedSort.value,
                                controller.selectedCate.value),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              }
                              // 에러인 경우
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text("에러 발생 ${snapshot.error}"),
                                );
                              }
                              // 데이터가 없을때
                              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                return const Center(
                                    child: Text('뉴스 데이터가 없습니다.'));
                              }
                              final newsList = snapshot.data!;

                              return Expanded(
                                child: ListView.builder(
                                  itemCount: newsList.length,
                                  itemBuilder: (context, index) {
                                    final news = newsList[index];
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${news.category}",
                                                  style: const TextStyle(
                                                    color: Color(0xFF2BD6D6),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    letterSpacing: -0.3,
                                                    height: 1.3,
                                                  ),
                                                ),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     controller
                                                //         .toDetailPage(news);
                                                //   },
                                                //   child: Text(
                                                //     news.title ?? "제목 없음",
                                                //     style: const TextStyle(
                                                //       fontSize: 16,
                                                //       fontWeight:
                                                //           FontWeight.w500,
                                                //       height: 1.3,
                                                //       letterSpacing: -0.4,
                                                //     ),
                                                //   ),
                                                // ),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller
                                                        .toDetailPage(news);
                                                  },
                                                  child: Text(
                                                    (news.title != null &&
                                                            news.title!.length >
                                                                30)
                                                        ? '${news.title!.substring(0, 20)}...' // 20자까지만 표시하고 "..." 추가
                                                        : news.title ?? "제목 없음",
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      height: 1.3,
                                                      letterSpacing: -0.4,
                                                    ),
                                                  ),
                                                ),

                                                const SizedBox(height: 6),
                                                Text(
                                                  news.publisher ?? "알 수 없음",
                                                  style: const TextStyle(
                                                    color: Color(0xFF767676),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.5,
                                                    letterSpacing: -0.3,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            GestureDetector(
                                              onTap: () {},
                                              child: Image.asset(
                                                news.isScraped ?? false
                                                    ? 'assets/bookmark_selected.png'
                                                    : 'assets/bookmark.png',
                                                width: 13,
                                                height: 18.3,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
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
