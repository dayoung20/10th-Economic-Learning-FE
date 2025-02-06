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

class _SearchPageState extends State<SearchPage> {
  final SearchPageController controller = Get.put(SearchPageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '검색',
        icon: Icons.close,
        onPress: () {
          Get.back();
        },
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width - 32,
              height: 42,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: ShapeDecoration(
                color: const Color(0xFFF2F3F5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(52),
                ),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.search,
                    color: Color(0xffa2a2a2),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextField(
                      cursorColor: Color(0xff111111),
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 1.40,
                        letterSpacing: -0.40,
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '검색어를 입력해주세요.',
                        hintStyle: TextStyle(
                          color: Color(0xFFA2A2A2),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 21,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
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
                          onTap: () {
                            controller.deleteSearchKeywordAll();
                          },
                          child: const Text(
                            '전체삭제',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                              fontFamily: 'Pretendard Variable',
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  controller.keywords[index],
                                  style: const TextStyle(
                                    color: Color(0xFF404040),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.50,
                                    letterSpacing: -0.40,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.deleteSearchKeyword(
                                        controller.keywords[index]);
                                  },
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
          ),
        ],
      ),
    );
  }
}
