import 'package:equatable/equatable.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/utils/table_calender/table_calendar_prices.dart';

abstract class EditCalenderEvent extends Equatable {}

class EditCalenderRangeSelectedEvent extends EditCalenderEvent {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final RangeSelectionMode rangeSelectionMode;
  final String startedDay;
  final String endedDay;
  final String startDayWeekName;
  final String endDayWeekName;

  EditCalenderRangeSelectedEvent(this.focusedDay, this.rangeSelectionMode, this.selectedDay, this.rangeStart,
      this.rangeEnd, this.startedDay, this.endedDay, this.startDayWeekName, this.endDayWeekName);

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

class EditCalenderInitDataEvent extends EditCalenderEvent {
  final DateTime focusedDay;
  final List<PriceRange>? priceRanges;
  final PriceRange? editedElement;
  EditCalenderInitDataEvent(this.focusedDay, this.priceRanges, this.editedElement);

  @override
  List<Object?> get props => [focusedDay, priceRanges];
}

class EditCalenderUpdateSpecialPrice extends EditCalenderEvent {
  final String specialPrice;
  EditCalenderUpdateSpecialPrice(this.specialPrice);

  @override
  List<Object?> get props => [specialPrice];
}

class EditCalenderAddSpecialPriceEvent extends EditCalenderEvent {
  @override
  List<Object?> get props => [];
}

class EditCalenderChangeOfferStateEvent extends EditCalenderEvent {
  final bool isOffer;

  EditCalenderChangeOfferStateEvent(this.isOffer);

  @override
  List<Object?> get props => [isOffer];
}

class EditCalenderAddPriceRangeEvent extends EditCalenderEvent {
  final PriceRange priceRange;
  final String unitId;
  final List<PriceRange> priceRanges;

  EditCalenderAddPriceRangeEvent(this.priceRange, this.unitId, this.priceRanges);

  @override
  List<Object?> get props => [priceRange, unitId, priceRanges];
}

class EditCalenderEditPriceRangeEvent extends EditCalenderEvent {
  final PriceRange priceRange;
  final String unitId;
  final List<PriceRange> priceRanges;

  EditCalenderEditPriceRangeEvent(this.priceRange, this.unitId, this.priceRanges);

  @override
  List<Object?> get props => [priceRange, unitId, priceRanges];
}
