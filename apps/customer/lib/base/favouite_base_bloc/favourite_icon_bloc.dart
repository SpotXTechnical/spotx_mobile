import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/base/favouite_base_bloc/favourtie_icon_event.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'favourite_icon_state.dart';

class FavouriteIconBloc extends BaseBloc<FavouriteIconEvent, FavouriteIconState> implements FavouriteListObserver {
  FavouriteIconBloc(this.unitRepository, this.unit) : super(FavouriteIconUnitState(Unit.createNewUnitObject(unit))) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<AddToFavouriteEvent>(_addToFavourite);
    on<RemoveFromFavouriteEvent>(_removeFromFavourite);
    on<UpdateFavouriteUnitEvent>(_updateFavouriteUnitState);
  }

  final IUnitRepository unitRepository;
  final Unit unit;

  _updateFavouriteUnitState(UpdateFavouriteUnitEvent event, Emitter<FavouriteIconState> emit) async {
    emit(FavouriteIconUnitState(event.unit));
  }

  _addToFavourite(AddToFavouriteEvent event, Emitter<FavouriteIconState> emit) async {
    Unit newUnit = Unit.createNewUnitObject(state.unit);
    newUnit.uiIsFavourite = true;
    emit((FavouriteIconUnitState(newUnit)));
    if (!newUnit.isFavouriteLoading) {
      var newUnit = Unit.createNewUnitObject(state.unit);
      newUnit.isFavouriteLoading = true;
      emit((FavouriteIconUnitState(newUnit)));
      ApiResponse apiResponse = await unitRepository.addToFavourite(newUnit.id!);
      await handleResponse(
          result: apiResponse,
          onSuccess: () async {
            Unit newUnit = Unit.createNewUnitObject(state.unit);
            newUnit.isFavouriteLoading = false;
            emit((FavouriteIconUnitState(newUnit)));
            if (!newUnit.uiIsFavourite!) {
              add(RemoveFromFavouriteEvent());
            } else {
              unit.uiIsFavourite = true;
              unit.isFavourite = true;
              unit.isFavouriteLoading = false;
              FavouriteUnitsSingleTone().addToList(unit.id!);
            }
          },
          onFailed: () {
            Unit newUnit =Unit.createNewUnitObject(state.unit);
            newUnit.isFavouriteLoading = false;
            emit((FavouriteIconUnitState(newUnit)));
          });
    }
  }

  _removeFromFavourite(RemoveFromFavouriteEvent event, Emitter<FavouriteIconState> emit) async {
    Unit newUnit = Unit.createNewUnitObject(state.unit);
    newUnit.uiIsFavourite = false;
    emit((FavouriteIconUnitState(newUnit)));

    if (!newUnit.isFavouriteLoading) {
      var newUnit = Unit.createNewUnitObject(state.unit);
      newUnit.isFavouriteLoading = true;
      emit((FavouriteIconUnitState(newUnit)));
      ApiResponse apiResponse = await unitRepository.removeFromFavourite(newUnit.id!);
      await handleResponse(
          result: apiResponse,
          onSuccess: () async {
            Unit newUnit = Unit.createNewUnitObject(state.unit);
            newUnit.isFavouriteLoading = false;
            emit((FavouriteIconUnitState(newUnit)));
            if (newUnit.uiIsFavourite!) {
              add(AddToFavouriteEvent());
            } else {
              unit.uiIsFavourite = false;
              unit.isFavourite = false;
              unit.isFavouriteLoading = false;
              FavouriteUnitsSingleTone().removeFromList(unit.id!);
            }
          },
          onFailed: () {
            Unit newUnit = Unit.createNewUnitObject(state.unit);
            newUnit.isFavouriteLoading = false;
            emit((FavouriteIconUnitState(newUnit)));
          });
    }
  }


  @override
  void update() {
    Unit newUnit = Unit.createNewUnitObject(state.unit);
    FavouriteUnitsSingleTone().updateUnit(newUnit);
    add(UpdateFavouriteUnitEvent(newUnit));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }
}
