import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/custom_bottom_bar.dart';
import 'package:flutter/material.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
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
              // width: 328,
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
                  // labelText: '검색',
                  fillColor: Colors.grey[300],
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
                    // borderSide: const BorderSide(color: Colors.black),
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),
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
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(16),
        ),
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
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                                  width: 24, // 이미지 크기
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
