import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/mypage/category_options.dart';
import 'package:economic_fe/view/widgets/mypage/category_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CommunityActivityPage extends StatefulWidget {
  const CommunityActivityPage({super.key});

  @override
  State<CommunityActivityPage> createState() => _CommunityActivityPageState();
}

class _CommunityActivityPageState extends State<CommunityActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '커뮤니티 활동',
        icon: Icons.arrow_back_ios_new,
        onPress: () => Get.back(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 13.5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryText(text: '스크랩'),
            CategoryOptions(
              text: '스크랩 한 글',
              onTap: () {
                Get.toNamed(
                  '/mypage/community/post',
                  arguments: '스크랩 한 글',
                );
              },
            ),
            SizedBox(
              height: 31.5.h,
            ),
            const CategoryText(text: '좋아요'),
            CategoryOptions(
              text: '좋아요 한 글',
              onTap: () {
                Get.toNamed(
                  '/mypage/community/post',
                  arguments: '좋아요 한 글',
                );
              },
            ),
            CategoryOptions(
              text: '좋아요 한 댓글',
              onTap: () {
                Get.toNamed(
                  '/mypage/community/post',
                  arguments: '좋아요 한 댓글',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
