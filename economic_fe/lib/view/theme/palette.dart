import 'package:economic_fe/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class Palette {
  //사용하는 색상들
  static const Color background = Color.fromARGB(255, 255, 255, 255);
  static const Color buttonColorBlue = Color(0xFF00D6D6);
  static const Color buttonColorGreen = Color(0xFF1EB692);

  //사용하는 text style
  static TextStyle title = const TextStyle(
    color: Color(0xFF000000),
    fontFamily: 'Palanquin Dark',
    fontSize: 45.0,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    height: 1.0,
    letterSpacing: -0.9,
    fontFeatures: [
      FontFeature.liningFigures(),
      FontFeature.proportionalFigures(),
      FontFeature.enable('dlig'),
    ],
  );

  static TextStyle subtitle = const TextStyle(
    color: Color(0xFF000000),
    fontFamily: 'SF Pro Text',
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    height: 1.4,
    letterSpacing: -0.8,
    fontFeatures: [
      FontFeature.enable('dlig'),
      FontFeature.liningFigures(),
      FontFeature.proportionalFigures(),
    ],
  );

  static TextStyle subleveltitle = const TextStyle(
    color: Color(0xFF111111),
    fontFamily: 'Pretendard Variable',
    fontSize: 16.0,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: -0.4,
  );

  static TextStyle cardTitle = const TextStyle(
    color: Color(0xFF000000),
    fontFamily: 'Pretendard Variable',
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.7,
    height: 1.2,
    fontStyle: FontStyle.normal,
  );

  static TextStyle cardSub = const TextStyle(
    color: Color(0xFF000000),
    fontFamily: "Pretendard Variable",
    fontSize: 14,
    fontStyle: FontStyle.normal,
    fontWeight: FontWeight.w400,
    height: 1.2,
    letterSpacing: -0.35,
  );

  // 로그인 화면 TextStyle
  static TextStyle loginTitle(BuildContext context) {
    return TextStyle(
      fontFamily: 'Pretendard',
      fontSize: ScreenUtils.getWidth(context, 20), // 화면 너비에 비례
      fontWeight: FontWeight.w400,
      letterSpacing: ScreenUtils.getWidth(context, -0.50),
    );
  }
}
