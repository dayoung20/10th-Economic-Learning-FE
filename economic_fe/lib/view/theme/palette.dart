import 'package:flutter/material.dart';

class Palette {
  //사용하는 색상들
  static const Color background = Color.fromARGB(255, 255, 255, 255);

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
}
