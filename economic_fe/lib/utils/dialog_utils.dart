import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DialogUtils {
  /// 로그아웃 또는 회원탈퇴 확인 다이얼로그
  static void showLogoutOrWithdrawDialog({
    required BuildContext context,
    required String type, // 'logout' 또는 'withdraw'
    required VoidCallback onConfirm,
  }) {
    final bool isLogout = type == 'logout';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.r),
          ),
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          content: SizedBox(
            width: 312.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isLogout ? "로그아웃 하시겠습니까?" : "정말 탈퇴하시겠습니까?",
                  style: TextStyle(
                    color: const Color(0xFF111111),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    height: 1.40,
                    letterSpacing: -0.40,
                  ),
                ),
                if (!isLogout) ...[
                  SizedBox(height: 12.h),
                  Text(
                    "탈퇴 시 학습 내역과 커뮤니티 활동 내역이 모두 삭제되며, 이후 복구가 불가능합니다.",
                    style: TextStyle(
                      color: const Color(0xFF111111),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      height: 1.5,
                      letterSpacing: -0.40,
                    ),
                  ),
                ],
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Text(
                        isLogout ? "아니요" : "취소",
                        style: TextStyle(
                          color: const Color(0xFF9B9A99),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          height: 1.40,
                          letterSpacing: -0.40,
                        ),
                      ),
                    ),
                    SizedBox(width: 32.w),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      child: Text(
                        isLogout ? '로그아웃 하기' : '탈퇴',
                        style: TextStyle(
                          color: const Color(0xFF2AD6D6),
                          fontSize: 16.sp,
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
      },
    );
  }
}
