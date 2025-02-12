import 'package:economic_fe/data/models/chatbot/chatbot_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view_model/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final controller = Get.put(ChatbotController()); // Controller 인스턴스화
  // int currentPage = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        // 스크롤 끝에 도달하면
        if (!isLoading) {
          setState(() {
            isLoading = true;
            controller.currentPage++;
            print("current : ${controller.currentPage}");
          });
          controller
              .getChatbotList(controller.currentPage.value)
              .then((newData) {
            setState(() {
              isLoading = false;
            });
          }).catchError((e) {
            setState(() {
              isLoading = false;
            });
            print("Error: $e");
          });
        }
      }
    });
    controller.getChatbotList(0);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 앱 초기화 시 챗봇 기본 메시지 전송
    // controller.sendInitialMessages();

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: AppBar(
        backgroundColor: Palette.background,
        forceMaterialTransparency: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios_new),
        ),
        centerTitle: true,
        title: const Text(
          '챗봇',
          style: TextStyle(
            color: Color(0xFF111111),
            fontSize: 20,
            fontWeight: FontWeight.w500,
            height: 1.30,
            letterSpacing: -0.50,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                _showDeleteDialog();
              },
              child: const Icon(
                Icons.more_horiz,
                size: 28,
              ),
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 210,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Obx(
                          () {
                            return FutureBuilder<List<ChatbotModel>>(
                              future: controller
                                  .getChatbotList(controller.currentPage.value),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                // 에러인 경우
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("에러 발생 : ${snapshot.error}"),
                                  );
                                }

                                // 데이터가 없을 때
                                if (!snapshot.hasData ||
                                    snapshot.data!.isEmpty) {
                                  return const Center(
                                    child: Text("데이터가 없습니다."),
                                  );
                                }

                                final chatResponses = snapshot.data!;

                                return Expanded(
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: chatResponses.length,
                                    itemBuilder: (context, index) {
                                      final message = chatResponses[index];
                                      if (index == 0 ||
                                          _isDifferentDate(
                                              message.createdAt!,
                                              chatResponses[index - 1]
                                                  .createdAt!)) {
                                        //날짜 표시 위젯 여부 message.isDateMessage!
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Center(
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 12,
                                                        vertical: 4),
                                                decoration: ShapeDecoration(
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: const BorderSide(
                                                        width: 0.50,
                                                        color:
                                                            Color(0xFFA2A2A2)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                ),
                                                child: Text(
                                                  // DateTime.now().toString(),
                                                  message.createdAt!,
                                                  style: const TextStyle(
                                                    color: Color(0xFF404040),
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.4,
                                                    letterSpacing: -0.30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  message.sender == "USER"
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                              children: [
                                                message.sender == "USER"
                                                    ? const SizedBox()
                                                    : const SizedBox(
                                                        height: 5,
                                                      ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        // message.isSystemMessage
                                                        message.sender != "USER"
                                                            ? const Color(
                                                                0xFFF2F3F5)
                                                            : const Color(
                                                                0xFF1DB691),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 0.50,
                                                          color: Color(
                                                              0xFFA2A2A2)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 250),
                                                    child: Text(
                                                      message.message!,
                                                      style: TextStyle(
                                                        color: message.sender !=
                                                                "USER"
                                                            ? const Color(
                                                                0xFF404040)
                                                            : Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.40,
                                                        letterSpacing: -0.40,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        );
                                      } else {
                                        bool showChatbotIcon = false;
                                        bool showTime = false;

                                        // 첫 번째 챗봇 메시지에만 챗봇 아이콘 표시
                                        if (index == 0 ||
                                            chatResponses[index - 1]
                                                    .createdAt !=
                                                message.createdAt ||
                                            chatResponses[index - 1].sender ==
                                                "USER") {
                                          showChatbotIcon =
                                              !(message.sender == "USER");
                                        }

                                        // 마지막 메시지에만 전송 시각 표시
                                        // if (index == chatResponses.length - 1 ||
                                        //     chatResponses[index + 1].createdAt !=
                                        //         message.createdAt ||
                                        //     (chatResponses[index + 1].sender ==
                                        //             "USER") !=
                                        //         (message.sender == "USER")) {
                                        //   showTime = true;
                                        // }

                                        if (index == chatResponses.length - 1) {
                                          showTime = true; // 마지막 메시지
                                        } else {
                                          DateTime currentTime = DateTime.parse(
                                              message.createdAt!);
                                          DateTime nextTime = DateTime.parse(
                                              chatResponses[index + 1]
                                                  .createdAt!);

                                          // 같은 날짜인지 확인 (초 단위 비교)
                                          bool isSameTime = currentTime
                                                  .difference(nextTime)
                                                  .inSeconds ==
                                              0;

                                          // 다음 메시지와 시간이 다르거나, 보낸 사람이 다르면 시간 표시
                                          if (!isSameTime ||
                                              chatResponses[index + 1].sender !=
                                                  message.sender) {
                                            showTime = true;
                                          }
                                        }

                                        return Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              // message.isUserMessage
                                              message.sender == "USER"
                                                  ? MainAxisAlignment.end
                                                  : MainAxisAlignment.start,
                                          children: [
                                            // 쳇봇 아이콘
                                            message.sender == "USER"
                                                ? const SizedBox()
                                                : showChatbotIcon
                                                    ? Container(
                                                        width: 40,
                                                        height: 40,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                width: 0.50,
                                                                color: Color(
                                                                    0xFFA2A2A2)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                              crossAxisAlignment:
                                                  message.sender == "USER"
                                                      ? CrossAxisAlignment.end
                                                      : CrossAxisAlignment
                                                          .start,
                                              children: [
                                                message.sender == "USER"
                                                    ? const SizedBox()
                                                    : showChatbotIcon
                                                        ? const Text(
                                                            '챗봇',
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF767676),
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.40,
                                                              letterSpacing:
                                                                  -0.35,
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 16,
                                                      vertical: 10),
                                                  decoration: ShapeDecoration(
                                                    color:
                                                        // message.isSystemMessage
                                                        // message.message != null
                                                        message.sender != "USER"
                                                            ? const Color(
                                                                0xFFF2F3F5)
                                                            : const Color(
                                                                0xFF1DB691),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                          width: 0.50,
                                                          color: Color(
                                                              0xFFA2A2A2)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                    ),
                                                  ),
                                                  child: Container(
                                                    constraints:
                                                        const BoxConstraints(
                                                            maxWidth: 250),
                                                    child: Text(
                                                      message.message!,
                                                      style: TextStyle(
                                                        color: message.sender !=
                                                                "USER"
                                                            ? const Color(
                                                                0xFF404040)
                                                            : Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.40,
                                                        letterSpacing: -0.40,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                // 전송 시각 표시
                                                showTime
                                                    ? Text(
                                                        // message.createdAt!,
                                                        // DateFormat(
                                                        //         'a HH:mm', 'ko')
                                                        //     .format(DateTime
                                                        //         .parse(message
                                                        //             .createdAt!)),
                                                        DateFormat('HH:mm')
                                                            .format(DateTime
                                                                .parse(message
                                                                    .createdAt!)),
                                                        style: const TextStyle(
                                                          color:
                                                              Color(0xFFA2A2A2),
                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                          letterSpacing: -0.30,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                const SizedBox(height: 10),
                                                // 챗봇 이용 꿀팁
                                                controller.chatbotTip.value
                                                    ? Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                horizontal: 16,
                                                                vertical: 10),
                                                        decoration:
                                                            ShapeDecoration(
                                                          color:
                                                              // message.isSystemMessage
                                                              // message.message != null
                                                              const Color(
                                                                  0xFFF2F3F5),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            side: const BorderSide(
                                                                width: 0.50,
                                                                color: Color(
                                                                    0xFFA2A2A2)),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        12),
                                                          ),
                                                        ),
                                                        child: Container(
                                                          constraints:
                                                              const BoxConstraints(
                                                                  maxWidth:
                                                                      250),
                                                          child: const Text(
                                                            "d",
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF404040),
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.40,
                                                              letterSpacing:
                                                                  -0.40,
                                                            ),
                                                          ),
                                                        ))
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ],
                                        );
                                      }
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            controller.currentPage++;
                            print("cr : ${controller.currentPage}");
                          },
                          icon: const Icon(Icons.arrow_downward_outlined)),
                      // TextButton(
                      //     onPressed: () {
                      //       controller.deleteMessage();
                      //     },
                      //     child: const Text("초기화"))
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10,
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
                                  // controller.sendTipMessages();
                                  print("tap");
                                  controller.chatbotTip.value =
                                      !controller.chatbotTip.value;
                                  print(controller.chatbotTip.value);
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
                              return SizedBox(
                                width: 280,
                                child: TextField(
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
                                        // controller.sendMessage();
                                        controller.postChatbotMessage();
                                        controller.messageController.clear();
                                      },
                                      icon: controller
                                              .messageText.value.isNotEmpty
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
                                ),
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

  bool _isDifferentDate(String date1, String date2) {
    DateTime parsedDate1 = DateTime.parse(date1);
    DateTime parsedDate2 = DateTime.parse(date2);

    return parsedDate1.year != parsedDate2.year ||
        parsedDate1.month != parsedDate2.month ||
        parsedDate1.day != parsedDate2.day;
  }

  Future<void> _showDeleteDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
            backgroundColor: Colors.white,
            content: Container(
              width: 324,
              height: 54,
              padding: const EdgeInsets.only(
                top: 10,
                left: 27,
                right: 10,
                bottom: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      _showDeleteConfirmDialog();
                    },
                    child: const Text(
                      '채팅 삭제하기',
                      style: TextStyle(
                        color: Color(0xFF111111),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        height: 1.30,
                        letterSpacing: -0.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _showDeleteConfirmDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            backgroundColor: Colors.white,
            content: Container(
              width: 312,
              height: 108,
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        '정말 채팅 기록을 삭제하시겠어요?',
                        style: TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: const Text(
                          '취소',
                          style: TextStyle(
                            color: Color(0xFF9B9A99),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 32,
                      ),
                      GestureDetector(
                        onTap: () {
                          controller.deleteMessage();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          '삭제',
                          style: TextStyle(
                            color: Color(0xFF2AD6D6),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            height: 1.40,
                            letterSpacing: -0.40,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
