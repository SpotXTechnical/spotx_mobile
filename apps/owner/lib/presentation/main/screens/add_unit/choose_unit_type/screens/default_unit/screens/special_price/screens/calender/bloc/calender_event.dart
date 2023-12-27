import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/table_calender/table_calendar_prices.dart';

abstract class CalenderEvent extends Equatable {}

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
  final List<PriceRange>? priceRanges;
  final PriceRange? editedElement;
  InitDataEvent(this.focusedDay, this.priceRanges, this.editedElement);

  @override
  List<Object?> get props => [focusedDay, priceRanges];
}

class UpdateSpecialPrice extends CalenderEvent {
  final String specialPrice;
  UpdateSpecialPrice(this.specialPrice);

  @override
  List<Object?> get props => [specialPrice];
}

class AddSpecialPriceEvent extends CalenderEvent {
  @override
  List<Object?> get props => [];
}

class ChangeOfferStateEvent extends CalenderEvent {
  final bool isOffer;

  ChangeOfferStateEvent(this.isOffer);

  @override
  List<Object?> get props => [isOffer];
}
