import 'package:equatable/equatable.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/model/CalenderUnit.dart';
import 'package:spotx/utils/table_calender/table_calendar.dart';

class CalenderState extends Equatable {
  final DateTime? focusedDay;
  final RangeSelectionMode rangeSelectionMode;
  final DateTime? rangeStartDay;
  final DateTime? rangeEndDay;
  final DateTime? selectedDay;
  final String startedDay;
  final String endedDay;
  final String startDayWeekName;
  final String endDayWeekName;
  final bool isLoading;
  final bool? isReservationCompleted;
  final CalenderUnit? calenderUnit;
  final String? roomTitle;
  final String? roomId;
  final RequestStatus roomRequestStatus;

  const CalenderState(
      {this.focusedDay,
      this.calenderUnit,
      this.isReservationCompleted,
      this.rangeSelectionMode = RangeSelectionMode.toggledOn,
      this.rangeStartDay,
      this.rangeEndDay,
      this.selectedDay,
      this.startedDay = "-  -  -",
      this.endedDay = "-  -  -",
      this.startDayWeekName = "-  -  -",
      this.endDayWeekName = "-  -  -",
      this.roomTitle,
      this.roomId,
      this.roomRequestStatus = RequestStatus.loading,
      required this.isLoading});
  @override
  List<Object?> get props => [
        focusedDay,
        rangeSelectionMode,
        rangeStartDay,
        rangeEndDay,
        selectedDay,
        startedDay,
        endedDay,
        startDayWeekName,
        endDayWeekName,
        calenderUnit,
        roomTitle,
        isReservationCompleted,
        roomId,
        isLoading,
        roomRequestStatus
      ];

  CalenderState copyWith(
      {CalenderUnit? calenderUnit,
      String? endDayWeekName,
      String? endedDay,
      DateTime? focusedDay,
      bool? isLoading,
      bool? isReservationCompleted,
      DateTime? rangeEndDay,
      RangeSelectionMode? rangeSelectionMode,
      DateTime? rangeStartDay,
      String? roomTitle,
      DateTime? selectedDay,
      String? startDayWeekName,
      String? startedDay,
      String? roomId,
      RequestStatus? roomRequestStatus}) {
    return CalenderState(
        calenderUnit: calenderUnit ?? this.calenderUnit,
        endDayWeekName: endDayWeekName ?? this.endDayWeekName,
        endedDay: endedDay ?? this.endedDay,
        focusedDay: focusedDay ?? this.focusedDay,
        isLoading: isLoading ?? this.isLoading,
        isReservationCompleted: isReservationCompleted ?? this.isReservationCompleted,
        rangeEndDay: rangeEndDay ?? this.rangeEndDay,
        rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
        rangeStartDay: rangeStartDay ?? this.rangeStartDay,
        roomTitle: roomTitle ?? this.roomTitle,
        selectedDay: selectedDay ?? this.selectedDay,
        startDayWeekName: startDayWeekName ?? this.startDayWeekName,
        startedDay: startedDay ?? this.startedDay,
        roomId: roomId ?? this.roomId,
        roomRequestStatus: roomRequestStatus ?? this.roomRequestStatus);
  }
}

class InitialCalenderState extends CalenderState {
  const InitialCalenderState(DateTime focusedDay) : super(isLoading: false, focusedDay: focusedDay);
}
