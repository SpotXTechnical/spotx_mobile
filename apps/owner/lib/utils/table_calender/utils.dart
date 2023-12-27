// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/utils/table_calender/shared/utils.dart';

/// Example event class.
class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(50, (index) => index))
    DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5):
        List.generate(item % 4 + 1, (index) => Event('Event $item | ${index + 1}'))
}..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = kToday;
final kYearBeforeNowDay = DateTime(kToday.year - 1, kToday.month, kToday.day);
final kLastDay = DateTime(kToday.year + 1, kToday.month, kToday.day);
const List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];

String calculateTimeDifferenceFromNow(DateTime date) {
  var duration = DateTime.now().difference(date);
  if (duration.inSeconds >= 60) {
    if (duration.inMinutes >= 60) {
      if (duration.inHours >= 24) {
        if (duration.inDays >= 30) {
          if (duration.inDays >= 365) {
            var years = duration.inDays ~/ 365;
            var text = "";
            if (years == 1) {
              text = LocaleKeys.year.tr();
            } else {
              text = LocaleKeys.years.tr();
            }
            return "$years" " " + text;
          } else {
            var months = duration.inDays ~/ 30.417;
            var text = "";
            if (months == 1) {
              text = LocaleKeys.month.tr();
            } else {
              text = LocaleKeys.months.tr();
            }
            return "$months" " " + text;
          }
        } else {
          var days = duration.inDays;
          var text = "";
          if (days == 1) {
            text = LocaleKeys.day.tr();
          } else {
            text = LocaleKeys.days.tr();
          }
          return "$days" " " + text;
        }
      } else {
        var hours = duration.inHours;
        var text = "";
        if (hours == 1) {
          text = LocaleKeys.hour.tr();
        } else {
          text = LocaleKeys.hours.tr();
        }
        return "$hours" " " + text;
      }
    } else {
      var minutes = duration.inMinutes;
      var text = "";
      if (minutes == 1) {
        text = LocaleKeys.minute.tr();
      } else {
        text = LocaleKeys.minutes.tr();
      }
      return "$minutes" " " + text;
    }
  } else {
    var seconds = duration.inSeconds;
    var text = "";
    if (seconds == 1) {
      text = LocaleKeys.second.tr();
    } else {
      text = LocaleKeys.seconds.tr();
    }
    return "$seconds" " " + text;
  }
}
