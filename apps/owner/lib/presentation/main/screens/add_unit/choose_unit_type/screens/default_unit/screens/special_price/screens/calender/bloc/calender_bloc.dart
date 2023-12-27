import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/bloc/calender_event.dart';
import 'package:owner/presentation/main/screens/add_unit/choose_unit_type/screens/default_unit/screens/special_price/screens/calender/bloc/calender_state.dart';

class CalenderBloc extends BaseBloc<CalenderEvent, CalenderState> {
  CalenderBloc() : super(InitialCalenderState(List.empty(growable: true))) {
    on<RangeSelectedEvent>(_onRangeSelected);
    on<InitDataEvent>(_addFocusedDay);
    on<ChangeOfferStateEvent>(_changeOffer);
    on<AddSpecialPriceEvent>(_addSpecialPrice);
    on<UpdateSpecialPrice>(_updateSpecialPrice);
  }

  final TextEditingController priceController = TextEditingController();
  final FocusNode priceFocus = FocusNode();

  static final formKey = GlobalKey<FormState>();

  FutureOr<void> _onRangeSelected(RangeSelectedEvent event, Emitter<CalenderState> emit) {
    emit(CalenderState(
      focusedDay: event.focusedDay,
      selectedDay: event.selectedDay,
      rangeStartDay: event.rangeStart,
      rangeEndDay: event.rangeEnd,
      startedDay: event.startedDay,
      startDayWeekName: event.startDayWeekName,
      endedDay: event.endedDay,
      endDayWeekName: event.endDayWeekName,
      priceRanges: state.priceRanges,
    ));
  }

  FutureOr<void> _updateSpecialPrice(UpdateSpecialPrice event, Emitter<CalenderState> emit) {
    emit(state.copyWith(specialPrice: event.specialPrice));
  }

  FutureOr<void> _addFocusedDay(InitDataEvent event, Emitter<CalenderState> emit) {
    if (event.editedElement != null) {
      priceController.text = event.editedElement!.price!;
      priceController.selection = TextSelection.fromPosition(TextPosition(offset: priceController.text.length));
      emit(
        state.copyWith(
            focusedDay: event.editedElement!.startDay!,
            rangeStartDay: event.editedElement!.startDay,
            rangeEndDay: event.editedElement!.endDay,
            priceRanges: event.priceRanges ?? state.priceRanges,
            specialPrice: event.editedElement?.price),
      );
    } else {
      emit(
        state.copyWith(focusedDay: event.focusedDay, priceRanges: event.priceRanges ?? state.priceRanges),
      );
    }
  }

  FutureOr<void> _changeOffer(ChangeOfferStateEvent event, Emitter<CalenderState> emit) {
    emit(
      state.copyWith(isOffer: event.isOffer),
    );
  }

  FutureOr<void> _addSpecialPrice(AddSpecialPriceEvent event, Emitter<CalenderState> emit) {
    List<PriceRange>? oldList = state.priceRanges;
    List<PriceRange> newList = PriceRange.createNewListOfPriceRange(oldList);
    newList.add(PriceRange(
        isOffer: state.isOffer ? 1 : 0,
        startDay: state.rangeStartDay,
        endDay: state.rangeEndDay,
        from: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeStartDay!),
        to: DateFormat('yyyy-MM-dd HH:mm:ss').format(state.rangeEndDay!),
        price: priceController.text));
    emit(
      CalenderState(
          rangeStartDay: null,
          rangeEndDay: null,
          selectedDay: null,
          priceRanges: newList,
          focusedDay: state.focusedDay),
    );
    priceController.clear();
  }
}
