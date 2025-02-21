import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/mypage/bookmarked_articles_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class BookmarkedArticlesPage extends StatefulWidget {
  const BookmarkedArticlesPage({super.key});

  @override
  State<BookmarkedArticlesPage> createState() => _BookmarkedArticlesPageState();
}

class _BookmarkedArticlesPageState extends State<BookmarkedArticlesPage> {
  final BookmarkedArticlesController controller =
      Get.put(BookmarkedArticlesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '스크랩 한 기사',
        icon: Icons.close,
        onPress: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.scrapNews.isEmpty) {
          return const Center(
            child: Text("뉴스 데이터가 없습니다."),
          );
        }

        return ListView.builder(
          itemCount: controller.scrapNews.length,
          itemBuilder: (context, index) {
            final news = controller.scrapNews[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      news.translatedCategory,
                      style: TextStyle(
                        color: const Color(0xFF2BD6D6),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.3,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            controller.toDetailPage(news);
                          },
                          child: SizedBox(
                            width: 290.w,
                            child: Text(
                              news.title ?? "제목 없음",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                height: 1.3,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.deleteScrapedNews(news.id!);
                          },
                          child: const Icon(
                            Icons.bookmark,
                            color: Palette.buttonColorGreen,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          news.publisher ?? "알 수 없음",
                          style: TextStyle(
                            color: const Color(0xFF767676),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            letterSpacing: -0.3,
                          ),
                        ),
                        // 기사 업로드 시간
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
              ),
            );
          },
        );
      }),
    );
  }
}
