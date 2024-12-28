import 'package:economic_fe/utils/screen_utils.dart';
import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_selected.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_button_unselected.dart';
import 'package:economic_fe/view/widgets/profile_setting/profile_setting_app_bar.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JobSelectPage extends StatelessWidget {
  const JobSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final JobSelectController controller = Get.put(JobSelectController());

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

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: ProfileSettingAppBar(
        title: '업종/직무',
        onPress: () {
          controller.navigateToProfileSetting(context);
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: ScreenUtils.getWidth(context, 16),
            ),
            child: Text(
              '업종',
              style: Palette.pretendard(
                context,
                const Color(0xff111111),
                20,
                FontWeight.w500,
                1.5,
                -0.5,
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 17),
          ),
          // 업종 선택 버튼들
          Center(
            child: SizedBox(
              width: ScreenUtils.getWidth(context, 312),
              child: Obx(() {
                return Column(
                  children: [
                    // 첫번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(3, (index) {
                          String job = jobList[index];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // 두번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(3, (index) {
                          String job = jobList[index + 3];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // 세번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(3, (index) {
                          String job = jobList[index + 6];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // 네번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(3, (index) {
                          String job = jobList[index + 9];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // 다섯번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(2, (index) {
                          String job = jobList[index + 12];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                    // 여섯번째 줄
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: ScreenUtils.getHeight(context, 8),
                      ),
                      child: Row(
                        children: List.generate(1, (index) {
                          String job = jobList[index + 14];
                          return Padding(
                            padding: EdgeInsets.only(
                              right: ScreenUtils.getWidth(context, 8),
                            ),
                            child: GestureDetector(
                              onTap: () => controller.selectJob(job),
                              child: controller.selectedJob.value == job
                                  ? ProfileButtonSelected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    )
                                  : ProfileButtonUnselected(
                                      text: job,
                                      paddingWidth: 8,
                                      paddingHeight: 8,
                                      height: 40,
                                      fontSize: 16,
                                    ),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          SizedBox(
            height: ScreenUtils.getHeight(context, 230),
          ),
          // 저장하기 버튼 활성화
          Obx(() {
            bool isButtonEnabled = controller.selectedJob.value != null;
            return isButtonEnabled
                ? Center(
                    child: CustomButton(
                      text: '저장하기',
                      onPress: () {
                        controller.onSaveButtonClicked();
                        controller.navigateToProfileSetting(
                            context); // 프로필 설정 화면으로 이동
                      },
                      bgColor: Palette.buttonColorBlue,
                    ),
                  )
                : Center(
                    child: CustomButtonUnfilled(
                      text: '저장하기',
                      onPress: () {
                        // 저장할 수 없으므로 아무 동작도 하지 않음
                      },
                    ),
                  );
          }),
        ],
      ),
    );
  }
}
