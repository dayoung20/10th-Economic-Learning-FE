import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/chatbot_fab.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/learning_set/learning_list_item.dart';
import 'package:economic_fe/view_model/learning_set/learning_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LearningListPage extends StatefulWidget {
  const LearningListPage({super.key});

  @override
  State<LearningListPage> createState() => _LearningListPageState();
}

class _LearningListPageState extends State<LearningListPage> {
  final LearningListController controller = Get.put(LearningListController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("init state");
    controller.getLearningConcept(1, "BEGINNER");
    print("끝");
  }

  @override
  Widget build(BuildContext context) {
    // 학습 세트 제목 리스트 (이 리스트를 통해 반복적으로 항목을 생성)
    List<String> setTitles = [
      '인플레이션',
      '경제 성장',
      '실업',
      '국제 무역',
      '소비자 행동',
      '시장 구조',
      '통화 정책',
      '재정 정책',
      '세금',
      '경제 지표'
    ];

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '전체 학습 세트',
        icon: Icons.arrow_back_ios_new,
        onPress: () {
          controller.navigateToHome(context);
        },
      ),
      floatingActionButton: ChatbotFAB(
        onTap: () => controller.toChatbot(),
      ),
      body: ListView.builder(
        itemCount: setTitles.length, // 학습 세트 개수
        itemBuilder: (context, index) {
          return Column(
            children: [
              SizedBox(
                height: ScreenUtils.getHeight(context, 12),
              ),
              LearningListItem(
                setNum: index + 1, // setNum은 1부터 시작하도록 설정
                setTitle: setTitles[index], index: index, // 각 제목을 리스트에서 가져옴
              ),
            ],
          );
        },
      ),
    );
  }
}
