import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:economic_fe/view_model/agreement_controller.dart';
import 'package:economic_fe/view_model/dictionary_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  // bool _selectedWord = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = Get.put(DictionaryController()..getStats());
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
          rightIcon: true,
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
                            });
                          },
                          child: Container(
                            height: 30,
                            width: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                        const SizedBox(width: 8),
                      ],
                    );
                  }),
                ),
              ),
            ),
            // 단어와 설명을 보여주는 리스트
            Expanded(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(16),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(10),
                          // border: Border.all(color: const Color(0xFFCFCFCF)),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.1),
                          //     blurRadius: 5,
                          //     offset: const Offset(0, 2),
                          //   ),
                          // ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 300,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    items[index]['word']!, // 단어 표시
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        height: 1.4,
                                        letterSpacing: -0.4),
                                  ),
                                  const SizedBox(height: 8), // 단어와 설명 간 간격
                                  Text(
                                    items[index]['description'] ?? "설명이 없습니다",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF767676),
                                      fontWeight: FontWeight.w400,
                                      height: 1.4,
                                      letterSpacing: -0.35,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // 'selectedWord'가 null인 경우에는 false로 초기화하고, 값을 반전시킴
                                    items[index]['selectedWord'] =
                                        !(items[index]['selectedWord'] ??
                                            false);
                                    print("Dd");
                                  });
                                },
                                child: Image.asset(
                                  items[index]['selectedWord'] ?? false
                                      ? "assets/bookmark_selected.png"
                                      : "assets/bookmark.png",
                                  height: 20,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      if (index !=
                          items.length - 1) // 마지막 항목에는 Divider를 추가하지 않음
                        const Divider(
                          color: Color(0xFFEBEBEB), // 디바이더 색상
                          height: 1, // 높이 설정
                          thickness: 1, // 두께 설정
                        ),
                    ],
                  );
                },
              ),
            ),
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
}
