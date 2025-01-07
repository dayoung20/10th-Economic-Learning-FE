import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatbotPage extends StatelessWidget {
  const ChatbotPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChatbotController()); // Controller 인스턴스화

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: const CustomAppBar(
        title: '챗봇',
        icon: Icons.arrow_back_ios_new,
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    children: [
                      // 날짜 (Obx로 감싸서 실시간으로 업데이트)
                      Obx(() {
                        return Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 4),
                            decoration: ShapeDecoration(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    width: 0.50, color: Color(0xFFA2A2A2)),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: Text(
                              controller.currentDate.value,
                              style: const TextStyle(
                                color: Color(0xFF404040),
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.30,
                              ),
                            ),
                          ),
                        );
                      }),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              padding: const EdgeInsets.all(8),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      width: 0.50, color: Color(0xFFA2A2A2)),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Image.asset('assets/icon.png'),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '챗봇',
                                  style: TextStyle(
                                    color: Color(0xFF767676),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    height: 1.40,
                                    letterSpacing: -0.35,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                // 챗봇 기본 메세지
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: ShapeDecoration(
                                    color: const Color(0xFFF2F3F5),
                                    shape: RoundedRectangleBorder(
                                      side: const BorderSide(
                                          width: 0.50,
                                          color: Color(0xFFA2A2A2)),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text(
                                    '무엇을 도와드릴까요?',
                                    style: TextStyle(
                                      color: Color(0xFF404040),
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      height: 1.40,
                                      letterSpacing: -0.40,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                // 챗봇 이용꿀팁
                                Obx(() {
                                  return controller.isHelpTipVisible.value
                                      ? Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: ShapeDecoration(
                                            color: const Color(0xFFF2F3F5),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.50,
                                                  color: Color(0xFFA2A2A2)),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: const SizedBox(
                                            width: 300,
                                            child: Text(
                                              '✨ 리플의 AI 챗봇을 200% 활용하는\n무엇을 도와드릴까요?\n \n1. 명확하고 구체적으로 작성하기 \n- 무엇을 원하는지 구체적으로 설명해 보세요! \n- 예시 : "복리를 이해하기 위해, 연 5% 이자율로 3년 동안 100만 원이 어떻게 증가하는지 구체적으로 계산해줘." \n\n2. 배경 정보 제공하기 \n- 질문이나 질문자의 배경 정보를 알려주세요! \n- 예시 : "경제를 공부하는 대학생인데, \n단리와 복리의 차이를 쉽게 이해할 수 있도록 설명해줘." \n\n3. 결과물 형식 명시하기 \n- 결과물을 어떤 형태로 제공받고 싶은지 알려주세요! \n- 예시 : “단리와 복리의 차이를 표로 정리하고, 간단한 계산 예를 포함해 설명해줘."',
                                              style: TextStyle(
                                                color: Color(0xFF404040),
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                height: 1.40,
                                                letterSpacing: -0.40,
                                              ),
                                              softWrap: true,
                                            ),
                                          ),
                                        )
                                      : const SizedBox();
                                }),
                                const SizedBox(
                                  height: 3,
                                ),
                                // 메세지가 전송된 시각
                                Obx(() {
                                  return controller.isHelpTipVisible.value
                                      ? Text(
                                          controller.currentTime.value,
                                          style: const TextStyle(
                                            color: Color(0xFFA2A2A2),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400,
                                            height: 1.40,
                                            letterSpacing: -0.30,
                                          ),
                                        )
                                      : const SizedBox();
                                }),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  Obx(() {
                    return controller.isExpanded.value
                        ? Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.isExpanded.value =
                                      !controller.isExpanded.value;
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.all(10),
                                  decoration: const ShapeDecoration(
                                    color: Color(0xFFDEF7F1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                  ),
                                  child: Image.asset(
                                    'assets/chatbot_slider.png',
                                    width: 30.5,
                                    height: 3,
                                  ),
                                ),
                              ),
                              // 챗봇 이용꿀팁
                              GestureDetector(
                                onTap: () {
                                  controller.isHelpTipVisible.value = true;
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 10),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFDEF7F1)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/chatbot.png',
                                        width: 28,
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text(
                                        '챗봇 이용꿀팁',
                                        style: TextStyle(
                                          color: Color(0xFF404040),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          height: 1.40,
                                          letterSpacing: -0.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        : GestureDetector(
                            onTap: () {
                              print('${controller.isExpanded.value}');
                              controller.isExpanded.value =
                                  !controller.isExpanded.value;
                              print('${controller.isExpanded.value}');
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(10),
                              decoration: const ShapeDecoration(
                                color: Color(0xFFDEF7F1),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'assets/chatbot_slider.png',
                                width: 30.5,
                                height: 3,
                              ),
                            ),
                          );
                  }),

                  // 메세지 전송창
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 7),
                      decoration: ShapeDecoration(
                        color: const Color(0xFFF2F3F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 텍스트 입력창
                          Expanded(
                            child: Obx(() {
                              return TextField(
                                controller: controller.messageController,
                                onChanged: (value) {
                                  controller.updateMessage(value);
                                },
                                decoration: InputDecoration(
                                  hintText: '메시지를 입력해주세요.',
                                  hintStyle: const TextStyle(
                                    color: Color(0xFFA2A2A2),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: -0.40,
                                  ),
                                  border: InputBorder.none,
                                  suffixIcon: IconButton(
                                    onPressed: () {
                                      controller.sendMessage();
                                    },
                                    icon:
                                        controller.messageText.value.isNotEmpty
                                            ? Image.asset(
                                                'assets/send_active.png',
                                                width: 24,
                                              )
                                            : Image.asset(
                                                'assets/send.png',
                                                width: 24,
                                              ),
                                  ),
                                ),
                                maxLines: 5, // 최대 줄 수
                                minLines: 1, // 최소 줄 수
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
