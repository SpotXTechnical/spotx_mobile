import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotx/base/base_bloc.dart';
import 'package:spotx/data/remote/unit/i_unit_repository.dart';
import 'package:spotx/data/remote/unit/model/offer_entity.dart';
import 'package:spotx/data/remote/unit/model/unit_response_entity.dart';
import 'package:spotx/favourite_observing/favourite_list_observer.dart';
import 'package:spotx/favourite_observing/favourite_units_single_tone.dart';
import 'package:spotx/utils/network/api_response.dart';

import 'offers_event.dart';
import 'offers_state.dart';

class OffersBloc extends BaseBloc<OffersEvent, OffersState> implements FavouriteListObserver {
  OffersBloc(this.unitRepository) : super( const OffersState()) {
    FavouriteUnitsSingleTone().subscribe(this);
    on<GetOffersUnits>(_getOffersUnits);
    on<LoadMoreOffersUnits>(_loadMoreOffersUnits);
    on<UpdateOffersUnitsEvent>(_updateOffersState);
  }

  _updateOffersState(UpdateOffersUnitsEvent event, Emitter<OffersState> emit) async {
    emit(state.copyWith(
      offersList: event.offers
    ));
  }

  int page = 1;
  final IUnitRepository unitRepository;

  _getOffersUnits(GetOffersUnits event, Emitter<OffersState> emit) async {
    await initiateList(emit);
  }

  FutureOr<void> initiateList(Emitter<OffersState> emit) async {
    emit(state.copyWith(isLoading: true, hasMore: false));
    ApiResponse apiResponse = await unitRepository.getOffers(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<OfferEntity> offersUnits = apiResponse.data.data;
            for (var offer in offersUnits) {
              offer.addDayToEnd();
            }
            bool hasMore = apiResponse.data.meta!.total! > offersUnits.length;
            emit(state.copyWith(hasMore: hasMore, offersList: offersUnits, isLoading: false));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            emit(const OffersState());
          }
        });
  }

  FutureOr<void> _loadMoreOffersUnits(LoadMoreOffersUnits event, Emitter<OffersState> emit) async {
    page++;
    ApiResponse apiResponse = await unitRepository.getOffers(page);
    handleResponse(
        result: apiResponse,
        onSuccess: () {
          if (apiResponse.data != null) {
            List<OfferEntity> offersUnits = apiResponse.data.data;
            for (var offer in offersUnits) {
              offer.addDayToEnd();
            }
            List<OfferEntity> allOffersUnits = [...?state.offersList, ...offersUnits];
            var meta = apiResponse.data.meta!;
            bool hasMore = meta.currentPage! < meta.lastPage!;
            emit(state.copyWith(hasMore: hasMore, offersList: allOffersUnits));
          }
        },
        onFailed: () {
          if (apiResponse.error != null) {
            showErrorMsg(apiResponse.error?.errorMsgKey ?? "Some thing Error has been happened");
          }
        });
  }

  @override
  void update() {
    List<Unit> unitsList = List.empty(growable: true);
    state.offersList?.forEach((element) {
      unitsList.add(element.unit!);
    });
    List<Unit> newUnitList = Unit.createNewUnitList(unitsList);
    FavouriteUnitsSingleTone().updateUnitsList(newUnitList);
    List<OfferEntity> newOffersList = createNewOfferList(newUnitList, state.offersList);
    add(UpdateOffersUnitsEvent(newOffersList));
  }

  @override
  Future<void> close() {
    FavouriteUnitsSingleTone().unSubscribe(this);
    return super.close();
  }

  List<OfferEntity> createNewOfferList(List<Unit> newUnitList, List<OfferEntity>? offersList) {
    List<OfferEntity> newOffersList = List.empty(growable: true);
    if (offersList != null && offersList.isNotEmpty) {
      newUnitList.asMap().forEach((key, value) {
        OfferEntity currentOffer = offersList[key];
        newOffersList.add(OfferEntity(
            from: currentOffer.from,
            to: currentOffer.to,
            price: currentOffer.price,
            createdAt: currentOffer.createdAt,
            unitId: currentOffer.unitId,
            unit: value));
      });
    }
    return newOffersList;
  }
}