//
// 화면 비율에 따른 요소 크기 설정
//

// 피그마 화면 크기
// width: 360
// height: 740

import 'package:flutter/material.dart';

class ScreenUtils {
  static double getWidth(BuildContext context, double width) {
    return MediaQuery.of(context).size.width * width / 360;
  }

  static double getHeight(BuildContext context, double height) {
    return MediaQuery.of(context).size.height * height / 748;
  }
}
