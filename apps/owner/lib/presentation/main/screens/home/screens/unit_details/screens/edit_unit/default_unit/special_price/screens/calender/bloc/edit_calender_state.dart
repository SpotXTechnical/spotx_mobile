import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/table_calender/table_calendar_prices.dart';

class EditCalenderState extends Equatable {
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

  const EditCalenderState(
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
        specialPrice,
        isLoading
      ];

  EditCalenderState copyWith(
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
    return EditCalenderState(
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

class InitialEditCalenderState extends EditCalenderState {
  const InitialEditCalenderState(List<PriceRange> priceRanges) : super(isLoading: false, priceRanges: priceRanges);
}
