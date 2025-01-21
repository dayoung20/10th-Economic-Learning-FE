import 'package:economic_fe/view_model/learning_set/learning_concept_controller.dart';
import 'package:flutter/material.dart';

class StopOptionModal extends StatelessWidget {
  final Function() closeModal;
  final Function() keepFunc;
  final Function() stopFunc;
  final String contents;
  final String keepBtnText;
  final String stopBtnText;

  const StopOptionModal({
    super.key,
    required this.closeModal,
    required this.contents,
    required this.keepBtnText,
    required this.stopBtnText,
    required this.keepFunc,
    required this.stopFunc,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: closeModal, // 모달창 닫기
        child: Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.black.withOpacity(0.5), // 어두운 배경
          child: GestureDetector(
            onTap: () {}, // 모달창 배경 클릭 방지
            child: DraggableScrollableSheet(
              initialChildSize: 0.2,
              minChildSize: 0.1,
              maxChildSize: 0.3,
              builder: (context, scrollController) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(color: Colors.white),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        contents,
                        style: const TextStyle(
                          color: Color(0xFF111111),
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // 계속할래요 버튼
                          GestureDetector(
                            onTap: keepFunc,
                            child: Container(
                              width: 157,
                              height: 49,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              decoration: ShapeDecoration(
                                color: const Color(0xFFDEF7F7),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  keepBtnText,
                                  style: const TextStyle(
                                    color: Color(0xFF2AD6D6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.38,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          // 그만할래요 버튼
                          GestureDetector(
                            onTap: stopFunc,
                            child: Container(
                              width: 157,
                              height: 49,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 14),
                              decoration: ShapeDecoration(
                                color: const Color(0xFF2AD6D6),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  stopBtnText,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    height: 1.40,
                                    letterSpacing: -0.38,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
