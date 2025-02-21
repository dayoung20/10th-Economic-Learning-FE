import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/learning_set/explanation_text.dart';
import 'package:economic_fe/view_model/mypage/scrap_learning_set_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ScrapLearningSetPage extends StatefulWidget {
  const ScrapLearningSetPage({super.key});

  @override
  State<ScrapLearningSetPage> createState() => _ScrapLearningSetPageState();
}

class _ScrapLearningSetPageState extends State<ScrapLearningSetPage> {
  final ScrapLearningSetController controller =
      Get.put(ScrapLearningSetController());

  late final bool isMultiLearningMode;
  late int currentIndex;
  late final int totalIndex;
  late final List<dynamic>? learningSets;
  late int learningSetId;
  late final String learningSetName;

  @override
  void initState() {
    super.initState();

    isMultiLearningMode = Get.arguments?['isMultiLearningMode'] ?? false;
    currentIndex = Get.arguments?['currentIndex'] ?? 1;
    totalIndex = Get.arguments?['totalIndex'] ?? 1;
    learningSets = Get.arguments?['learningSets'];
    learningSetId = Get.arguments?['learningSetId'];
    learningSetName = Get.arguments?['learningSetName'];

    controller.fetchSingleConcept(learningSetId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: learningSetName,
        icon: Icons.close,
        onPress: () => Get.offNamed('/mypage/learning'),
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
              padding: EdgeInsets.only(bottom: 65.h),
              child: SingleChildScrollView(
                child: Center(
                  child: Container(
                    padding: EdgeInsets.only(top: 10.h),
                    width: MediaQuery.of(context).size.width * 0.8.w,
                    height: MediaQuery.of(context).size.height * 0.9.h,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        _buildLevelHeader(),
                        _buildLearningContent(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 110.h,
              right: 10.w,
              child: ChatbotFAB(
                onTap: () => controller.toChatbot(),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildBottomNavigation(),
            ),
          ],
        );
      }),
    );
  }

  /// 🔹 상단 레벨 표시 바
  Widget _buildLevelHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: const BoxDecoration(
        color: Color(0xFF1EB692),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10.0),
          topRight: Radius.circular(10.0),
        ),
      ),
      alignment: Alignment.center,
      child: Obx(
        () => Text(
          controller.convertLevel(controller.concept['level']),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            height: 1.4,
            letterSpacing: -0.4,
          ),
        ),
      ),
    );
  }

  /// 🔹 학습 내용
  Widget _buildLearningContent() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.0),
          bottomRight: Radius.circular(10.0),
        ),
        border: Border(
          left: BorderSide(color: Color(0xFFA2A2A2), width: 1.0),
          right: BorderSide(color: Color(0xFFA2A2A2), width: 1.0),
          bottom: BorderSide(color: Color(0xFFA2A2A2), width: 1.0),
        ),
      ),
      alignment: Alignment.topLeft,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                controller.concept['name'],
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  letterSpacing: -0.4,
                ),
              ),
              SizedBox(width: 11.w),
              Obx(() {
                return GestureDetector(
                  onTap: () => controller.toggleScrapStatus(learningSetId),
                  child: Image.asset(
                    controller.isScrapped.value
                        ? "assets/bookmark_selected.png"
                        : "assets/bookmark.png",
                    width: 13.w,
                  ),
                );
              }),
            ],
          ),
          SizedBox(height: 16.h),
          Image.asset(
            "assets/example.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width - 72.w,
          ),
          SizedBox(height: 22.h),
          ExplanationText(explanation: controller.concept['explanation']),
        ],
      ),
    );
  }

  /// 🔹 하단 네비게이션 버튼
  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 15.0,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      padding:
          EdgeInsets.only(left: 16.w, right: 16.w, bottom: 30.h, top: 16.h),
      child: isMultiLearningMode
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex > 1) {
                      setState(() {
                        currentIndex--;
                        learningSetId = learningSets![currentIndex - 1]['id'];
                      });
                      controller.fetchSingleConcept(learningSetId);
                    } else {
                      Get.offNamed('/mypage/learning');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 50.h),
                    backgroundColor: currentIndex > 1
                        ? const Color(0xFF1EB692)
                        : const Color(0xFFF2F3F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "이전",
                    style: TextStyle(
                      color: currentIndex > 1
                          ? Colors.white
                          : const Color(0xFFA2A2A2),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4.h,
                      letterSpacing: -0.45.w,
                    ),
                  ),
                ),
                SizedBox(width: 15.w),
                ElevatedButton(
                  onPressed: () {
                    if (currentIndex < totalIndex) {
                      setState(() {
                        currentIndex++;
                        learningSetId = learningSets![currentIndex - 1]['id'];
                      });
                      controller.fetchSingleConcept(learningSetId);
                    } else {
                      Get.offNamed('/mypage/learning');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(150.w, 50.h),
                    backgroundColor: currentIndex < totalIndex
                        ? Palette.buttonColorGreen
                        : const Color(0xFF00D6D6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    currentIndex < totalIndex ? "다음" : "학습완료",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                      height: 1.4.h,
                      letterSpacing: -0.45.w,
                    ),
                  ),
                ),
              ],
            )
          : ElevatedButton(
              onPressed: () => Get.back(),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(328.w, 56.h),
                backgroundColor: Palette.buttonColorBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text("학습 완료",
                  style: TextStyle(color: Colors.white, fontSize: 18.sp)),
            ),
    );
  }
}
