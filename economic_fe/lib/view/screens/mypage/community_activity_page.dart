import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CategoryText(text: '스크랩'),
            CategoryOptions(
              text: '스크랩 한 글',
              onTap: () {},
            ),
            const SizedBox(
              height: 31.5,
            ),
            const CategoryText(text: '좋아요'),
            CategoryOptions(
              text: '좋아요 한 글',
              onTap: () {},
            ),
            CategoryOptions(
              text: '좋아요 한 댓글',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryOptions extends StatelessWidget {
  final String text;
  final Function() onTap;

  const CategoryOptions({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 6, top: 27.5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xFF111111),
              fontSize: 16,
              fontWeight: FontWeight.w400,
              height: 1.40,
              letterSpacing: -0.40,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(
              Icons.arrow_forward_ios,
              size: 15,
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryText extends StatelessWidget {
  final String text;

  const CategoryText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF111111),
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 1.30,
        letterSpacing: -0.45,
      ),
    );
  }
}
