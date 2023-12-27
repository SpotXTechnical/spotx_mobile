// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spotx/presentation/main/screens/home/screens/unit_details/screens/calender/cell_content_animated_container.dart';
import 'package:spotx/utils/table_calender/customization/custom_clipper.dart';

import '../../style/theme.dart';
import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isFirstDayInReservation;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;
  final int price;

  const CellContent(
      {Key? key,
      required this.day,
      required this.focusedDay,
      required this.calendarStyle,
      required this.calendarBuilders,
      required this.isTodayHighlighted,
      required this.isToday,
      required this.isSelected,
      required this.isRangeStart,
      required this.isFirstDayInReservation,
      required this.isRangeEnd,
      required this.isWithinRange,
      required this.isOutside,
      required this.isDisabled,
      required this.isHoliday,
      required this.isWeekend,
      this.locale,
      this.price = 50000})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dowLabel = DateFormat.EEEE(locale).format(day);
    final dayLabel = DateFormat.yMMMMd(locale).format(day);
    final semanticsLabel = '$dowLabel, $dayLabel';

    Widget? cell = calendarBuilders.prioritizedBuilder?.call(context, day, focusedDay);

    if (cell != null) {
      return Semantics(
        label: semanticsLabel,
        excludeSemantics: true,
        child: cell,
      );
    }

    if (isRangeStart) {
      cell = Container(
        color: Theme.of(context).primaryColorLight,
        child: Stack(
          children: [
            ClipPath(
              clipper: isFirstDayInReservation ? CustomTriangleClipper() : null,
              child: Container(
                decoration: BoxDecoration(
                  color: isFirstDayInReservation
                      ? reservedColor.withOpacity(1)
                      : null,
                  border: Border.fromBorderSide(BorderSide(
                      color: Theme.of(context).primaryColorDark, width: .25)),
                ),
              ),
            ),
            calendarBuilders.rangeStartBuilder
                    ?.call(context, day, focusedDay) ??
                CellContentAnimatedContainer(
                    cellDecoration: calendarStyle.rangeStartDecoration ??
                        BoxDecoration(
                            border: Border.fromBorderSide(BorderSide(
                                color: Theme.of(context).primaryColorDark,
                                width: .25))),
                    day: day.day,
                    price: price,
                    textStyle: calendarStyle.rangeStartTextStyle ??
                        const TextStyle(
                            fontFamily: Fonts.CircularStdBook, color: kWhite)),
          ],
        ),
      );
    } else if (isFirstDayInReservation) {
      cell = Container(
        color: isRangeEnd ? Theme.of(context).primaryColorLight : null,
        child: Stack(
          children: [
            ClipPath(
              clipper: CustomTriangleClipper(),
              child: Container(
                decoration: BoxDecoration(
                  color: isRangeEnd ? reservedColor.withOpacity(1) : reservedColor,
                  border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                ),
              ),
            ),
            calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
                CellContentAnimatedContainer(
                    cellDecoration: calendarStyle.rangeStartDecoration ??
                        BoxDecoration(
                          color: Colors.transparent,
                          border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                        ),
                    day: day.day,
                    price: price,
                    textStyle: calendarStyle.rangeStartTextStyle ??
                        const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite)
                ),
          ],
        ),
      );
    } else if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.disabledDecoration ??
                  BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                      color:  reservedColor),
              day: day.day,
              price: price,
              textStyle: calendarStyle.disabledTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isSelected) {
      cell = calendarBuilders.selectedBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.selectedDecoration ??
                  BoxDecoration(
                      color: const Color(0xFF5C6BC0),
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25))),
              day: day.day,
              price: price,
              textStyle: calendarStyle.selectedTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    }else if (isRangeEnd) {
      cell = calendarBuilders.rangeEndBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.rangeEndDecoration ??
                  BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25))),
              day: day.day,
              price: price,
              textStyle: calendarStyle.rangeEndTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isHoliday) {
      cell = calendarBuilders.holidayBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.holidayDecoration ??
                  const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(color: Color(0xFF9FA8DA), width: 1.4),
                    ),
                  ),
              day: day.day,
              price: price,
              textStyle: calendarStyle.holidayTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isWithinRange) {
      cell = calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.withinRangeDecoration ??
                  BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                      color: Theme.of(context).primaryColorLight),
              day: day.day,
              price: price,
              textStyle: calendarStyle.withinRangeTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isOutside) {
      cell = calendarBuilders.outsideBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.outsideDecoration ??
                  BoxDecoration(
                      color: Theme.of(context).unselectedWidgetColor,
                      border: Border.fromBorderSide(
                        BorderSide(color: Theme.of(context).primaryColorDark, width: .25),
                      )),
              day: day.day,
              price: price,
              textStyle: calendarStyle.outsideTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else {
      cell = calendarBuilders.defaultBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: isWeekend
                  ? calendarStyle.weekendDecoration ??
                      BoxDecoration(
                          border:
                              Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)))
                  : calendarStyle.defaultDecoration ??
                      BoxDecoration(
                          border: Border.all(color: Theme.of(context).primaryColorDark, width: .25),
                          color: Theme.of(context).unselectedWidgetColor),
              day: day.day,
              price: price,
              textStyle: isWeekend
                  ? calendarStyle.weekendTextStyle ??
                      const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite)
                  : calendarStyle.defaultTextStyle ??
                      const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    }

    return Semantics(
      label: semanticsLabel,
      excludeSemantics: true,
      child: cell,
    );
  }
}