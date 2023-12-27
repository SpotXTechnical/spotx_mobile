import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/utils/network/api_response.dart';

import '../../unit_details/bloc/unit_details_state.dart';
import 'Camp_details_state.dart';
import 'camp_details_event.dart';

class CampDetailsBloc extends BaseBloc<CampDetailsEvent, CampDetailsState> {
  CampDetailsBloc(this.unitRepository) : super(const CampDetailsState()) {
    on<GetCampDetails>(_getCampDetails);
    on<ChangeContentType>(_changeContentType);
  }
  final IUnitRepository unitRepository;

  FutureOr<void> _getCampDetails(GetCampDetails event, Emitter<CampDetailsState> emit) async {
    emit(state.copyWith(isLoading: true));
    ApiResponse apiResponse = await unitRepository.getUnitById(event.id.toString());
    await handleResponse(
        result: apiResponse,
        onSuccess: () {
          Unit unitData = apiResponse.data.data;
          emit(state.copyWith(isLoading: false, unit: unitData));
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(state.copyWith(isLoading: false));
          }
        });
  }

  FutureOr<void> _changeContentType(ChangeContentType event, Emitter<CampDetailsState> emit) async {
    if (state.selectedContentType == SelectedContentType.review) {
      emit(state.copyWith(selectedContentType: SelectedContentType.overView));
    } else {
      emit(state.copyWith(selectedContentType: SelectedContentType.review));
    }
  }
}
