import 'package:economic_fe/data/models/chatbot/message.dart';
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

    // 앱 초기화 시 챗봇 기본 메시지 전송
    controller.sendInitialMessages();

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
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: // 메시지 리스트 (각 메시지와 시간 표시)
                            Obx(() {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              final message = controller.messages[index];
                              if (message.isDateMessage!) {
                                return Center(
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 4),
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFA2A2A2)),
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                    child: Text(
                                      message.text,
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
                              } else {
                                bool showChatbotIcon = false;
                                bool showTime = false;

                                // 첫 번째 챗봇 메시지에만 챗봇 아이콘 표시
                                if (index == 0 ||
                                    controller.messages[index - 1].time !=
                                        message.time ||
                                    controller
                                        .messages[index - 1].isUserMessage) {
                                  showChatbotIcon = !message.isUserMessage;
                                }

                                // 마지막 메시지에만 전송 시각 표시
                                if (index == controller.messages.length - 1 ||
                                    controller.messages[index + 1].time !=
                                        message.time ||
                                    controller.messages[index + 1]
                                            .isUserMessage !=
                                        message.isUserMessage) {
                                  showTime = true;
                                }

                                return Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: message.isUserMessage
                                      ? MainAxisAlignment.end
                                      : MainAxisAlignment.start,
                                  children: [
                                    // 쳇봇 아이콘
                                    message.isUserMessage
                                        ? const SizedBox()
                                        : showChatbotIcon
                                            ? Container(
                                                width: 40,
                                                height: 40,
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            Color(0xFFA2A2A2)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                ),
                                                child: Image.asset(
                                                    'assets/icon.png'),
                                              )
                                            : const SizedBox(
                                                width: 40,
                                              ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Column(
                                      crossAxisAlignment: message.isUserMessage
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        message.isUserMessage
                                            ? const SizedBox()
                                            : showChatbotIcon
                                                ? const Text(
                                                    '챗봇',
                                                    style: TextStyle(
                                                      color: Color(0xFF767676),
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      height: 1.40,
                                                      letterSpacing: -0.35,
                                                    ),
                                                  )
                                                : const SizedBox(),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 16, vertical: 10),
                                          decoration: ShapeDecoration(
                                            color: message.isSystemMessage
                                                ? const Color(0xFFF2F3F5)
                                                : const Color(0xFF1DB691),
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                  width: 0.50,
                                                  color: Color(0xFFA2A2A2)),
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: Container(
                                            constraints: const BoxConstraints(
                                                maxWidth: 250),
                                            child: Text(
                                              message.text,
                                              style: TextStyle(
                                                color: message.isSystemMessage
                                                    ? const Color(0xFF404040)
                                                    : Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                height: 1.40,
                                                letterSpacing: -0.40,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // 전송 시각 표시
                                        showTime
                                            ? Text(
                                                message.time,
                                                style: const TextStyle(
                                                  color: Color(0xFFA2A2A2),
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w400,
                                                  height: 1.40,
                                                  letterSpacing: -0.30,
                                                ),
                                              )
                                            : const SizedBox(),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ],
                                );
                              }
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
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
                                  controller.sendTipMessages();
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
