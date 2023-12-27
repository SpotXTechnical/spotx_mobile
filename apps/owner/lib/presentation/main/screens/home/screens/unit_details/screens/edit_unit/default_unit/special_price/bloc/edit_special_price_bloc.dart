import 'dart:async';
import 'dart:collection';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:owner/base/base_bloc.dart';
import 'package:owner/data/remote/add_unit/model/range.dart';
import 'package:owner/data/remote/price_range/i_price_range_repository.dart';
import 'package:owner/generated/locale_keys.g.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/bloc/edit_special_price_event.dart';
import 'package:owner/presentation/main/screens/home/screens/unit_details/screens/edit_unit/default_unit/special_price/bloc/edit_special_price_state.dart';
import 'package:owner/utils/network/api_response.dart';
import 'package:owner/utils/style/theme.dart';

class EditSpecialPriceBloc extends BaseBloc<EditSpecialPriceEvent, EditSpecialPriceState> {
  EditSpecialPriceBloc(this.priceRangeRepository) : super(const InitialAddSpecialPriceState()) {
    on<AddPriceRangesListEvent>(_addPriceRangeList);
    on<DeletePriceRangeEvent>(_deletePriceRange);
  }

  final IPriceRangeRepository priceRangeRepository;
  FutureOr<void> _addPriceRangeList(AddPriceRangesListEvent event, Emitter<EditSpecialPriceState> emit) {
    if (event.selectedPriceRanges != null && event.selectedPriceRanges!.isNotEmpty) {
      emit(state.copyWith(selectedPriceRanges: event.selectedPriceRanges));
    }
  }

  Future<FutureOr<void>> _deletePriceRange(DeletePriceRangeEvent event, Emitter<EditSpecialPriceState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await priceRangeRepository.deletePriceRange(event.priceRange.id!);

    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            Fluttertoast.showToast(
                msg: LocaleKeys.priceRangeDeletedSuccessfully.tr(),
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: pacificBlue,
                textColor: kWhite);
            List<PriceRange>? oldList = state.selectedPriceRanges;
            List<PriceRange> newList = PriceRange.createNewListOfPriceRange(oldList);
            newList.removeWhere((element) => element.startDay.toString() == event.priceRange.startDay.toString());
            emit(state.copyWith(selectedPriceRanges: newList, isLoading: false));
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
}