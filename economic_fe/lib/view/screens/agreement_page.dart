import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/agreement_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  late final AgreementController controller;
  bool isCheckedAll = false;
  bool isCheckedOne = false;
  bool isCheckdeTwo = false;
  bool isCheckedThree = false;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AgreementController()..getStats());
    isCheckedOne = controller.check.value;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const CustomAppBar(title: "", icon: Icons.arrow_back),
      body: Column(
        children: [
          Container(
            // padding: const EdgeInsets.fromLTRB(24, 30, , 11),
            padding: const EdgeInsets.only(left: 24, top: 30, bottom: 11),
            child: Row(
              children: [
                Image.asset(
                  'assets/icon.png',
                  width: 25.63,
                  height: 31.74,
                ),
                const SizedBox(
                  width: 3.78,
                ),
                const Text(
                  "Ripple",
                  style: TextStyle(
                    color: Color(0xFF111111), // #111 in Flutter hexadecimal
                    fontFamily: 'Palanquin Dark',
                    fontSize: 22.4,
                    fontWeight: FontWeight.w400, // Normal weight
                    fontStyle: FontStyle.normal, // Normal style
                    height: 1.0, // Normal line-height (relative)
                    letterSpacing: -0.448, // Negative letter spacing
                    fontFeatures: [
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
            // padding: const EdgeInsets.fromLTRB(24, 30, , 11),
            padding: const EdgeInsets.only(
              left: 24,
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Image.asset(
                    //   'assets/icon.png',
                    //   width: 25.63,
                    //   height: 31.74,
                    // ),
                    // const SizedBox(
                    //   width: 3.78,
                    // ),
                    Text(
                      "리플 약관 동의",
                      style: TextStyle(
                        color: Color(0xFF111111), // #111 in Flutter hexadecimal
                        fontFamily: 'Palanquin Dark',
                        fontSize: 22.4,
                        fontWeight: FontWeight.w400, // Normal weight
                        fontStyle: FontStyle.normal, // Normal style
                        height: 1.0, // Normal line-height (relative)
                        letterSpacing: -0.448, // Negative letter spacing
                        fontFeatures: [
                          FontFeature.liningFigures(),
                          FontFeature.proportionalFigures(),
                          FontFeature.enable('dlig'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  "서비스 시작 및 가입을 위해 가입 및 정보 제공에",
                  style: TextStyle(
                    color: Color(0xFF767676), // var(--Black-2, #767676)
                    fontFamily: 'Pretendard Variable',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400, // Normal weight
                    fontStyle: FontStyle.normal, // Normal style
                    height: 1.3, // 130% line-height (relative to fontSize)
                    letterSpacing: -0.35, // Negative letter spacing
                  ),
                ),
                Text(
                  "동의해주세요.",
                  style: TextStyle(
                    color: Color(0xFF767676), // var(--Black-2, #767676)
                    fontFamily: 'Pretendard Variable',
                    fontSize: 14.0,
                    fontWeight: FontWeight.w400, // Normal weight
                    fontStyle: FontStyle.normal, // Normal style
                    height: 1.3, // 130% line-height (relative to fontSize)
                    letterSpacing: -0.35, // Negative letter spacing
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 28,
          ),
          Container(
            width: 312,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 31,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCheckedAll = !isCheckedAll;
                    isCheckedOne = isCheckedAll;
                    isCheckdeTwo = isCheckedAll;
                    isCheckedThree = isCheckedAll;
                  });
                },
                child: Image.asset(
                  isCheckedAll ? 'assets/check_fill.png' : 'assets/check.png',
                  width: 25.63,
                  height: 31.74,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text(
                "모두 동의합니다.",
                style: TextStyle(
                  color: Color(0xFF111111), // #111 in hex
                  fontFamily: 'Pretendard Variable',
                  fontSize: 16.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600, // Font weight 600
                  height: 1.5, // Line height (150% of font size)
                  letterSpacing: -0.4,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            width: 312,
            height: 1,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const SizedBox(
                width: 31,
              ),
              GestureDetector(onTap: () {
                setState(() {
                  isCheckedOne = !isCheckedOne;
                  controller.check.value = !controller.check.value;
                });
              },
                  //     Obx(() {
                  //   // check 값이 변경될 때마다 UI가 자동으로 갱신됩니다.
                  //   return Text(controller.check.value ? "Checked" : "Unchecked");
                  // }),
                  // child: Image.asset(
                  //   isCheckedOne ? 'assets/check_fill.png' : 'assets/check.png',
                  //   width: 25.63,
                  //   height: 31.74,
                  // ),
                  child: Obx(() {
                return Image.asset(
                  controller.check.value
                      ? 'assets/check_fill.png'
                      : 'assets/check.png',
                );
              })),
              const SizedBox(
                width: 16,
              ),
              const Text(
                "(필수) 리플 서비스 이용 약관",
                style: TextStyle(
                  color: Color(0xFF767676),
                  fontFamily: 'Pretendard Variable',
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400,
                  height: 1.5,
                  letterSpacing: -0.35,
                ),
              ),
              const SizedBox(
                width: 60,
              ),
              IconButton(
                onPressed: () {
                  controller.clickedDetailBtn(context);
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: Color(0xFF767676),
                  size: 20.0,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 17,
          ),
          // Container(
          //   width: 312,
          //   height: 1,
          //   color: Colors.grey,
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          Row(
            children: [
              const SizedBox(
                width: 31,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCheckdeTwo = !isCheckdeTwo;
                  });
                },
                child: Image.asset(
                  isCheckdeTwo ? 'assets/check_fill.png' : 'assets/check.png',
                  width: 25.63,
                  height: 31.74,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text(
                "(필수) 개인정보 수집・이용 동의",
                style: TextStyle(
                  color: Color(0xFF767676), // #767676 in hex
                  fontFamily: 'Pretendard Variable',
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400, // Font weight 400
                  height: 1.5, // Line height (150% of font size)
                  letterSpacing: -0.35,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 17,
          ),
          // Container(
          //   width: 312,
          //   height: 1,
          //   color: Colors.grey,
          // ),
          // const SizedBox(
          //   height: 16,
          // ),
          Row(
            children: [
              const SizedBox(
                width: 31,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCheckedThree = !isCheckedThree;
                  });
                },
                child: Image.asset(
                  isCheckedThree ? 'assets/check_fill.png' : 'assets/check.png',
                  width: 25.63,
                  height: 31.74,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Text(
                "(필수) 만 14세 이상입니다.",
                style: TextStyle(
                  color: Color(0xFF767676), // #767676 in hex
                  fontFamily: 'Pretendard Variable',
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w400, // Font weight 400
                  height: 1.5, // Line height (150% of font size)
                  letterSpacing: -0.35,
                ),
              ),
            ],
          ),
          // Container(
          //   padding: const EdgeInsets.only(left: 24, bottom: 14),
          //   child: const Text(
          //     "리플 약관 동의",
          //     style: TextStyle(
          //       color: Color(0xFF111111), // #111 in Flutter hexadecimal
          //       fontFamily: 'Palanquin Dark',
          //       fontSize: 22.4,
          //       fontWeight: FontWeight.w400, // Normal weight
          //       fontStyle: FontStyle.normal, // Normal style
          //       height: 1.0, // Normal line-height (relative)
          //       letterSpacing: -0.448, // Negative letter spacing
          //       fontFeatures: [
          //         FontFeature.liningFigures(),
          //         FontFeature.proportionalFigures(),
          //         FontFeature.enable('dlig'),
          //       ],
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
