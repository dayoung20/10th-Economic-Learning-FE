import 'package:economic_fe/view/theme/palette.dart';
import 'package:economic_fe/view/widgets/custom_button.dart';
import 'package:economic_fe/view/widgets/custom_button_unfilled.dart';
import 'package:economic_fe/view/widgets/custom_app_bar.dart';
import 'package:economic_fe/view/widgets/profile_setting/select_button_line.dart';
import 'package:economic_fe/view_model/profile_setting/job_select_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class JobSelectPage extends StatelessWidget {
  const JobSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // GetX 컨트롤러 가져오기
    final JobSelectController controller = Get.put(JobSelectController());

    return Scaffold(
      backgroundColor: Palette.background,
      appBar: CustomAppBar(
        title: '업종/직무',
        onPress: () {
          controller.navigateToProfileSetting();
        },
        icon: Icons.close,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Text(
              '업종',
              style: Palette.pretendard(
                context,
                const Color(0xff111111),
                20.sp,
                FontWeight.w500,
                1.5,
                -0.5,
              ),
            ),
          ),
          SizedBox(height: 17.h),
          // 업종 선택 버튼들
          Center(
            child: SizedBox(
              width: 312.w,
              child: const Column(
                children: [
                  // 첫번째 줄
                  SelectButtonLine(
                    indexNum: 3,
                    indexAddNum: 0,
                    subject: 'job',
                  ),
                  // 두번째 줄
                  SelectButtonLine(
                    indexNum: 3,
                    indexAddNum: 3,
                    subject: 'job',
                  ),
                  // 세번째 줄
                  SelectButtonLine(
                    indexNum: 3,
                    indexAddNum: 6,
                    subject: 'job',
                  ),
                  // 네번째 줄
                  SelectButtonLine(
                    indexNum: 3,
                    indexAddNum: 9,
                    subject: 'job',
                  ),
                  // 다섯번째 줄
                  SelectButtonLine(
                    indexNum: 2,
                    indexAddNum: 12,
                    subject: 'job',
                  ),
                  // 여섯번째 줄
                  SelectButtonLine(
                    indexNum: 1,
                    indexAddNum: 14,
                    subject: 'job',
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 200.h,
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
                        controller.navigateToProfileSetting(); // 프로필 설정 화면으로 이동
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
