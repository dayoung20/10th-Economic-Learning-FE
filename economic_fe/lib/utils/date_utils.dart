import 'package:intl/intl.dart';

String formatRelativeTime(String isoDate) {
  try {
    final date = DateTime.parse(isoDate).toLocal();
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '방금 전';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}분 전';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}시간 전';
    } else if (difference.inDays == 1) {
      return '어제';
    } else if (difference.inDays <= 7) {
      return '${difference.inDays}일 전';
    } else {
      return DateFormat('yyyy년 M월 d일').format(date);
    }
  } catch (e) {
    return ''; // 또는 fallback 문자열
  }
}
