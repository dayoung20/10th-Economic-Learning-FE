import 'package:economic_fe/data/models/chatbot/chatbot_model.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view_model/chatbot_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        title: Text(
          '챗봇',
          style: TextStyle(
            color: const Color(0xFF111111),
            fontSize: 20.sp,
            fontWeight: FontWeight.w500,
            height: 1.30,
            letterSpacing: -0.50,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                _showDeleteDialog();
              },
              child: Icon(
                Icons.more_horiz,
                size: 28.w,
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
              height: MediaQuery.of(context).size.height - 210.h,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h),
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
                                    reverse: true,
                                    controller: _scrollController,
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: chatResponses.length,
                                    itemBuilder: (context, index) {
                                      final message = chatResponses[index];
                                      if (index == 0 ||
                                          controller.formatCreatedAt(
                                                  message.createdAt!) !=
                                              controller.formatCreatedAt(
                                                  chatResponses[index - 1]
                                                      .createdAt!)) {
                                        //날짜 표시 위젯 여부 message.isDateMessage!
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Center(
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 12.w,
                                                    vertical: 4.h),
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
                                                  controller.formatCreatedAt(
                                                      message.createdAt!),
                                                  // message.createdAt!,
                                                  style: TextStyle(
                                                    color:
                                                        const Color(0xFF404040),
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.4.h,
                                                    letterSpacing: -0.30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.h,
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
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 10.h),
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
                                                        fontSize: 16.sp,
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
                                        bool showChatbotIcon = true;
                                        bool showTime = false;

                                        // // 첫 번째 챗봇 메시지에만 챗봇 아이콘 표시
                                        // if (message.sender != "USER") {
                                        //   showChatbotIcon =
                                        //       !(message.sender == "USER");
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
                                                        width: 40.w,
                                                        height: 40.h,
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
                                                    : SizedBox(
                                                        width: 40.w,
                                                      ),
                                            SizedBox(
                                              width: 8.w,
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
                                                        ? Text(
                                                            '챗봇',
                                                            style: TextStyle(
                                                              color: const Color(
                                                                  0xFF767676),
                                                              fontSize: 14.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              height: 1.40,
                                                              letterSpacing:
                                                                  -0.35,
                                                            ),
                                                          )
                                                        : const SizedBox(),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 16.w,
                                                      vertical: 10.h),
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
                                                    constraints: BoxConstraints(
                                                        maxWidth: 250.w),
                                                    child: Text(
                                                      message.message!,
                                                      style: TextStyle(
                                                        color: message.sender !=
                                                                "USER"
                                                            ? const Color(
                                                                0xFF404040)
                                                            : Colors.white,
                                                        fontSize: 16.sp,
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
                                                        DateFormat('HH:mm')
                                                            .format(DateTime
                                                                .parse(message
                                                                    .createdAt!)),
                                                        style: TextStyle(
                                                          color: const Color(
                                                              0xFFA2A2A2),
                                                          fontSize: 12.sp,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height: 1.40,
                                                          letterSpacing: -0.30,
                                                        ),
                                                      )
                                                    : const SizedBox(),
                                                SizedBox(height: 10.h),
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
                          },
                          icon: const Icon(Icons.arrow_downward_outlined)),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 10.h,
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
                                  debugPrint("tap");
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
                                    width: 30.5.w,
                                    height: 3.h,
                                  ),
                                ),
                              ),
                              // 챗봇 이용꿀팁
                              GestureDetector(
                                onTap: () {
                                  // controller.sendTipMessages();
                                  // print("tapdd");
                                  controller.getChatbotTips();
                                  controller.chatbotTip.value =
                                      !controller.chatbotTip.value;
                                  Get.off(() => const ChatbotPage());
                                  setState(() {});
                                  // print(controller.chatbotTip.value);
                                  // controller.postChatbotMessage();
                                },
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 10.h),
                                  decoration: const BoxDecoration(
                                      color: Color(0xFFDEF7F1)),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        'assets/chatbot.png',
                                        width: 28.w,
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(
                                        '챗봇 이용꿀팁',
                                        style: TextStyle(
                                          color: const Color(0xFF404040),
                                          fontSize: 14.sp,
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
                                width: 30.5.w,
                                height: 3.h,
                              ),
                            ),
                          );
                  }),

                  // 메세지 전송창
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
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
                                width: 280.w,
                                child: TextField(
                                  controller: controller.messageController,
                                  onChanged: (value) {
                                    controller.updateMessage(value);
                                  },
                                  decoration: InputDecoration(
                                    hintText: '메시지를 입력해주세요.',
                                    hintStyle: TextStyle(
                                      color: const Color(0xFFA2A2A2),
                                      fontSize: 16.sp,
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
                                              width: 24.w,
                                            )
                                          : Image.asset(
                                              'assets/send.png',
                                              width: 24.w,
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

// import 'package:economic_fe/view_model/chatbot_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:economic_fe/view/theme/palette.dart';

// class ChatbotPage extends StatefulWidget {
//   const ChatbotPage({super.key});

//   @override
//   State<ChatbotPage> createState() => _ChatbotPageState();
// }

// class _ChatbotPageState extends State<ChatbotPage> {
//   final controller = Get.put(ChatbotController());
//   final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     controller.fetchChatbotMessages();

//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels ==
//               _scrollController.position.maxScrollExtent &&
//           !controller.isLoading.value) {
//         controller.currentPage++;
//         controller.fetchChatbotMessages();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Palette.background,
//       appBar: AppBar(
//         backgroundColor: Palette.background,
//         automaticallyImplyLeading: true,
//         title: const Text('챗봇'),
//         centerTitle: true,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               if (controller.isLoading.value) {
//                 return const Center(child: CircularProgressIndicator());
//               }

//               if (controller.messages.isEmpty) {
//                 return const Center(child: Text("대화 내용이 없습니다."));
//               }

//               // 메시지 추가 시 자동 스크롤
//               WidgetsBinding.instance.addPostFrameCallback((_) {
//                 _scrollController
//                     .jumpTo(_scrollController.position.maxScrollExtent);
//               });

//               return ListView.builder(
//                 controller: _scrollController,
//                 reverse: false, // 오래된 메시지부터 표시
//                 itemCount: controller.messages.length,
//                 itemBuilder: (context, index) {
//                   final message = controller.messages[index];

//                   bool isFirstMessageOfDay = index == 0 ||
//                       controller.formatDate(message.createdAt!) !=
//                           controller.formatDate(
//                               controller.messages[index - 1].createdAt!);

//                   return Padding(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
//                     child: Column(
//                       crossAxisAlignment: message.sender == "USER"
//                           ? CrossAxisAlignment.end
//                           : CrossAxisAlignment.start,
//                       children: [
//                         if (isFirstMessageOfDay)
//                           Center(
//                             child: Padding(
//                               padding: EdgeInsets.only(bottom: 10.h),
//                               child: Text(
//                                 controller.formatDate(message.createdAt!),
//                                 style: TextStyle(
//                                     fontSize: 12.sp, color: Colors.grey),
//                               ),
//                             ),
//                           ),
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             if (message.sender != "USER")
//                               Column(
//                                 children: [
//                                   Container(
//                                     width: 40.w,
//                                     height: 40.h,
//                                     decoration: ShapeDecoration(
//                                       color: Colors.white,
//                                       shape: RoundedRectangleBorder(
//                                         side: const BorderSide(
//                                             width: 0.50,
//                                             color: Color(0xFFA2A2A2)),
//                                         borderRadius: BorderRadius.circular(20),
//                                       ),
//                                     ),
//                                     child: const Icon(Icons.android,
//                                         color: Colors.green),
//                                   ),
//                                   SizedBox(height: 5.h),
//                                   Text('챗봇',
//                                       style: TextStyle(
//                                           fontSize: 12.sp, color: Colors.grey))
//                                 ],
//                               ),
//                             SizedBox(width: 8.w),
//                             Expanded(
//                               child: Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 16.w, vertical: 10.h),
//                                 decoration: ShapeDecoration(
//                                   color: message.sender == "USER"
//                                       ? const Color(0xFF1DB691)
//                                       : const Color(0xFFF2F3F5),
//                                   shape: RoundedRectangleBorder(
//                                     side: const BorderSide(
//                                         width: 0.50, color: Color(0xFFA2A2A2)),
//                                     borderRadius: BorderRadius.circular(12),
//                                   ),
//                                 ),
//                                 child: Text(
//                                   message.message!,
//                                   style: TextStyle(
//                                     color: message.sender == "USER"
//                                         ? Colors.white
//                                         : const Color(0xFF404040),
//                                     fontSize: 16.sp,
//                                     fontWeight: FontWeight.w400,
//                                     height: 1.4,
//                                     letterSpacing: -0.40,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Align(
//                           alignment: message.sender == "USER"
//                               ? Alignment.centerRight
//                               : Alignment.centerLeft,
//                           child: Padding(
//                             padding: EdgeInsets.only(top: 4.h),
//                             child: Text(
//                               controller.formatTime(message.createdAt!),
//                               style: TextStyle(
//                                   fontSize: 12.sp, color: Colors.grey),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   );
//                 },
//               );
//             }),
//           ),
//           _buildMessageInput(),
//         ],
//       ),
//     );
//   }

//   Widget _buildMessageInput() {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 7.h),
//         decoration: ShapeDecoration(
//           color: const Color(0xFFF2F3F5),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(17),
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Obx(() {
//                 return SizedBox(
//                   width: 280.w,
//                   child: TextField(
//                     controller: controller.messageController,
//                     onChanged: (value) {
//                       controller.updateMessage(value);
//                     },
//                     decoration: InputDecoration(
//                       hintText: '메시지를 입력해주세요.',
//                       hintStyle: TextStyle(
//                         color: const Color(0xFFA2A2A2),
//                         fontSize: 16.sp,
//                         fontWeight: FontWeight.w400,
//                         letterSpacing: -0.40,
//                       ),
//                       border: InputBorder.none,
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           controller.postChatbotMessage();
//                           controller.messageController.clear();

//                           // 메시지 전송 후 스크롤 맨 아래로 이동
//                           Future.delayed(const Duration(milliseconds: 300), () {
//                             _scrollController.jumpTo(
//                                 _scrollController.position.maxScrollExtent);
//                           });
//                         },
//                         icon: controller.messageText.value.isNotEmpty
//                             ? Image.asset('assets/send_active.png', width: 24.w)
//                             : Image.asset('assets/send.png', width: 24.w),
//                       ),
//                     ),
//                     maxLines: 5,
//                     minLines: 1,
//                   ),
//                 );
//               }),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
