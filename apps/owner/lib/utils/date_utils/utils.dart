import 'package:flutter/material.dart';
import 'package:owner/utils/style/theme.dart';

Future<DateTime?> getDate(BuildContext context, {DateTime? startDate, DateTime? initialDate}) async {
  var nowDate = DateTime.now();
  var lastDate = DateTime(nowDate.year + 50, nowDate.month, nowDate.day, nowDate.hour, nowDate.minute, nowDate.second);
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      lastDate: lastDate,
      firstDate: startDate ?? DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: datePickerThemeData(context), child: child ?? Container());
      });
  return dateTime;
}

Future<DateTime?> getDateAfterToday(BuildContext context, DateTime startDate) async {
  DateTime now = DateTime.now();
  var lastDate =
      DateTime(startDate.year + 50, startDate.month, startDate.day, startDate.hour, startDate.minute, startDate.second);
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: startDate,
      lastDate: lastDate,
      firstDate: DateTime(now.year, now.month, now.day + 1),
      builder: (BuildContext context, Widget? child) {
        return Theme(data: datePickerThemeData(context), child: child ?? Container());
      });
  return dateTime;
}

bool checkDatesAlignments(DateTime? startDate, DateTime? endDate) {
  if (startDate == null) {
    return false;
  }
  if (endDate == null) {
    return false;
  }
  var atTheSameMoment = endDate.isAtSameMomentAs(startDate);
  var isBefore = endDate.isBefore(startDate);
  return isBefore || atTheSameMoment;
}
