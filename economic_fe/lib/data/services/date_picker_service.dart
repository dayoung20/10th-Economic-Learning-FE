import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class DatePickerService {
  Future<DateTime?> pickDate(BuildContext context) async {
    DateTime? selectedDate;
    await DatePicker.showDatePicker(
      context,
      locale: LocaleType.ko,
      showTitleActions: true,
      minTime: DateTime(1900),
      maxTime: DateTime(2101),
      currentTime: DateTime.now(),
      onConfirm: (date) {
        selectedDate = date;
      },
    );
    return selectedDate;
  }
}
