import 'dart:async';
import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/price_range/i_price_range_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/bloc/edit_calender_event.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/screens/calender/bloc/edit_calender_state.dart';
import 'package:owner/utils/navigation/navigation_helper.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';

class EditCalenderBloc extends BaseBloc<EditCalenderEvent, EditCalenderState> {
  EditCalenderBloc(this.priceRangeRepository) : super(InitialEditCalenderState(List.empty(growable: true))) {
    on<EditCalenderRangeSelectedEvent>(_onRangeSelected);
    on<EditCalenderInitDataEvent>(_addFocusedDay);
    on<EditCalenderChangeOfferStateEvent>(_changeOffer);
    on<EditCalenderAddSpecialPriceEvent>(_addSpecialPrice);
    on<EditCalenderUpdateSpecialPrice>(_updateSpecialPrice);
    on<EditCalenderAddPriceRangeEvent>(_addPriceRange);
    on<EditCalenderEditPriceRangeEvent>(_updatePriceRange);
  }

  final TextEditingController priceController = TextEditingController();
  final FocusNode priceFocus = FocusNode();
  final IPriceRangeRepository priceRangeRepository;

  static final formKey = GlobalKey<FormState>();

  FutureOr<void> _onRangeSelected(EditCalenderRangeSelectedEvent event, Emitter<EditCalenderState> emit) {
    emit(EditCalenderState(
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

  FutureOr<void> _updateSpecialPrice(EditCalenderUpdateSpecialPrice event, Emitter<EditCalenderState> emit) {
    emit(state.copyWith(specialPrice: event.specialPrice));
  }

  FutureOr<void> _addFocusedDay(EditCalenderInitDataEvent event, Emitter<EditCalenderState> emit) {
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

  FutureOr<void> _changeOffer(EditCalenderChangeOfferStateEvent event, Emitter<EditCalenderState> emit) {
    emit(
      state.copyWith(isOffer: event.isOffer),
    );
  }

  _addPriceRange(EditCalenderAddPriceRangeEvent event, Emitter<EditCalenderState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await priceRangeRepository.postPriceRange(event.priceRange, event.unitId);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.priceRangeAddedSuccessfully.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop(event.priceRanges);
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            try {
              LinkedHashMap<String, dynamic> errorMessage = apiResponse.error?.extra as LinkedHashMap<String, dynamic>;
              var range = errorMessage["range"] as List<dynamic>;
              showErrorMsg(range.first);
            } catch (r) {
              showErrorMsg(LocaleKeys.error.tr());
            }
          }
        });
  }

  _updatePriceRange(EditCalenderEditPriceRangeEvent event, Emitter<EditCalenderState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await priceRangeRepository.updatePriceRange(event.priceRange, event.unitId);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            emit(state.copyWith(isLoading: false));
            Fluttertoast.showToast(
                msg: LocaleKeys.priceRangeUpdatedSuccessfully.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            navigationKey.currentState?.pop(event.priceRanges);
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
            try {
              LinkedHashMap<String, dynamic> errorMessage = apiResponse.error?.extra as LinkedHashMap<String, dynamic>;
              var range = errorMessage["range"] as List<dynamic>;
              showErrorMsg(range.first);
            } catch (r) {
              showErrorMsg(LocaleKeys.error.tr());
            }
          }
        });
  }

  FutureOr<void> _addSpecialPrice(EditCalenderAddSpecialPriceEvent event, Emitter<EditCalenderState> emit) {
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
      EditCalenderState(
          priceRanges: newList,
          focusedDay: state.focusedDay),
    );
    priceController.clear();
  }
}