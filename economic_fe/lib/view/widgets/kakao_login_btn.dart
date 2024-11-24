import 'package:economic_fe/utils/screen_utils.dart';
import 'package:flutter/material.dart';

class KakaoLoginBtn extends StatelessWidget {
  const KakaoLoginBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtils.getWidth(context, 280),
      height: ScreenUtils.getHeight(context, 60),
      decoration: BoxDecoration(
        color: const Color(0xfffee500),
        borderRadius: BorderRadius.circular(
          ScreenUtils.getWidth(context, 7),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: ScreenUtils.getWidth(context, 24),
          ),
          Image.asset(
            "assets/kakao_icon.png",
            width: ScreenUtils.getWidth(context, 28),
            height: ScreenUtils.getHeight(context, 28),
          ),
          SizedBox(
            width: ScreenUtils.getWidth(context, 46),
          ),
          Text(
            "카카오 로그인",
            style: TextStyle(
              fontSize: ScreenUtils.getWidth(context, 16),
              fontWeight: FontWeight.w500,
              letterSpacing: ScreenUtils.getWidth(context, -0.40),
            ),
          ),
        ],
      ),
    );
  }
}
