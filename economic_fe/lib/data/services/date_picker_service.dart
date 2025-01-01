import 'package:flutter/material.dart';

class DatePickerService {
  // 날짜 선택 다이얼로그 표시
  Future<DateTime?> pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    return picked;
  }
}
