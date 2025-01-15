import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/learning_set/learning_concept_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LearningConceptPage extends StatefulWidget {
  const LearningConceptPage({super.key});

  @override
  State<LearningConceptPage> createState() => _LearningConceptPageState();
}

class _LearningConceptPageState extends State<LearningConceptPage> {
  bool isSelected = false;
  String selectedLevel = "초급";
  List<String> level = ["초급", "중급", "고급"];
  @override
  void initState() {
    super.initState();
    isSelected = false;
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<LearningConceptController>();
    final LearningConceptController controller =
        Get.put(LearningConceptController());
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const CustomAppBar(
        title: "금융 기초",
        icon: Icons.close,
        currentIndex: 1,
        totalIndex: 3,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.only(top: 18),
            width: MediaQuery.of(context).size.width * 0.9, // 화면 너비의 90%
            height: MediaQuery.of(context).size.height * 0.8, // 화면 높이의 80%
            // decoration: const BoxDecoration(
            //   color: Color.fromARGB(255, 0, 0, 0),
            //   borderRadius: BorderRadius.all(
            //     Radius.circular(10.0), // 여기에서 Radius.circular를 사용
            //   ),
            //   border: Border.fromBorderSide(
            //     BorderSide(
            //       color: Colors.black, // 테두리 색상
            //       width: 2.0, // 테두리 두께
            //     ),
            //   ),
            // ),
            child: Column(
              mainAxisSize: MainAxisSize.max, // Column이 부모의 크기를 채우도록 설정
              children: [
                Flexible(
                  flex: 3, // 비율로 상단 영역 지정
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xFF1EB692), // 컨테이너 배경색
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0), // 왼쪽 위 둥글게
                        topRight: Radius.circular(10.0), // 오른쪽 위 둥글게
                        // 아래쪽은 둥글게 하지 않음
                      ),
                      // border: Border
                    ),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedIndex.value == -1
                                ? "초급"
                                : controller
                                    .level[controller.selectedIndex.value],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              height: 1.4,
                              letterSpacing: -0.4,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.white,
                              builder: (BuildContext context) {
                                List<String> level = [
                                  "초급",
                                  "중급",
                                  "고급",
                                ];
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 16),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                "카테고리",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                              itemCount:
                                                  controller.level.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return ListTile(
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  title: Text(
                                                    controller.level[index],
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: controller
                                                                  .selectedIndex ==
                                                              index
                                                          ? const Color(
                                                              0xFF2BD6D6)
                                                          : Colors.black,
                                                      fontWeight: controller
                                                                  .selectedIndex ==
                                                              index
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                    ),
                                                  ),
                                                  trailing: controller
                                                              .selectedIndex ==
                                                          index
                                                      ? Image.asset(
                                                          'assets/check_fill.png', // 이미지 경로
                                                          width: 24,
                                                          height: 24,
                                                        )
                                                      : null,
                                                  onTap: () {
                                                    print("ddddd");
                                                    setState(() {
                                                      controller.selectedIndex
                                                              .value =
                                                          index; // 선택된 항목 업데이트
                                                    });
                                                    print(controller
                                                        .selectedIndex.value);
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
                          },
                          child: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  flex: 25, // 비율로 하단 영역 지정
                  child: Container(
                    // color: Colors.white,
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255), // 컨테이너 배경색
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10.0), // 왼쪽 위 둥글게
                        bottomRight: Radius.circular(10.0), // 오른쪽 위 둥글게
                        // 아래쪽은 둥글게 하지 않음
                      ),
                      border: Border(
                        top: BorderSide.none, // 윗변 테두리 없음
                        left: BorderSide(
                          color: Color(0xFFA2A2A2), // 테두리 두께
                          width: 1.0,
                        ),
                        right: BorderSide(
                          color: Color(0xFFA2A2A2), // 오른쪽 테두리 색상
                          width: 1.0, // 테두리 두께
                        ),
                        bottom: BorderSide(
                          color: Color(0xFFA2A2A2), // 아랫변 테두리 색상
                          width: 1.0, // 테두리 두께
                        ),
                      ),
                    ),
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 24),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Text(
                              "저축과 이자",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                                letterSpacing: -0.4,
                              ),
                            ),
                            const SizedBox(
                              width: 11,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  isSelected = !isSelected;
                                });
                              },
                              child: Image.asset(
                                isSelected
                                    ? "assets/bookmark_selected.png"
                                    : "assets/bookmark.png",
                                // height: 24,
                                width: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Image.asset(
                          // 예시 이미지
                          "assets/example.png",
                          width: 300,
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        // Text("저축")
                        const Text(
                          "저축은 소비하지 않은 돈을 금융기관에 예치해 자산을 증대하는 방법이에요. 은행은 이 자금을 활용해 대출을 제공하며, 이 과정에서 경제 전반의 자금 흐름을 지원해요. 이자는 저축한 돈을 금융기관이 사용하는 대가로 지급하는 금액이고, 대출자는 대출 금액에 대해 금융기관에 이자를 지불해요.",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // 배경 색상을 decoration에 포함
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // rgba(0, 0, 0, 0.10) 변환
              blurRadius: 15.0, // 그림자의 흐림 정도
              offset: const Offset(0, -2), // 0px x, -2px y (위로 2px 이동)
            ),
          ],
        ),

        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 10.0, top: 16.0),
        // color: Colors.white, // 배경 색상
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 동작
                print("버튼 클릭!");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(170, 53),
                backgroundColor: const Color(0xFF1EB692), // 버튼 색상
                foregroundColor:
                    const Color.fromARGB(255, 255, 255, 255), // 텍스트 색상
                // padding: const EdgeInsets.symmetric(vertical: 15.0), // 버튼 크기
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리를 30px로 둥글게 설정
                ),
              ),
              child: const Text(
                "이전",
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: -0.45,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
              onPressed: () {
                print("버튼 클릭!");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF2F3F5), // 버튼 색상
                foregroundColor:
                    const Color.fromARGB(255, 255, 255, 255), // 텍스트 색상
                padding: const EdgeInsets.only(top: 16.0, bottom: 12), // 버튼 크기
                minimumSize: const Size(170, 53),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // 모서리를 30px로 둥글게 설정
                ),
              ),
              child: const Text(
                "다음",
                style: TextStyle(
                  color: Color(0xFFA2A2A2),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: -0.45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
