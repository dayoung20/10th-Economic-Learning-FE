import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:economic_fe/view_model/login/agreement_controller.dart';
import 'package:get/get.dart';

class AgreementDetailPage extends StatefulWidget {
  const AgreementDetailPage({super.key});

  @override
  State<AgreementDetailPage> createState() => _AgreementDetailPageState();
}

class _AgreementDetailPageState extends State<AgreementDetailPage> {
  late final AgreementController controller;
  @override
  void initState() {
    super.initState();
    controller = Get.put(AgreementController()..getStats());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: "서비스 이용 약관",
        icon: Icons.close,
        onPress: () {
          Navigator.pop(context);
        },
        titleStyle: const TextStyle(
          color: Color(0xFF111111),
          fontFamily: 'Pretendard Variable',
          fontSize: 20.0,
          fontStyle: FontStyle.normal,
          fontWeight: FontWeight.w500,
          height: 1.3,
          letterSpacing: -0.5,
        ),
      ),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SizedBox(
              child: SingleChildScrollView(
                // 이 부분 추가
                // padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 23,
                          ),
                          Text(
                            "1. 총칙",
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontFamily: 'Pretendard Variable',
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: Text(
                              "1. 이 약관은 Ripple : 처음 시작하는 경제 학습 (이하 “리플”)와 관련하여 회사(리플)가 제공하는 서비스의 이용과 관련된 권리, 의무 및 책임 사항을 규정합니다.\n2.이용자는 본 약관에 동의함으로써 서비스를 이용할 수 있습니다.",
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontFamily: 'Pretendard Variable',
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "2. 회원 가입 및 계정 관리",
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontFamily: 'Pretendard Variable',
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: Text(
                              "1. 회원은 카카오톡 계정을 통해 간편하게 로그인하여 서비스를 이용할 수 있습니다.\n2. 회원 가입 시 제공되는 개인 정보는 서비스 제공 및 운영에 사용되며, 개인정보 처리방침에 따라 안전하게 관리됩니다.\n3. 카카오톡 계정을 사용하여 로그인한 경우, 해당 계정에 연결된 정보(이름, 이메일 등)를 기반으로 회원 관리가 이루어집니다.",
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontFamily: 'Pretendard Variable',
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "3. 서비스 이용",
                            style: TextStyle(
                              color: Color(0xFF111111),
                              fontFamily: 'Pretendard Variable',
                              fontSize: 16.0,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w600,
                              height: 1.4,
                              letterSpacing: -0.4,
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 14),
                            child: Text(
                              "1. 서비스는 경제 학습 콘텐츠 제공, 커뮤니티 운영 및 경제 기사 큐레이션 등의 기능을 포함합니다. \n2. 회원은 서비스 내 제공된 콘텐츠를 개인적 용도로만 사용할 수 있으며, 상업적 이용은 금지됩니다. \n서비스 이용 중 발생하는 데이터 요금은 이용자의 책임이며, 서비스는 최상의 이용 환경을 제공하기 위해 노력합니다.",
                              style: TextStyle(
                                color: Color(0xFF111111),
                                fontFamily: 'Pretendard Variable',
                                fontSize: 14.0,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w400,
                                height: 1.4,
                                letterSpacing: -0.35,
                              ),
                            ),
                          ),
                          // ElevatedButton(
                          //   onPressed: () {
                          //     // 버튼 클릭 시 실행할 로직
                          //     print("동의합니다 버튼 클릭됨");
                          //   },
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: const Color(0xFF2BD6D6), // 버튼 배경색
                          //     minimumSize: const Size(
                          //         double.infinity, 50), // 버튼 크기 (가로: 전체, 세로: 50)
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius:
                          //           BorderRadius.circular(0), // 모서리를 둥글게 하지 않음
                          //     ),
                          //   ),
                          //   child: const Text(
                          //     "동의합니다",
                          //     style: TextStyle(
                          //       color: Colors.white, // 텍스트 색상
                          //       fontFamily: 'Pretendard Variable', // Pretendard 폰트
                          //       fontSize: 16.0, // 텍스트 크기
                          //       fontWeight: FontWeight.w600, // 텍스트 굵기
                          //       height: 1.4, // 줄 간격
                          //       letterSpacing: -0.4, // 글자 간격
                          //     ),
                          //   ),
                          // ),
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
            child: ElevatedButton(
              onPressed: () {
                controller.isCheckedOne.value = true;
                print(controller.isCheckedOne.value);
                Navigator.pop(context);
                // controller.clickedAllowBtn(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2BD6D6),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
              child: const Text(
                "동의합니다",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Pretendard Variable',
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  height: 1.4,
                  letterSpacing: -0.4,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
