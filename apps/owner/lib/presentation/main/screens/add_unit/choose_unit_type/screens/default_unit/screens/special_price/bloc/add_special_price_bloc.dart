import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/bloc/add_special_price_event.dart';

import 'add_special_price_state.dart';

class AddSpecialPriceBloc extends BaseBloc<AddSpecialPriceEvent, AddSpecialPriceState> {
  AddSpecialPriceBloc() : super(const InitialAddSpecialPriceState()) {
    on<AddPriceRangesListEvent>(_addPriceRangeList);
    on<DeletePriceRangeEvent>(_deletePriceRange);
  }
  FutureOr<void> _addPriceRangeList(AddPriceRangesListEvent event, Emitter<AddSpecialPriceState> emit) {
    if (event.selectedPriceRanges != null && event.selectedPriceRanges!.isNotEmpty) {
      emit(state.copyWith(selectedPriceRanges: event.selectedPriceRanges));
    }
  }

  FutureOr<void> _deletePriceRange(DeletePriceRangeEvent event, Emitter<AddSpecialPriceState> emit) {
    List<PriceRange>? oldList = state.selectedPriceRanges;
    List<PriceRange> newList = PriceRange.createNewListOfPriceRange(oldList);
    newList.removeWhere((element) => element.startDay.toString() == event.priceRange.startDay.toString());
    emit(state.copyWith(selectedPriceRanges: newList));
  }
}
