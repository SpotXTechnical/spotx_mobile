import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/utils/table_calender/table_calendar.dart';

abstract class CalenderEvent extends Equatable {}

class DayTappedEvent extends CalenderEvent {
  final DateTime focusedDay;
  final DateTime selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode rangeSelectionMode;

  DayTappedEvent(this.focusedDay, this.rangeSelectionMode, this.selectedDay, this.rangeStart, this.rangeEnd);

  @override
  List<Object?> get props => [focusedDay, rangeSelectionMode, selectedDay, rangeStart, rangeEnd];
}

class RangeSelectedEvent extends CalenderEvent {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode rangeSelectionMode;
  final String startedDay;
  final String endedDay;
  final String startDayWeekName;
  final String endDayWeekName;

  RangeSelectedEvent(this.focusedDay, this.rangeSelectionMode, this.selectedDay, this.rangeStart, this.rangeEnd,
      this.startedDay, this.endedDay, this.startDayWeekName, this.endDayWeekName);

  @override
  List<Object?> get props => [
        focusedDay,
        rangeSelectionMode,
        selectedDay,
        rangeStart,
        rangeEnd,
        startedDay,
        endedDay,
        startDayWeekName,
        endDayWeekName
      ];
}

class InitDataEvent extends CalenderEvent {
  final DateTime focusedDay;
  final CalenderUnit? calenderUnit;

  InitDataEvent(this.focusedDay, this.calenderUnit);

  @override
  List<Object?> get props => [focusedDay, calenderUnit];
}

class PostReservation extends CalenderEvent {
  final String from;
  final String to;
  final int unitId;
  final String unitType;

  PostReservation(this.from, this.to, this.unitId, this.unitType);

  @override
  List<Object?> get props => [from, to, unitType, unitId];
}

class GetRoomDetailsEvent extends CalenderEvent {
  final String type;
  final int roomId;
  final String title;

  GetRoomDetailsEvent(this.type, this.roomId, this.title);

  @override
  List<Object?> get props => [type, roomId, title];
}
