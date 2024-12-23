import 'package:economic_fe/view/theme/palette.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.background,
      body: Center(
          child: Column(
        children: [
          Stack(
            children: [
              Container(
                  width: 280,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: const Color(0xff2ad6d6))),
              const Text("레벨테스트 시작하기",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ],
          ),
          const Text("나중에 할래요",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          Column(
            children: [
              Container(
                  width: 134,
                  height: 5,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color(0xff111111)))
            ],
          ),
          const Text("학습 수준을 정확히 파악할 수 있도록   간단한 테스트를 준비했습니다.   함께 시작해볼까요?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              )),
          const Column(
            children: [
              Text("경제 학습의 첫걸음, ",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  )),
              Row(
                children: [
                  Text("나의 레벨은?",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      )),
                  Row(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 26.9999942779541,
                            height: 17.39922523498535,
                          ),
                          SizedBox(
                            width: 26.9999942779541,
                            height: 17.403461456298828,
                          )
                        ],
                      )
                    ],
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              Row(
                children: [
                  const Row(
                    children: [
                      Text("9:30",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ))
                    ],
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/signal.png",
                                width: 14.666666984558105,
                                height: 10.373332977294922,
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                "assets/Vector.png",
                                width: 13.333333969116211,
                                height: 13.333333969116211,
                              )
                            ],
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                "assets/Base.png",
                                width: 8.5,
                                height: 14.166665077209473,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: const Color(0xff111111)))
                    ],
                  )
                ],
              )
            ],
          )
        ],
      )),
    );
  }
}
