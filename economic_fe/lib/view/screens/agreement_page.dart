import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class AgreementPage extends StatefulWidget {
  const AgreementPage({super.key});

  @override
  State<AgreementPage> createState() => _AgreementPageState();
}

class _AgreementPageState extends State<AgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const CustomAppBar(title: "", icon: Icons.arrow_back),
      body: Column(
        children: [
          // const SizedBox(
          //   height: 25,
          // ),
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
          const Row(
            children: [],
          )

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
