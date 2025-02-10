import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/mypage/my_learning_controller.dart';
import 'package:flutter/material.dart';
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
        const SizedBox(
          height: 16,
        ),
        // 검색창
        Container(
          width: MediaQuery.of(context).size.width - 32,
          padding: const EdgeInsets.symmetric(horizontal: 16),
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
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: TextField(
                  onChanged: (value) {
                    controller.keyword.value = value;
                    controller.searchScrapedTermsByKeyword();
                  },
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.40,
                  ),
                  decoration: const InputDecoration(
                    hintText: '검색',
                    hintStyle: TextStyle(
                      color: Color(0xFFA2A2A2),
                      fontSize: 16,
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
        const SizedBox(
          height: 12,
        ),
        // 자음 리스트
        Container(
          padding: const EdgeInsets.only(left: 20),
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
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
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
                            fontSize: 16,
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
        const SizedBox(
          height: 8,
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
                return const Divider(
                  height: 1,
                  color: Color(0xffd9d9d9),
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
                                padding: const EdgeInsets.all(16.0),
                                child: SingleChildScrollView(
                                  // 스크롤 가능하게 변경
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 14),
                                      // 제목
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
                                            style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black87,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                              // 오른쪽 위 X 버튼
                              Positioned(
                                top: 10,
                                right: 10,
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
                    margin: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 16,
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
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                maxLines: 1,
                                _truncateWithEllipsis(
                                    term.termDescription ?? "", 30),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF767676),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () {},
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
