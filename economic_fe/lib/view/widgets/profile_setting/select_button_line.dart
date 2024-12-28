import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_selected.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_unselected.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:economic_fe/view_model/profile_setting/part_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectButtonLine extends StatefulWidget {
  final int indexNum;
  final int indexAddNum;
  final String subject;
  final int? partType;

  const SelectButtonLine({
    super.key,
    required this.indexNum,
    required this.indexAddNum,
    required this.subject,
    this.partType,
  });

  @override
  State<SelectButtonLine> createState() => _SelectButtonLineState();
}

class _SelectButtonLineState extends State<SelectButtonLine> {
  // 업종 리스트
  final List<String> jobList = [
    '금융/보험',
    'IT/소프트웨어',
    '전자/반도체',
    '제조업',
    '건설/부동산',
    '의료/제약',
    '교육/출판',
    '유통/물류',
    '에너지/환경',
    '농업/축산업',
    '미디어/광고',
    '여행/관광',
    '공공기관/비영리단체',
    '스타트업/벤처',
    '기타',
  ];

  // 직무 리스트 - 전문직
  final List<String> professionalPartList = [
    '의사/간호사/보건의료',
    '변호사/법무사',
    '회계사/세무사',
    '교사/강사',
    '연구원/교수',
  ];

  // 직무 리스트 - 기업/사무직
  final List<String> officePartList = [
    '기획/전략',
    '마케팅/광고/홍보',
    '영업/판매',
    '재무/회계',
    '인사/교육',
    '고객 서비스/상담',
    '법무/감사',
  ];

  // 직무 리스트 - IT/기술직
  final List<String> professionPartList = [
    '개발자(프론트엔드/백엔드)',
    '데이터 분석/엔지니어',
    'UI/UX 디자이너',
    '네트워크/보안 전문가',
    'IT 관리자',
    '건설/토목/설계',
    '연구개발(R&D)',
  ];

  // 직무 리스트 - 서비스/창업
  final List<String> servicePartList = [
    '외식업/요리사',
    '관광/여행 플래너',
    '창업/스타트업 운영자',
    '프리랜서',
  ];

  // 직무 리스트 - 기타
  final List<String> etcPartList = [
    '공공/행정직 공무원',
    '군인/경찰/소방관',
    '엔터네이너/예술가',
    '기타',
  ];

  // 업종 선택 controller
  final JobSelectController jobController = Get.put(JobSelectController());

  // 직무 선택 controller
  final PartSelectController partController = Get.put(PartSelectController());

  @override
  Widget build(BuildContext context) {
    // 업종인지 직무인지 판단하는 로직 추가
    final bool isJobSelection = widget.subject == 'job';
    final List<String> listToUse =
        isJobSelection ? jobList : _getPartList(widget.partType!);

    return Padding(
      padding: EdgeInsets.only(
        bottom: ScreenUtils.getHeight(context, 8),
      ),
      child: Row(
        children: List.generate(widget.indexNum, (index) {
          String label = listToUse[index + widget.indexAddNum];
          return Padding(
            padding: EdgeInsets.only(
              right: ScreenUtils.getWidth(context, 8),
            ),
            child: GestureDetector(
              onTap: () => isJobSelection
                  ? jobController.selectJob(label)
                  : partController.selectPart(label),
              child: Obx(() {
                return isJobSelection
                    ? (jobController.selectedJob.value == label
                        ? ProfileButtonSelected(
                            text: label,
                            paddingWidth: 8,
                            paddingHeight: 8,
                            height: 40,
                            fontSize: 16,
                          )
                        : ProfileButtonUnselected(
                            text: label,
                            paddingWidth: 8,
                            paddingHeight: 8,
                            height: 40,
                            fontSize: 16,
                          ))
                    : (partController.selectedPart.value == label
                        ? ProfileButtonSelected(
                            text: label,
                            paddingWidth: 8,
                            paddingHeight: 8,
                            height: 40,
                            fontSize: 16,
                          )
                        : ProfileButtonUnselected(
                            text: label,
                            paddingWidth: 8,
                            paddingHeight: 8,
                            height: 40,
                            fontSize: 16,
                          ));
              }),
            ),
          );
        }),
      ),
    );
  }

  // 직무 리스트 선택에 따라 다르게 반환하는 함수
  List<String> _getPartList(int partType) {
    switch (partType) {
      case 1:
        return professionalPartList;
      case 2:
        return officePartList;
      case 3:
        return professionPartList;
      case 4:
        return servicePartList;
      default:
        return etcPartList;
    }
  }
}
