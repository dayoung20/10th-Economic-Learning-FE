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
  Widget build(BuildContext context) {
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
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.learningSetList.isEmpty) {
          return const Center(child: Text('학습 세트가 없습니다.'));
        }

        return ListView.builder(
          itemCount: controller.learningSetList.length, // 학습 세트 개수
          itemBuilder: (context, index) {
            final learningSet = controller.learningSetList[index];

            return Column(
              children: [
                SizedBox(
                  height: ScreenUtils.getHeight(context, 12),
                ),
                LearningListItem(
                  setNum: index + 1, // setNum은 1부터 시작하도록 설정
                  setTitle: learningSet.name!,
                  index: index, // 각 제목을 리스트에서 가져옴
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
