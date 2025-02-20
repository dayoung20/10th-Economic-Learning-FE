import 'package:economic_fe/data/models/dictionary_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view_model/dictionary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  late final DictionaryController controller;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final List<String> consonants = [
    'ㄱ',
    'ㄴ',
    'ㄷ',
    'ㄹ',
    'ㅁ',
    'ㅂ',
    'ㅅ',
    'ㅇ',
    'ㅈ',
    'ㅊ',
    'ㅋ',
    'ㅌ',
    'ㅍ',
    'ㅎ'
  ];
  final List<Map<String, dynamic>> items = [
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
    {
      'word': '인플레이션',
      'description': '이곳에는 단어에 대한 설명이 들어갑니다. 이곳에는...',
      'selectedWord': false
    },
  ];
  int _selectedIndex = -1;
  @override
  void initState() {
    super.initState();
    controller = Get.put(DictionaryController()..getStats());
    controller.getDictionaryList(0, 'ㄱ', true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _focusNode.unfocus();
      },
      child: Scaffold(
        backgroundColor: Palette.background,
        appBar: CustomAppBar(
          title: "용어사전",
          onTapTitle: () {
            showCategoryModal(context);
          },
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              height: 60,
              child: TextFormField(
                onChanged: (value) {
                  // 텍스트가 변경될 때마다 controller.keyword를 업데이트
                  controller.keyword.value = value;
                  print(controller.keyword.value);
                },
                controller: _controller,
                focusNode: _focusNode,
                decoration: InputDecoration(
                  hintText: '검색',
                  hintStyle: const TextStyle(
                    color: Color(0xFFA2A2A2),
                    fontSize: 16,
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
                  // print("검색 실행: $value");
                  controller.typeValue.value = false;
                  controller.getKewordResult(0, value);
                },
              ),
            ),
            // 자음 리스트 (가로 스크롤)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 50, // 높이 설정
                child: ListView(
                  scrollDirection: Axis.horizontal, // 가로 스크롤
                  children: List.generate(consonants.length, (index) {
                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedIndex = index; // 클릭된 항목의 인덱스를 업데이트
                              controller.selectedConsonant.value =
                                  consonants[index];
                              print(controller.selectedConsonant.value);
                              controller.typeValue.value = true;
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 45,
                            decoration: BoxDecoration(
                              color: _selectedIndex == index
                                  ? const Color(0xFF1EB692) // 선택된 항목은 초록색
                                  : Colors.white, // 나머지 항목은 흰색
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: _selectedIndex == index
                                    ? Colors.transparent // 선택된 항목은 테두리 없애기
                                    : const Color(0xFF1EB692), // 나머지 항목은 회색 테두리
                              ),
                            ),
                            child: Center(
                              child: Text(
                                consonants[index], // 자음 리스트에서 해당 항목을 표시
                                style: _selectedIndex == index
                                    ? const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      )
                                    : const TextStyle(
                                        color: Color(0xFF767676),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                    );
                  }),
                ),
              ),
            ),

            controller.typeValue.value
                ? Obx(() {
                    return FutureBuilder<List<DictionaryModel>>(
                      future: controller.getDictionaryList(
                          0,
                          controller.typeValue.value
                              ? controller.selectedConsonant.value
                              : controller.keyword.value,
                          controller.typeValue.value),
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
                            child: Text("에러 발생 : ${snapshot.error}"),
                          );
                        }

                        // 데이터가 없을 때
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("용어 사전 데이터가 없습니다."),
                          );
                        }
                        final termList = snapshot.data!;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: termList.length,
                            itemBuilder: (context, index) {
                              final terms = termList[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // termId가 없을 경우 2로 대체
                                      controller
                                          .getTermDetail(terms.termId ?? 2);

                                      // 상세 보기
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // 팝업 테두리 둥글게
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      // 제목
                                                      Text(
                                                        terms.termName ??
                                                            "용어 제목",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: -0.45,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      // 내용
                                                      Text(
                                                        terms.termDescription ??
                                                            "상세 내용이 없습니다.",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                    ],
                                                  ),
                                                ),
                                                // 오른쪽 위 X 버튼
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop(); // 팝업 닫기
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
                                          vertical: 8),
                                      padding: const EdgeInsets.all(16),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // items[index]['word']!, // 단어 표시
                                                  // terms.termName ?? "",
                                                  truncateWithEllipsis(
                                                      terms.termName ?? "", 20),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      height: 1.4,
                                                      letterSpacing: -0.4),
                                                ),
                                                const SizedBox(
                                                    height: 8), // 단어와 설명 간 간격
                                                SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                    // items[index]['description'] ??
                                                    //     "설명이 없습니다",
                                                    // terms.termDescription ?? "",
                                                    truncateWithEllipsis(
                                                        terms.termDescription ??
                                                            "",
                                                        25),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF767676),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.4,
                                                      letterSpacing: -0.35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                if (terms.isScraped!) {
                                                  controller.deleteTermScrap(
                                                      terms.termId!);
                                                } else {
                                                  controller.postTermScrap(
                                                      terms.termId!);
                                                }
                                                print("Dd");
                                                print(terms.isScraped);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 11, top: 8, bottom: 8),
                                              child: Image.asset(
                                                terms.isScraped ?? false
                                                    ? "assets/bookmark_selected.png"
                                                    : "assets/bookmark.png",
                                                width: 13,
                                                height: 18.2,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (index !=
                                      items.length -
                                          1) // 마지막 항목에는 Divider를 추가하지 않음
                                    const Divider(
                                      color: Color(0xFFEBEBEB), // 디바이더 색상
                                      height: 1, // 높이 설정
                                      thickness: 1, // 두께 설정
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  })
                : Obx(() {
                    return FutureBuilder<List<DictionaryModel>>(
                      future: controller.getDictionaryList(
                          0,
                          controller.typeValue.value
                              ? controller.selectedConsonant.value
                              : controller.keyword.value,
                          controller.typeValue.value),
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
                            child: Text("에러 발생 : ${snapshot.error}"),
                          );
                        }

                        // 데이터가 없을 때
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return const Center(
                            child: Text("용어 사전 데이터가 없습니다."),
                          );
                        }
                        final termList = snapshot.data!;

                        return Expanded(
                          child: ListView.builder(
                            itemCount: termList.length,
                            itemBuilder: (context, index) {
                              final terms = termList[index];
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // termId가 없을 경우 2로 대체
                                      controller
                                          .getTermDetail(terms.termId ?? 2);

                                      // 상세 보기
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Dialog(
                                            backgroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      10), // 팝업 테두리 둥글게
                                            ),
                                            child: Stack(
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      16.0),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      const SizedBox(
                                                        height: 14,
                                                      ),
                                                      // 제목
                                                      Text(
                                                        terms.termName ??
                                                            "용어 제목",
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          letterSpacing: -0.45,
                                                          height: 1.2,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 12),
                                                      // 내용
                                                      Text(
                                                        terms.termDescription ??
                                                            "상세 내용이 없습니다.",
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                          color: Colors.black87,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 16),
                                                      // 하단 버튼
                                                      // Row(
                                                      //   mainAxisAlignment:
                                                      //       MainAxisAlignment.end,
                                                      //   children: [
                                                      //     TextButton(
                                                      //       onPressed: () {
                                                      //         Navigator.of(context)
                                                      //             .pop(); // 팝업 닫기
                                                      //       },
                                                      //       child: const Text("닫기"),
                                                      //     ),
                                                      //     TextButton(
                                                      //       onPressed: () {
                                                      //         // 추가 동작 수행
                                                      //         print('추가 동작 수행');
                                                      //         Navigator.of(context)
                                                      //             .pop(); // 팝업 닫기
                                                      //       },
                                                      //       child: const Text("확인"),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                    ],
                                                  ),
                                                ),
                                                // 오른쪽쪽 위 X 버튼
                                                Positioned(
                                                  top: 8,
                                                  right: 8,
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.of(context)
                                                          .pop(); // 팝업 닫기
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
                                          vertical: 8),
                                      padding: const EdgeInsets.all(16),
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  // items[index]['word']!, // 단어 표시
                                                  // terms.termName ?? "",
                                                  truncateWithEllipsis(
                                                      terms.termName ?? "", 20),
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 0, 0, 0),
                                                      height: 1.4,
                                                      letterSpacing: -0.4),
                                                ),
                                                const SizedBox(
                                                    height: 8), // 단어와 설명 간 간격
                                                SizedBox(
                                                  width: 300,
                                                  child: Text(
                                                    // items[index]['description'] ??
                                                    //     "설명이 없습니다",
                                                    // terms.termDescription ?? "",
                                                    truncateWithEllipsis(
                                                        terms.termDescription ??
                                                            "",
                                                        25),
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Color(0xFF767676),
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.4,
                                                      letterSpacing: -0.35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // GestureDetector(
                                          //   onTap: () {
                                          //     setState(() {
                                          //       // 'selectedWord'가 null인 경우에는 false로 초기화하고, 값을 반전시킴
                                          //       items[index]['selectedWord'] =
                                          //           !(items[index]['selectedWord'] ??
                                          //               false);
                                          //       // print("Dd");
                                          //     });
                                          //   },
                                          //   child: Padding(
                                          //     padding: const EdgeInsets.only(
                                          //         left: 11, top: 8, bottom: 8),
                                          //     child: Image.asset(
                                          //       items[index]['selectedWord'] ?? false
                                          //           ? "assets/bookmark_selected.png"
                                          //           : "assets/bookmark.png",
                                          //       width: 13,
                                          //       height: 18.2,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                  if (index !=
                                      items.length -
                                          1) // 마지막 항목에는 Divider를 추가하지 않음
                                    const Divider(
                                      color: Color(0xFFEBEBEB), // 디바이더 색상
                                      height: 1, // 높이 설정
                                      thickness: 1, // 두께 설정
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                      },
                    );
                  })
          ],
        ),
        bottomNavigationBar: const CustomBottomBar(currentIndex: 1),
      ),
    );
  }

  void showCategoryModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        List<String> categories = [
          "전체",
          "경기 분석",
          "경제 일반",
          "금융",
          "국제경제",
          "부동산",
          "산업 경제",
          "정부와 경제 정책",
          "투자",
          "기타",
        ];

        int selectedIndex = 0;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.8,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "카테고리",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.close),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: categories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            categories[index],
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedIndex == index
                                  ? const Color(0xFF2BD6D6)
                                  : Colors.black,
                              fontWeight: selectedIndex == index
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                          trailing: selectedIndex == index
                              ? Image.asset(
                                  'assets/check_fill.png', // 이미지 경로
                                  width: 24,
                                  height: 24,
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              selectedIndex = index; // 선택된 항목 업데이트
                            });
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // 길이 제한 함수
  String truncateWithEllipsis(String text, int maxLength) {
    return (text.length > maxLength)
        ? '${text.substring(0, maxLength)}...'
        : text;
  }
}
