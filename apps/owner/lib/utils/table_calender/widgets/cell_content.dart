// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:owner/utils/style/theme.dart';
import 'package:owner/utils/table_calender/widgets/cell_content_animated_container.dart';

import '../customization/calendar_builders.dart';
import '../customization/calendar_style.dart';

const _radiusValue = 16.0;
const _radius = Radius.circular(_radiusValue);
final _oneDayReservationBorderRadius = BorderRadius.circular(_radiusValue);
const _firstDayBorderRadius = BorderRadiusDirectional.only(
  topStart: _radius,
  bottomStart: _radius,
);
const _lastDayBorderRadius = BorderRadiusDirectional.only(
  topEnd: _radius,
  bottomEnd: _radius,
);

class CellContent extends StatelessWidget {
  final DateTime day;
  final DateTime focusedDay;
  final dynamic locale;
  final bool isTodayHighlighted;
  final bool isToday;
  final bool isSelected;
  final bool isRangeStart;
  final bool isRangeEnd;
  final bool isWithinRange;
  final bool isOutside;
  final bool isDisabled;
  final bool isHoliday;
  final bool isWeekend;
  final bool isReservedByCustomer;
  final bool isReservedByGuest;
  final bool isPending;
  final bool isReservedDayInPast;
  final bool isFirstDayInReservation;
  final bool isLastDayInReservation;
  final CalendarStyle calendarStyle;
  final CalendarBuilders calendarBuilders;
  final String price;

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
      required this.isRangeEnd,
      required this.isWithinRange,
      required this.isOutside,
      required this.isDisabled,
      required this.isHoliday,
      required this.isWeekend,
      required this.isReservedByCustomer,
      this.isReservedDayInPast = false,
      this.isReservedByGuest = false,
      this.isFirstDayInReservation = false,
      this.isLastDayInReservation = false,
      required this.isPending,
      this.locale,
      this.price = ""})
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

    final boxDecorations = BoxDecoration(
      borderRadius: isFirstDayInReservation && isLastDayInReservation
          ? _oneDayReservationBorderRadius
          : isFirstDayInReservation
              ? _firstDayBorderRadius
              : isLastDayInReservation
                  ? _lastDayBorderRadius
                  : BorderRadius.zero,
      color: Theme.of(context).primaryColorLight,
    );

    if (isReservedByCustomer || isReservedByGuest) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              hasEndSpace: isLastDayInReservation && !isReservedByGuest,
              hasStartSpace: isFirstDayInReservation && !isReservedByGuest,
              isReserved: isReservedByCustomer,
              cellDecoration: calendarStyle.reservedDecoration ??
                  (isReservedByCustomer
                      ? boxDecorations
                      : BoxDecoration(
                          border: Border.fromBorderSide(BorderSide(
                              color: Theme.of(context).primaryColorDark,
                              width: .25)),
                          color: reservedGuestColor)),
              day: day.day,
              price: isReservedByGuest ? "-----" :price,
              textStyle: calendarStyle.disabledTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isReservedDayInPast) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              hasEndSpace: isLastDayInReservation && !isReservedByGuest,
              hasStartSpace: isFirstDayInReservation && !isReservedByGuest,
              isReserved: true,
              cellDecoration:
                  calendarStyle.reservedDecoration ?? boxDecorations,
              day: day.day,
              price: isReservedByGuest ? "-----" :price,
              textStyle: calendarStyle.disabledTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isPending) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.pendingDecoration ??
                  BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                      color: Theme.of(context).selectedRowColor),
              day: day.day,
              price: price,
              textStyle: calendarStyle.disabledTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isDisabled) {
      cell = calendarBuilders.disabledBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.disabledDecoration ??
                  BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25)),
                      color: Theme.of(context).unselectedWidgetColor),
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
    } else if (isRangeStart) {
      cell = calendarBuilders.rangeStartBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.rangeStartDecoration ??
                  BoxDecoration(
                      color: Theme.of(context).primaryColorLight,
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25))),
              day: day.day,
              price: price,
              textStyle: calendarStyle.rangeStartTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isRangeEnd) {
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
              cellDecoration: calendarStyle.holidayDecoration,
              day: day.day,
              price: price,
              textStyle: calendarStyle.holidayTextStyle ??
                  const TextStyle(fontFamily: Fonts.CircularStdBook, color: kWhite));
    } else if (isWithinRange) {
      cell = calendarBuilders.withinRangeBuilder?.call(context, day, focusedDay) ??
          CellContentAnimatedContainer(
              cellDecoration: calendarStyle.withinRangeDecoration ??
                  BoxDecoration(
                      border: Border.fromBorderSide(BorderSide(color: Theme.of(context).primaryColorDark, width: .25))),
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