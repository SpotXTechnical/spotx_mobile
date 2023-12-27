import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/table_calender/table_calendar_prices.dart';

@CopyWith()
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
  final List<PriceRange>? priceRanges;
  final double? price;
  final bool isOffer;
  final String? specialPrice;

  const CalenderState(
      {this.focusedDay,
      this.rangeSelectionMode = RangeSelectionMode.toggledOn,
      this.rangeStartDay,
      this.rangeEndDay,
      this.selectedDay,
      this.startedDay = "-  -  -",
      this.endedDay = "-  -  -",
      this.startDayWeekName = "-  -  -",
      this.endDayWeekName = "-  -  -",
      this.priceRanges,
      this.price,
      this.isOffer = false,
      this.isLoading = false,
      this.specialPrice});
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
        priceRanges,
        price,
        isOffer,
        specialPrice
      ];

  CalenderState copyWith(
      {String? endDayWeekName,
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
      List<PriceRange>? priceRanges,
      bool isOffer = false,
      String? specialPrice}) {
    return CalenderState(
        endDayWeekName: endDayWeekName ?? this.endDayWeekName,
        endedDay: endedDay ?? this.endedDay,
        focusedDay: focusedDay ?? this.focusedDay,
        isLoading: isLoading ?? this.isLoading,
        rangeEndDay: rangeEndDay ?? this.rangeEndDay,
        rangeSelectionMode: rangeSelectionMode ?? this.rangeSelectionMode,
        rangeStartDay: rangeStartDay ?? this.rangeStartDay,
        selectedDay: selectedDay ?? this.selectedDay,
        startDayWeekName: startDayWeekName ?? this.startDayWeekName,
        startedDay: startedDay ?? this.startedDay,
        priceRanges: priceRanges ?? this.priceRanges,
        specialPrice: specialPrice ?? this.specialPrice,
        isOffer: isOffer);
  }
}

class InitialCalenderState extends CalenderState {
  const InitialCalenderState(List<PriceRange> priceRanges) : super(isLoading: false, priceRanges: priceRanges);
}

class CalenderLoadingState extends CalenderState {
  final String? title;
  const CalenderLoadingState({this.title}) : super(isLoading: true);
}
