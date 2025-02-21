import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view_model/test/test_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  late final TestController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(TestController()..getStats());
    controller.getLevelTest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 178.h,
                ),
                SizedBox(
                  height: 78.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '경제학습의 첫걸음,',
                        style: Palette.cardTitle,
                      ),
                      Row(
                        children: [
                          Text(
                            '나의 레벨은?',
                            style: Palette.cardTitle,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Image.asset(
                            "assets/icon.png", width: 35.w, // 원하는 가로 크기
                            height: 35.h,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 44.h,
                ),
                Text(
                  '학습 수준을 정확히 파악할 수 있도록 \n간단한 테스트를 준비했습니다. \n함께 시작해볼까요?',
                  style: Palette.subleveltitle,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Center(
                child: CustomButton(
                  text: "시작하기",
                  onPress: () {
                    // controller.clickedTestBtn(context);
                    controller.test(context);
                  },
                  bgColor: Palette.buttonColorBlue,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    controller.clickedAfterBtn();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Text(
                      '나중에 시작할래요',
                      style: TextStyle(
                        color: const Color(0xFF404040),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        letterSpacing: -0.35,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 69.h,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
