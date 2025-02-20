import 'package:economic_fe/data/models/level_test/level_test_answer_model.dart';
import 'package:economic_fe/data/models/level_test/level_test_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/login/agreement_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  late final AgreementController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AgreementController());
  }

  @override
  Widget build(BuildContext context) {
    final arguments = Get.arguments as Map<String, dynamic>;
    final List<LevelTestAnswerModel> answers = arguments['levelTestAnswers'];
    final List<QuizModel> quizList = arguments['quizList'];

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: "",
        icon: Icons.arrow_back_ios_new,
        onPress: () {
          controller.clickedBackBtn();
        },
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 24.w, top: 30.h, bottom: 11.h),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icon.png',
                      width: 25.63.w,
                      height: 31.74.h,
                    ),
                    SizedBox(
                      width: 3.78.w,
                    ),
                    Text(
                      "Ripple",
                      style: TextStyle(
                        color: const Color(0xFF111111),
                        fontSize: 22.4.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 1.0,
                        letterSpacing: -0.448,
                        fontFeatures: const [
                          FontFeature.liningFigures(),
                          FontFeature.proportionalFigures(),
                          FontFeature.enable('dlig'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 24.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "리플 약관 동의",
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 22.4.sp,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            height: 1.0,
                            letterSpacing: -0.448,
                            fontFeatures: const [
                              FontFeature.liningFigures(),
                              FontFeature.proportionalFigures(),
                              FontFeature.enable('dlig'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    Text(
                      "서비스 시작 및 가입을 위해 가입 및 정보 제공에",
                      style: TextStyle(
                        color: const Color(0xFF767676),
                        fontFamily: 'Pretendard Variable',
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 1.3,
                        letterSpacing: -0.35,
                      ),
                    ),
                    Text(
                      "동의해주세요.",
                      style: TextStyle(
                        color: const Color(0xFF767676),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.normal,
                        height: 1.3,
                        letterSpacing: -0.35,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 28.h,
              ),
              Container(
                width: 312.w,
                height: 1,
                color: Colors.grey,
              ),
              SizedBox(
                height: 16.h,
              ),
              Obx(() {
                return Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 31.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.toggleAllCheckbox();
                          },
                          child: Image.asset(
                            controller.isCheckedAll.value
                                ? 'assets/check_fill.png'
                                : 'assets/check.png',
                            width: 25.63.w,
                            height: 31.74.h,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "모두 동의합니다.",
                          style: TextStyle(
                            color: const Color(0xFF111111),
                            fontSize: 16.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w600,
                            height: 1.5,
                            letterSpacing: -0.4,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Container(
                      width: 312.w,
                      height: 1.h,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 3.w),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 31.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.toggleOneCheckbox();
                            },
                            child: Image.asset(
                              controller.isCheckedOne.value
                                  ? 'assets/check_fill.png'
                                  : 'assets/check.png',
                            ),
                          ),
                          SizedBox(
                            width: 16.w,
                          ),
                          Text(
                            "(필수) 리플 서비스 이용 약관",
                            style: TextStyle(
                              color: const Color(0xFF767676),
                              fontSize: 14.sp,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: -0.35,
                            ),
                          ),
                          SizedBox(
                            width: 60.w,
                          ),
                          IconButton(
                            onPressed: () {
                              controller.clickedDetailBtn(context);
                            },
                            icon: Icon(
                              Icons.arrow_forward_ios_outlined,
                              color: const Color(0xFF767676),
                              size: 20.w,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 31.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.toggleTwoCheckbox();
                          },
                          child: Image.asset(
                            controller.isCheckedTwo.value
                                ? 'assets/check_fill.png'
                                : 'assets/check.png',
                            width: 25.63.w,
                            height: 31.74.h,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "(필수) 개인정보 수집・이용 동의",
                          style: TextStyle(
                            color: const Color(0xFF767676),
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 17.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 31.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            controller.toggleThreeCheckbox();
                          },
                          child: Image.asset(
                            controller.isCheckedThree.value
                                ? 'assets/check_fill.png'
                                : 'assets/check.png',
                            width: 25.63.w,
                            height: 31.74.h,
                          ),
                        ),
                        SizedBox(
                          width: 16.w,
                        ),
                        Text(
                          "(필수) 만 14세 이상입니다.",
                          style: TextStyle(
                            color: const Color(0xFF767676),
                            fontSize: 14.sp,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w400,
                            height: 1.5,
                            letterSpacing: -0.35,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ],
          ),
          Obx(() {
            return controller.isCheckedAll.value
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          controller.clickedConfirmBtn(answers, quizList);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 58.w,
                          decoration:
                              const BoxDecoration(color: Color(0xFF2AD6D6)),
                          child: Center(
                            child: Text(
                              '확인',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                height: 1.50,
                                letterSpacing: -0.40,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 34.h,
                      ),
                    ],
                  )
                : const SizedBox();
          }),
        ],
      ),
    );
  }
}
