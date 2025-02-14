import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/learning_set/explanation_text.dart';
import 'package:economic_fe/view_model/mypage/scrap_learning_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrapLearningSetPage extends StatefulWidget {
  const ScrapLearningSetPage({super.key});

  @override
  State<ScrapLearningSetPage> createState() => _ScrapLearningSetPageState();
}

class _ScrapLearningSetPageState extends State<ScrapLearningSetPage> {
  final ScrapLearningSetController controller =
      Get.put(ScrapLearningSetController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: controller.learningSetName.value, // 초기값 제공
        icon: Icons.close,
        onPress: () => Get.back(),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.concept.isEmpty) {
          return const Center(child: Text('개념 학습 데이터를 불러올 수 없습니다.'));
        }

        return Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 65),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10),
                    width:
                        MediaQuery.of(context).size.width * 0.9, // 화면 너비의 90%
                    height:
                        MediaQuery.of(context).size.height * 0.9, // 화면 높이의 90%
                    child: Column(
                      mainAxisSize: MainAxisSize.max, // Column이 부모의 크기를 채우도록 설정
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 10),
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
                          child: Obx(
                            () => Text(
                              controller
                                  .convertLevel(controller.concept['level']),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                                letterSpacing: -0.4,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color:
                                Color.fromARGB(255, 255, 255, 255), // 컨테이너 배경색
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
                                  Text(
                                    controller.concept['name'],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      height: 1.4,
                                      letterSpacing: -0.4,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 11,
                                  ),
                                  Obx(() {
                                    return GestureDetector(
                                      onTap: () =>
                                          controller.toggleScrapStatus(),
                                      child: Image.asset(
                                        controller.isScrapped.value
                                            ? "assets/bookmark_selected.png"
                                            : "assets/bookmark.png",
                                        width: 13,
                                      ),
                                    );
                                  }),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Image.asset(
                                // 예시 이미지
                                "assets/example.png",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width - 72,
                              ),
                              const SizedBox(
                                height: 22,
                              ),
                              ExplanationText(
                                  explanation:
                                      controller.concept['explanation']),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 110,
              right: 10,
              child: ChatbotFAB(
                onTap: () => controller.toChatbot(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white, // 배경 색상을 decoration에 포함
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.1), // rgba(0, 0, 0, 0.10) 변환
                      blurRadius: 15.0, // 그림자의 흐림 정도
                      offset: const Offset(0, -2), // 0px x, -2px y (위로 2px 이동)
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16.0, bottom: 30.0, top: 16.0),
                // color: Colors.white, // 배경 색상
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(328, 56),
                      backgroundColor: Palette.buttonColorBlue,
                      // padding: const EdgeInsets.symmetric(vertical: 15.0), // 버튼 크기
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // 모서리를 30px로 둥글게 설정
                      ),
                    ),
                    child: const Text(
                      "학습 완료",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                        letterSpacing: -0.45,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
