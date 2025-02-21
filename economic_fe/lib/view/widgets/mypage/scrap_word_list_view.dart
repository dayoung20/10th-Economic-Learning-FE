import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/mypage/my_learning_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScrapedWordListView extends StatefulWidget {
  const ScrapedWordListView({super.key});

  @override
  State<ScrapedWordListView> createState() => _ScrapedWordListViewState();
}

class _ScrapedWordListViewState extends State<ScrapedWordListView> {
  final MyLearningController controller = Get.find<MyLearningController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 16.h,
        ),
        // 검색창
        Container(
          width: MediaQuery.of(context).size.width - 32,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          decoration: ShapeDecoration(
            color: const Color(0xFFF2F3F5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(52),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.search,
                color: Color(0xffa2a2a2),
              ),
              SizedBox(
                width: 8.w,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    controller.keyword.value = value;
                    controller.searchScrapedTermsByKeyword();
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.40,
                  ),
                  decoration: InputDecoration(
                    hintText: '검색',
                    hintStyle: TextStyle(
                      color: const Color(0xFFA2A2A2),
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.40,
                      letterSpacing: -0.40,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        // 자음 리스트
        Container(
          padding: EdgeInsets.only(left: 20.w),
          child: SizedBox(
            height: 61 - (12 + 16),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.consonants.length,
              itemBuilder: (context, index) {
                final consonant = controller.consonants[index];
                return GestureDetector(
                  onTap: () {
                    controller.selectedConsonant.value = consonant;
                    controller.typeValue.value = true;
                    controller.searchScrapedTermsByInitial(consonant);
                  },
                  child: Obx(
                    () => Container(
                      margin: EdgeInsets.only(right: 8.w),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: controller.selectedConsonant.value == consonant
                            ? const Color(0xFF1EB692)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: controller.selectedConsonant.value == consonant
                              ? Colors.transparent
                              : const Color(0xFF1EB692),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          consonant,
                          style: TextStyle(
                            color:
                                controller.selectedConsonant.value == consonant
                                    ? Colors.white
                                    : const Color(0xFF767676),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        SizedBox(
          height: 8.h,
        ),
        // 단어 리스트
        Expanded(
          child: Obx(() {
            if (controller.scrapTerms.isEmpty) {
              return const Center(
                child: Text("용어 사전 데이터가 없습니다."),
              );
            }

            return ListView.separated(
              itemCount: controller.scrapTerms.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1.h,
                  color: const Color(0xffd9d9d9),
                );
              },
              itemBuilder: (context, index) {
                final term = controller.scrapTerms[index];
                return GestureDetector(
                  onTap: () {
                    controller.getTermDetail(term.termId ?? 0);
                    // 상세 보기
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10), // 팝업 테두리 둥글게
                          ),
                          child: Stack(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 16.h),
                                child: SingleChildScrollView(
                                  // 스크롤 가능하게 변경
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 14.h),
                                      // 제목
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
                                      // 내용 (스크롤 가능)
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                          maxHeight: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.6, // 최대 높이 제한
                                        ),
                                        child: SingleChildScrollView(
                                          child: Text(
                                            term.termDescription ??
                                                "상세 내용이 없습니다.",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ),
                              ),
                              // 오른쪽 위 X 버튼
                              Positioned(
                                top: 10.h,
                                right: 10.w,
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
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 16.h,
                      horizontal: 16.w,
                    ),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                term.termName ?? "",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                maxLines: 1,
                                _truncateWithEllipsis(
                                    term.termDescription ?? "", 30),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF767676),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 16.w),
                        GestureDetector(
                          onTap: () {
                            controller.deleteScrapedTerms(term.termId!);
                          },
                          child: const Icon(
                            Icons.bookmark,
                            color: Palette.buttonColorGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }

  // 길이 제한 함수
  String _truncateWithEllipsis(String text, int maxLength) {
    return text.length > maxLength
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
